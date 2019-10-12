//
//  HomeTabViewController.swift
//  onigiri-go-swift
//
//  Created by Sho Kawasaki on 2019/07/20.
//  Copyright © 2019 Sho Kawasaki. All rights reserved.
//

import UIKit

class HomeTabViewController: UITabBarController {
    var HomeVC = HomeViewController()
    var ReportVC = ReportViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        HomeVC.view.backgroundColor = UIColor.white
        HomeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:"footer_home_active.png"), tag: 1)

        ReportVC.view.backgroundColor = UIColor.white
        ReportVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:"footer_record.png"), tag: 1)

        self.setViewControllers([HomeVC, ReportVC], animated: false)
        self.tabBar.tintColor = UIColor.themeOrange

        self.view.bringSubviewToFront(self.tabBar)
        self.addCenterButton()
//        if let unselectedImage = UIImage(named: "ButtonStart"), let selectedImage = UIImage(named: "ButtonStart") {
//            self.addCenterButton(unselectedImage: unselectedImage, selectedImage: selectedImage, target: self, action: #selector(buttonEvent(sender:)), allowSwitch: true)
//        }
    }

    private func addCenterButton() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ButtonStart"), for: .normal)
        // button.center = self.tabBar.center
        let width: CGFloat = 110
        let height: CGFloat = 100
        button.frame = CGRect(x: (self.tabBar.frame.width - width) / 2,
                              y: self.view.frame.height - self.tabBar.frame.height - height / 1.5,
                              width: width, height: height)

        self.view.addSubview(button)
        self.view.bringSubviewToFront(button)

        button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
    }

    @objc
    private func buttonEvent(sender: UIButton) {
        print("ボタンが押された")
        print("このメソッドを呼び出したボタンの情報: \(sender)")
    }
}
