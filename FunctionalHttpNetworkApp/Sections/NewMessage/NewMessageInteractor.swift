//
//  NewMessageInteractor.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Vicente on 22/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation

protocol NewMessageInteractorInput {
    var service: NewMessageServiceInput { get set }
    var presenter: NewMessageInteractorOutput? { get set }
    func sendMessage(by username: String, with content: String)
}

protocol NewMessageInteractorOutput {
    func messageSent()
    func error<ServiceError>(_ error: ServiceError)
}

class NewMessageInteractor {
    var service: NewMessageServiceInput
    var presenter: NewMessageInteractorOutput?

    init(service: NewMessageServiceInput) {
        self.service = service
    }
}

extension NewMessageInteractor: NewMessageInteractorInput {

    func sendMessage(by username: String, with content: String) {
        self.service.sendMessage(by: username, with: content)
    }
}

extension NewMessageInteractor: NewMessageServiceOutput {
    func messageSent() {
        self.presenter?.messageSent()
    }

    func error<ServiceError>(_ error: ServiceError) {
    }

}
