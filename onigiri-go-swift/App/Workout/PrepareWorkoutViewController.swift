//
//  PrepareViewController.swift
//  onigiri-go-swift
//
//  Created by Sho Kawasaki on 2019/09/16.
//  Copyright © 2019 Sho Kawasaki. All rights reserved.
//

import Foundation

import UIKit

class PrepareWorkoutViewController: UIViewController {

    var workoutTimer: Timer?
    let MAX_COUNT = 3
    var timerCount: Int = 0
    let timerText = UITextView()
    let backButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: view design
        self.view.backgroundColor = UIColor.themeOrange

        // TODO: Start Timer
        timerCount = MAX_COUNT
        workoutTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTimer), userInfo: nil, repeats: true)

        // TODO: replace text to image
        timerText.frame = CGRect(x:0, y:0, width:100, height:100)
        timerText.backgroundColor = UIColor.themeOrange
        timerText.center = self.view.center
        timerText.text = String(timerCount)
        view.addSubview(timerText)

        // TODO: button design
        backButton.setImage(UIImage(named: "ButtonStart"), for: .normal)
        backButton.frame = CGRect(x:0, y:0, width:100, height:100)
        backButton.center = self.view.center
        backButton.setTitle("back!", for: .normal)

        backButton.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
        view.addSubview(backButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc private func back(sender: UIButton) {
        print("Press back button from \(sender)")
        self.dismiss(animated: true, completion: nil)
        self.workoutTimer?.invalidate()
    }

    @objc private func countTimer() {
        print("Count timer. timerCount: \(timerCount)")
        timerCount -= 1
        if timerCount >= 0 {
            timerText.text = String(timerCount)
        }
        if timerCount == 0 {
            print("Start workout!")
            self.workoutTimer?.invalidate()
            timerCount = MAX_COUNT
            let workoutVC = WorkoutViewController()
            workoutVC.modalTransitionStyle = .crossDissolve
            self.present(workoutVC, animated: true, completion: nil)
        }
    }
}
