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
        HomeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:"Home.png"), tag: 1)
        
        ReportVC.view.backgroundColor = UIColor.white
        ReportVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:"Report.png"), tag: 1)

        self.setViewControllers([HomeVC, ReportVC], animated: false)
        self.tabBar.tintColor = UIColor.themeOrange
    }

}

