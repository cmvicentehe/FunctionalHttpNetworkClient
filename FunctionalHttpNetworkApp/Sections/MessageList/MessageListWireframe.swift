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
    func showMessageList() -> MessageListVC?
    func showAlert(with title: String, message: String, completion:(() -> Void)?)
}

struct MessageListWireframe {
    let navigationController: UINavigationController
}

extension MessageListWireframe: MessageListWireframeInput {
    func showMessageList() -> MessageListVC? {
        guard let messageListVC =  UIStoryboard(
            name: Constants.Identifiers.Storyboards.home,
            bundle: Bundle.main)
            .instantiateViewController(
                withIdentifier: Constants.Identifiers.ViewControllers.messageListVC)
            as? MessageListVC else {
            print("Invalid message list view controller")
            return nil
        }
        let tableViewViewModel = MessagesTableViewViewModel()
        let networkSession = NetworkSession()
        let networkClient = NetworkClient(networkSession: networkSession)
        let service = MessageListService(networkClient: networkClient)
        let interactor = MessageListInteractor(service: service)
        let presenter = MessageListPresenter(view: messageListVC,
                                             interactor: interactor,
                                             wireframe: self,
                                             tableViewViewModel: tableViewViewModel)
        tableViewViewModel.presenter = presenter
        networkClient.networkClientOutput = service
        interactor.presenter = presenter
        presenter.interactor = interactor
        service.interactor = interactor
        messageListVC.presenter = presenter
        
        return messageListVC
    }

    func showAlert(with title: String, message: String, completion:(() -> Void)?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)

            let alertAction = UIAlertAction(title: NSLocalizedString("ok", comment: ""),
                                            style: .default) { _ in
                                                guard let completionNotNil = completion else {
                                                    return
                                                }
                                                completionNotNil()
            }

            alertController.addAction(alertAction)
            self.navigationController.show(alertController, sender: self)
        }
    }
}
