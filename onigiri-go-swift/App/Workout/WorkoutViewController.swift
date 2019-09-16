//
//  WorkoutViewController.swift
//  onigiri-go-swift
//
//  Created by Sho Kawasaki on 2019/09/16.
//  Copyright © 2019 Sho Kawasaki. All rights reserved.
//

import Foundation

import UIKit

class WorkoutViewController: UIViewController {

    let backButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: view design
        self.view.backgroundColor = UIColor.blue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc private func stopWorkout(sender: UIButton) {
        print("Press stop workout button from \(sender)")
    }
}
