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
}

struct NewMessageWireframe {}

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
}
