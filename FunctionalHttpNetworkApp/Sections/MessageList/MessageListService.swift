//
//  MessageListService.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Manuel Vicente Herrero on 08/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation

protocol MessageListServiceInput {
    var networkCient: NetworkClientInput { get set }
    func retrieveMssages()
}


struct MessageListService {
    var networkCient: NetworkClientInput
}

extension MessageListService: MessageListServiceInput {
    func retrieveMssages() {
        let messageListResource = MessageListResource(endPoint: Constants.Services.Endpoints.messages)
        let type = [Message].self
        self.networkCient.performRequest(for: messageListResource, type: type)
    }
}

extension MessageListService: NetworkClientOutput {
    func outputResult<OutputResult>(_ outputResult: OutputResult) {
        
    }
    
    func error<ServiceError>(_ error: ServiceError) {
        
    }
}
