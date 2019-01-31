//
//  NewMessageWireframe.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Vicente on 22/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation
import FunctionalHttpClient

protocol NewMessageWireframeInput {
    func showNewMessage() -> NewMessageVC?
    func showAlert(with title: String, message: String, completion:(() -> Void)?)
}

struct NewMessageWireframe {
    let navigationController: UINavigationController
}

extension NewMessageWireframe: NewMessageWireframeInput {
    func showNewMessage() -> NewMessageVC? {
        guard let newMessageVC =  UIStoryboard(
            name: Constants.Identifiers.Storyboards.home,
            bundle: Bundle.main)
            .instantiateViewController(
                withIdentifier: Constants.Identifiers.ViewControllers.newMessageVC)
            as? NewMessageVC else {
                print("Invalid new message view controller")
                return nil
        }
        let networkSession = NetworkSession()
        let networkClient = NetworkClient(networkSession: networkSession)
        let service = NewMessageService(networkClient: networkClient)
        let interactor = NewMessageInteractor(service: service)
        let presenter = NewMessagePresenter(view: newMessageVC,
                                             interactor: interactor,
                                             wireframe: self)
        networkClient.networkClientOutput = service
        interactor.presenter = presenter
        presenter.interactor = interactor
        service.interactor = interactor
        newMessageVC.presenter = presenter

        return newMessageVC
    }

    func showAlert(with title: String, message: String, completion: (() -> Void)?) {
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
            self.navigationController.present(alertController,
                                              animated: true,
                                              completion: nil)
        }
    }
}
