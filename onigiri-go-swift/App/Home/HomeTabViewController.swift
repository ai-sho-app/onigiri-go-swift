//
//  HomeTabViewController.swift
//  onigiri-go-swift
//
//  Created by Sho Kawasaki on 2019/07/20.
//  Copyright © 2019 Sho Kawasaki. All rights reserved.
//

import UIKit

class HomeTabViewController: UITabBarController {
    
    let homeVC: HomeViewController = {
        let vc = HomeViewController()
        vc.view.backgroundColor = UIColor.white
        vc.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:"Home.png"), tag: 1)
        return vc
    }()

    let reportVC: ReportViewController = {
        let vc = ReportViewController()
        vc.view.backgroundColor = UIColor.white
        vc.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:"Report.png"), tag: 1)
        return vc
    }()

    lazy var workoutButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ButtonStart"), for: .normal)
        // button.center = self.tabBar.center
        let width: CGFloat = 110
        let height: CGFloat = 100
        button.frame = CGRect(x: (self.tabBar.frame.width - width) / 2,
                              y: self.view.frame.height - self.tabBar.frame.height - height / 1.5,
                              width: width, height: height)
        button.addTarget(self, action: #selector(pressWorkoutButton(sender:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setViewControllers([homeVC, reportVC], animated: false)
        // selected tab color
        self.tabBar.tintColor = UIColor.themeOrange

        self.view.addSubview(workoutButton)
    }

    @objc private func pressWorkoutButton(sender: UIButton) {
        print("Press workout button from \(sender)")
        let prepareWorkoutVC = PrepareWorkoutViewController()
        self.present(prepareWorkoutVC, animated: true, completion: nil)
    }
}
