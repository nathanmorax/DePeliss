//
//  File.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//

import UIKit

class MainTabController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewControllers()
        configuteTabBar()
        
    }
    
    func setUpViewControllers() {
        viewControllers = [
            
            createNavigationController(for: HomeViewController(), title: "Home", imageName: "house"),
            createNavigationController(for: LibraryViewController(), title: "Library", imageName: "arrow.down.app.fill"),
            createNavigationController(for: SearchViewController(), title: "Search", imageName: "magnifyingglass"),
        ]
    }
    
    
    fileprivate func createNavigationController(for rootViewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.image =  UIImage(systemName: imageName)
        return navController
    }
    
    fileprivate func configuteTabBar() {
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .backgroundTabBar
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.purple
        ]
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        
        appearance.shadowColor = UIColor.black.withAlphaComponent(4)
        appearance.shadowImage = UIImage()
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.layer.borderWidth = 0
        
    }
    
    
}
