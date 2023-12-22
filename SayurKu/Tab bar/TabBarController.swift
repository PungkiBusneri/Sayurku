//
//  TabBarController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 05/12/23.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .systemGray6
        self.tabBar.tintColor = .systemPink
        self.tabBar.unselectedItemTintColor = .black
        setupTabs()
    }
    private func setupTabs () {
        
        let home  = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeViewController())
        
        let order  = self.createNav(with: "Pesanan", and: UIImage(systemName: "tray"), vc: PesananViewController())
        
        let profil  = self.createNav(with: "Saya", and: UIImage(systemName: "person.circle.fill"), vc: SayaViewController())
        
        self.setViewControllers([home, order, profil], animated: true)
    }
    
    private func createNav (with title: String, and image: UIImage?, vc: UIViewController ) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
}

