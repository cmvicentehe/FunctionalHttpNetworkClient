//
//  HomeWireframe.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Vicente on 09/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import UIKit

protocol HomeWireframeInput {
   func showTabBar()
}

struct HomeWireframe {
    let window: UIWindow
}

extension HomeWireframe: HomeWireframeInput {
    func showTabBar() {
        guard let homeVC: HomeVC = UIStoryboard(
            name: Constants.Identifiers.Storyboards.main,
            bundle: Bundle.main)
            .instantiateViewController(withIdentifier: Constants.Identifiers.ViewControllers.homeVC)
            as? HomeVC else { return print("Invalid home view controller ") }
        
        let messageListWireframe = MessageListWireframe()
        guard let messagesVC = messageListWireframe.showMessageListVC(),
        let newMessageVC = UIStoryboard(
            name: Constants.Identifiers.Storyboards.main,
            bundle: Bundle.main)
            .instantiateViewController(withIdentifier: Constants.Identifiers.ViewControllers.newMessageVC)
            as? NewMessageVC
        else { return print("Invalid view controller ") }
        
        homeVC.viewControllers = [messagesVC, newMessageVC]
        self.window.rootViewController = homeVC
    }
}
