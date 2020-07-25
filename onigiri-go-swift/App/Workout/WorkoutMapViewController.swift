//
//  WorkoutMapViewController.swift
//  onigiri-go-swift
//
//  Created by Sho Kawasaki on 2019/10/15.
//  Copyright © 2019 Sho Kawasaki. All rights reserved.
//
// 参考: https://medium.com/@MissionKao/add-a-mapview-in-ios-app-without-storyboard-swift-7f73cbeada36

import Foundation

import UIKit
import MapKit
import CoreLocation

class WorkoutMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var mapView: MKMapView?
    var locationManager: CLLocationManager?
    //The range (meter) of how much we want to see arround the user's location
    let distanceSpan: Double = 500

    lazy var workoutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "btn_workout"), for: .normal)
        button.frame = CGRect(x:50, y:700, width:100, height:100)
        button.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: view design
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.white

        self.mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: (self.window?.frame.width)!, height: (self.window?.frame.height)!))
        self.mapView?.mapType = MKMapType.standard
        self.view.addSubview(self.mapView!)
        self.mapView?.delegate = self

        self.locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            print("initialize location manager")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }

        // TODO: button design
        self.view.addSubview(workoutButton)
    }

    override func viewDidAppear(_ animated: Bool) {
        self.locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            print("initialize location manager")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        if let mapView = self.mapView {
            let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: self.distanceSpan, longitudinalMeters: self.distanceSpan)
            mapView.setRegion(region, animated: true)
            mapView.showsUserLocation = true
        }

        let latitude = oldLocation.coordinate.latitude
        let longitude = oldLocation.coordinate.longitude

        print("latitude: \(latitude)\nlongitude: \(longitude)")
    }

    private func locationManager(_ manager: CLLocationManager, didUpdateLocation location: CLLocation) {
        if let mapView = self.mapView {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: self.distanceSpan, longitudinalMeters: self.distanceSpan)
            mapView.setRegion(region, animated: true)
            mapView.showsUserLocation = true
        }

        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

        print("latitude: \(latitude)\nlongitude: \(longitude)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("locationManager notDetermined")
            self.locationManager?.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            print("locationManager authorizedWhenInUse")
            self.locationManager?.startUpdatingLocation()
            break
        case .authorizedAlways:
            print("locationManager authorizedAlways")
            self.locationManager?.startUpdatingLocation()
            break
        case .restricted:
            print("locationManager restricted")
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            print("locationManager denied")
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            print("locationManager default")
            break
        }
    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        let location:CLLocationCoordinate2D
//            = CLLocationCoordinate2DMake(35.68154,139.752498)
//
//        mapView.setCenter(location,animated: true)
//
//        // 縮尺を設定
//        var region :MKCoordinateRegion = mapView.region
//        region.center = location
//        region.span.latitudeDelta = 0.02
//        region.span.longitudeDelta = 0.02
//
//        mapView.setRegion(region, animated: true)
//
//        // 表示タイプを航空写真と地図のハイブリッドに設定
//        mapView.mapType = MKMapType.hybrid
//        // mapView.mapType = MKMapType.standard
//        // mapView.mapType = MKMapType.satellite
//    }

    @objc private func back(sender: UIButton) {
        print("Press back workout button from \(sender)")
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
