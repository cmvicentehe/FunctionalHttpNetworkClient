//
//  NetworkClient.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Manuel Vicente Herrero on 07/10/2018.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation
import FunctionalHttpClient

protocol NetworkClientInput {
    func performMessageListRequest()
}

enum MessageListServiceError: Error {
    case invalidResponse
}

struct NetworkClient {
    let sessionWrapper: NetworkSession
    
    private func futureMessageResponse(for apiResource: ApiResource) -> Future<ApiResponseProtocol?> {
        return Future.async(self.sessionWrapper.performRequest(for: apiResource))
    }
    
    private func futureMessageResult(for response: ApiResponseProtocol?) -> Future<Result<[Message], MessageListServiceError>> {
        guard let dataNotNil = response?.data,
        let messages = try? JSONDecoder().decode([Message].self, from: dataNotNil) else {
            print("Data is nil")
            return  Future.pure(Result.error(MessageListServiceError.invalidResponse))
        }
       
        return Future.pure(Result.success(messages))
    }
}

extension NetworkClient: NetworkClientInput {
    func performMessageListRequest() {
        let messageListResource = MessageListResource(endPoint: Constants.Services.Endpoints.messages)
        Future.pure(messageListResource)
            .flatMap(self.futureMessageResponse)
            .flatMap(self.futureMessageResult).runAsync { result in
            // Notify Result got
        }
       }

}
