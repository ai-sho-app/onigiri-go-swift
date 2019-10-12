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

    let MAX_COUNT = 3
    var workoutTimer: Timer?

    lazy var timerCount: Int = {
        return MAX_COUNT
    }()

    lazy var timerText: UITextView = {
        let textview = UITextView()
        textview.frame = CGRect(x:0, y:0, width:100, height:100)
        textview.backgroundColor = UIColor.themeOrange
        textview.center = self.view.center
        textview.text = String(timerCount)
        return textview
    }()

    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "btn_workout"), for: .normal)
        button.frame = CGRect(x:0, y:0, width:100, height:100)
        button.center = self.view.center
        button.setTitle("back!", for: .normal)
        button.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // timer start
        workoutTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTimer), userInfo: nil, repeats: true)

        // TODO: view design
        self.view.backgroundColor = UIColor.themeOrange
        // TODO: replace text to image
        view.addSubview(timerText)
        // TODO: button design
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
