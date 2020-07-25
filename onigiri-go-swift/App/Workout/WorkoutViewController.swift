//
//  WorkoutViewController.swift
//  onigiri-go-swift
//
//  Created by Sho Kawasaki on 2019/09/16.
//  Copyright © 2019 Sho Kawasaki. All rights reserved.
//

import Foundation
import UICircularProgressRing
import CoreLocation

import UIKit

class WorkoutViewController: UIViewController, CLLocationManagerDelegate {

    let workoutMapVC = WorkoutMapViewController()

    var _locationManager: CLLocationManager!

    // 歩行距離（メートル）
    var walkDistanceMeters: Double = 0;
    var beforeLatitude: CLLocationDegrees = 0;
    var beforeLongitude: CLLocationDegrees = 0;

    lazy var distanceText: UILabel = {
        let uiLabel = UILabel()
        uiLabel.frame = CGRect(x:100, y:100, width:100, height:50)
        uiLabel.backgroundColor = UIColor.themeOrange
        // uiLabel.center = self.view.center
        uiLabel.text = "0 m"
        return uiLabel
    }()

    lazy var progressRing: UICircularProgressRing = {
        var ring = UICircularProgressRing()
        ring.frame = CGRect(x: self.view.center.x - 50, y:self.view.center.y - 50, width:100, height:100)
        // ring.center = self.view.center
        ring.maxValue = 100
        ring.style = .ontop
        ring.gradientOptions = UICircularRingGradientOptions(startPosition: .bottom,
                                                             endPosition: .top,
                                                             colors: [UIColor.themeOrange],
                                                             colorLocations: [1.0])
        // progress to start from the top
        ring.startAngle = -90
        return ring
    }()

    lazy var stopWorkoutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "btn_stop"), for: .normal)
        button.frame = CGRect(x: 0, y:0, width:80, height:80)
        button.center = self.view.center
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(pressStopWorkout(sender:)))
        longGesture.minimumPressDuration = 0.5
        button.addGestureRecognizer(longGesture)
        return button
    }()

    lazy var mapButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "btn_map"), for: .normal)
        button.frame = CGRect(x:50, y:700, width: 80, height:80)
        button.addTarget(self, action: #selector(showMap(sender:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()

        // TODO: view design
        self.view.backgroundColor = UIColor.white

        view.addSubview(progressRing)
        // TODO: button design
        view.addSubview(stopWorkoutButton)
        view.addSubview(mapButton)

        view.addSubview(distanceText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc private func pressStopWorkout(sender: UILongPressGestureRecognizer) {
        // print("Press stop workout button from \(sender)")
        switch sender.state {
        case .began:
            self.progressRing.startProgress(to: 100, duration: 2.0) {
                print("Done animating!")
                // 移動距離計測stop
                self._locationManager.stopUpdatingLocation()
                // home画面に戻る
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        case .ended:
            self.progressRing.resetProgress()
        case .possible:
            break
        case .changed:
            break
        case .cancelled:
            break
        case .failed:
            break
        @unknown default:
            break
        }
    }

    @objc private func showMap(sender: UIButton) {
        print("Press show map button from \(sender)")
        workoutMapVC.modalTransitionStyle = .flipHorizontal
        self.present(workoutMapVC, animated: true, completion: nil)
    }


    private func setupLocationManager() {
        self._locationManager = CLLocationManager()
        guard case self._locationManager = self._locationManager else { return }
        self._locationManager.requestWhenInUseAuthorization()

        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            self._locationManager.delegate = self
            self._locationManager.distanceFilter = 10
            // 移動距離計測start
            self._locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude ?? 0
        let longitude = location?.coordinate.longitude ?? 0

        print("beforeLatitude: \(self.beforeLatitude) beforeLongitude: \(self.beforeLongitude)")
        print("latitude: \(latitude) longitude: \(longitude) walkDistance: \(self.walkDistanceMeters)")
        if latitude != 0 && longitude != 0 {
            if self.beforeLatitude != 0 && self.beforeLongitude != 0 {
                self.walkDistanceMeters += calcHubenyDistanceMeters(current: (self.beforeLatitude,self.beforeLongitude), target: (latitude,longitude))
                self.distanceText.text = String(ceil(self.walkDistanceMeters)) + " m"
            }
            self.beforeLatitude = latitude
            self.beforeLongitude = longitude
        }
    }

    private func calcHubenyDistanceMeters(current: (la: Double, lo: Double), target: (la: Double, lo: Double)) -> Double {
        // 緯度経度をラジアンに変換
        let currentLa   = current.la * Double.pi / 180
        let currentLo   = current.lo * Double.pi / 180
        let targetLa    = target.la * Double.pi / 180
        let targetLo    = target.lo * Double.pi / 180

        // 緯度差
        let radLatDiff = currentLa - targetLa

        // 経度差算
        let radLonDiff = currentLo - targetLo

        // 平均緯度
        let radLatAve = (currentLa + targetLa) / 2.0

        // 測地系による値の違い
        // 赤道半径
        // let a = 6378137.0  world
        let a = 6377397.155 // japan

        // 極半径
        // let b = 6356752.314140356 world
        let b = 6356078.963 // japan

        // 第一離心率^2
        let e2 = (a * a - b * b) / (a * a)

        // 赤道上の子午線曲率半径
        let a1e2 = a * (1 - e2)

        let sinLat = sin(radLatAve);
        let w2 = 1.0 - e2 * (sinLat * sinLat);

        // 子午線曲率半径m
        let m = a1e2 / (sqrt(w2) * w2);

        // 卯酉線曲率半径 n
        let n = a / sqrt(w2)

        // 算出
        let t1 = m * radLatDiff
        let t2 = n * cos(radLatAve) * radLonDiff
        let distance = sqrt((t1 * t1) + (t2 * t2))
        return distance
    }
}
