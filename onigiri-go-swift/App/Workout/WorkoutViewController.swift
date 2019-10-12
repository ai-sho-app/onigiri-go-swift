//
//  WorkoutViewController.swift
//  onigiri-go-swift
//
//  Created by Sho Kawasaki on 2019/09/16.
//  Copyright © 2019 Sho Kawasaki. All rights reserved.
//

import Foundation
import UICircularProgressRing

import UIKit

class WorkoutViewController: UIViewController {

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
        button.frame = CGRect(x:0, y:0, width:100, height:100)
        button.center = self.view.center
        button.setTitle("back!", for: .normal)
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(pressStopWorkout(sender:)))
        longGesture.minimumPressDuration = 0.5
        button.addGestureRecognizer(longGesture)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: view design
        self.view.backgroundColor = UIColor.white

        view.addSubview(progressRing)
        // TODO: button design
        view.addSubview(stopWorkoutButton)

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
}
