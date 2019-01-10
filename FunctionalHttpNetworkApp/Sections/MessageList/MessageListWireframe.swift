//
//  MessageListWireframe.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Manuel Vicente Herrero on 08/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import UIKit
import FunctionalHttpClient

protocol MessageListWireframeInput {
    func showMessageListVC() -> MessageListVC?
}

struct MessageListWireframe {
}

extension MessageListWireframe: MessageListWireframeInput {
    func showMessageListVC() -> MessageListVC? {
        
        guard let messageListVC =  UIStoryboard(name: Constants.Identifiers.Storyboards.main, bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.Identifiers.viewControllers.messageListVC) as? MessageListVC else {
            print("Invalid message list view controller")
            return nil
        }
        
        let networkSession = NetworkSession()
        let networkClient = NetworkClient(sessionWrapper: networkSession)
        let service = MessageListService(networkCient: networkClient)
        let interactor = MessageListInteractor(service: service)
        
        let presenter = MessageListPresenter(view: messageListVC,
                                             interactor: interactor,
                                             wireframe: self)

        messageListVC.presenter = presenter
        
        return messageListVC
    }
}
