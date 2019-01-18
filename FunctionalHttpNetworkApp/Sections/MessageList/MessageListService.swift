//
//  MessageListService.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Manuel Vicente Herrero on 08/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation
import FunctionalHttpClient

protocol MessageListServiceInput {
    var networkClient: NetworkClientInput { get set }
    var interactor: MessageListServiceOutput? { get set }
    func retrieveMssages()
}

protocol MessageListServiceOutput: class {
    func messages(_ messages: [Message])
    func error<ServiceError>(_ error: ServiceError)
}

class MessageListService {
    var networkClient: NetworkClientInput
    weak var interactor: MessageListServiceOutput?
    
    init(networkClient: NetworkClientInput) {
        self.networkClient = networkClient
    }
}

extension MessageListService: MessageListServiceInput {
    func retrieveMssages() {
        let messageListResource = MessageListResource(endPoint: Constants.Services.Endpoints.messages)
        let type = [Message].self
        self.networkClient.performRequest(for: messageListResource, type: type)
    }
}

extension MessageListService: NetworkClientOutput {
    func outputResult<OutputResult>(_ outputResult: OutputResult) {
        guard let messages = outputResult as? [Message] else { return print("Output result is not of expected type") }
        self.interactor?.messages(messages)
    }
    
    func error<ServiceError>(_ error: ServiceError) {
        self.interactor?.error(error)
    }
}
