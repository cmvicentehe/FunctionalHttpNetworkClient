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
    func retrieveMessages()
}

protocol MessageListInteractorOutput {
    func messages(messages: [Message])
    func error<ServiceError>(_ error: ServiceError)
}

class MessageListInteractor {
    var service: MessageListServiceInput
    
    init(service: MessageListServiceInput) {
        self.service = service
    }
}

extension MessageListInteractor: MessageListInteractorInput {
    func retrieveMessages() {
        self.service.retrieveMssages()
    }
}

extension MessageListInteractor: MessageListInteractorOutput {
    func messages(messages: [Message]) {
    }
    
    func error<ServiceError>(_ error: ServiceError) {
    }
}
