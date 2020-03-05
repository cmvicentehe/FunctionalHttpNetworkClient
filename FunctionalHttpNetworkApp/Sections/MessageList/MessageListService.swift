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
    func deleteMessage(with idMessage: String)
}

protocol MessageListServiceOutput: class {
    func messages(_ messages: [Message])
    func messageDeleted()
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
        let decoder = CustomJSONDecoder()
        self.networkClient.performRequest(for: messageListResource,
                                          type: type,
                                          decoder: decoder)
    }
    
    func deleteMessage(with idMessage: String) {
        let deleteEndPoint = Constants.Services.Endpoints.deleteMessage
        let placeholder = Constants.Services.Endpoints.messageIdPlaceholder
        let endPoint = deleteEndPoint.replacingOccurrences(of: placeholder,
                                                           with: idMessage)
        let deleteMessageResource = DeleteMessageResource(endPoint: endPoint)
        let type = EmptyResponse.self
        let decoder = CustomJSONDecoder()
        self.networkClient.performRequest(for: deleteMessageResource,
                                          type: type,
                                          decoder: decoder)
    }
}

extension MessageListService: NetworkClientOutput {
    func outputResult<OutputResult>(_ outputResult: OutputResult, for apiResource: ApiResource) {
        if apiResource is MessageListResource {
            guard let messages = outputResult as? [Message] else {
                print("Output result is not of expected type")
                return
            }
            self.interactor?.messages(messages)
        } else if apiResource is DeleteMessageResource {
            self.interactor?.messageDeleted()
        }
    }
    
    func error<ServiceError>(_ error: ServiceError, for apiResource: ApiResource) {
        self.interactor?.error(error)
    }
}
