//
//  NewMessageService.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Vicente on 22/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation
import FunctionalHttpClient

protocol NewMessageServiceInput {
    var networkClient: NetworkClientInput { get set }
    var interactor: NewMessageServiceOutput? { get set }
    func sendMessage(by username: String, with content: String)
}

protocol NewMessageServiceOutput: class {
    func messageSent()
    func error<ServiceError>(_ error: ServiceError)
}

class NewMessageService {
    var networkClient: NetworkClientInput
    weak var interactor: NewMessageServiceOutput?

    init(networkClient: NetworkClientInput) {
        self.networkClient = networkClient
    }
}

extension NewMessageService: NewMessageServiceInput {
    func sendMessage(by username: String, with content: String) {
        let sendMessageResource = SendMessageResource(username: username,
                                                      content: content,
                                                      endPoint: Constants.Services.Endpoints.sendMessage)
        self.networkClient.performRequest(for: sendMessageResource, type: EmptyResponse.self)
    }
}

extension NewMessageService: NetworkClientOutput {
    func outputResult<OutputResult>(_ outputResult: OutputResult) {
        self.interactor?.messageSent()
    }

    func error<ServiceError>(_ error: ServiceError) {
        self.interactor?.error(error)
    }
}
