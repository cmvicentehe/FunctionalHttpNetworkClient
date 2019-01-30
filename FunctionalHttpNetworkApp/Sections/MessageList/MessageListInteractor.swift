//
//  MessageListInteractor.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Manuel Vicente Herrero on 08/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation

protocol MessageListInteractorInput {
    var service: MessageListServiceInput { get set }
    var presenter: MessageListInteractorOutput? { get set }
    func retrieveMessages()
    func deleteMessage(with idMessage: String)
}

protocol MessageListInteractorOutput: class {
    func messages(_ messages: [Message])
    func messageDeleted()
    func error<ServiceError>(_ error: ServiceError)
}

class MessageListInteractor {
    var service: MessageListServiceInput
    weak var presenter: MessageListInteractorOutput?
    
    init(service: MessageListServiceInput) {
        self.service = service
    }
}

extension MessageListInteractor: MessageListInteractorInput {
    func retrieveMessages() {
        self.service.retrieveMssages()
    }

    func deleteMessage(with idMessage: String) {
        self.service.deleteMessage(with: idMessage)
    }
}

extension MessageListInteractor: MessageListServiceOutput {
    func messages(_ messages: [Message]) {
        self.presenter?.messages(messages)
    }

    func messageDeleted() {
        self.presenter?.messageDeleted()
    }
    
    func error<ServiceError>(_ error: ServiceError) {
        self.presenter?.error(error)
    }
}
