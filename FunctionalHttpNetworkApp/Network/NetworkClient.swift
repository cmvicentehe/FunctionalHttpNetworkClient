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

struct NetworkClient {
    let sessionWrapper: NetworkSession
    
    private func futureMessageResponse(for apiResource: ApiResource) -> Future<ApiResponseProtocol?> {
        return Future.async(self.sessionWrapper.performRequest(for: apiResource))
    }
}

extension NetworkClient: NetworkClientInput {
    func performMessageListRequest() {
        let messageListResource: ApiResource = MessageListResource(endPoint: Constants.Services.Endpoints.messages)
        Future.pure(messageListResource)
            .map(self.futureMessageResponse).runAsync { futureResponse in
                futureResponse.runAsync { response in
                    
                    guard let dataNotNil = response?.data else { return print("Data is nil") }
                    let jsonObject = try? JSONSerialization.jsonObject(with: dataNotNil, options: JSONSerialization.ReadingOptions.allowFragments)
                    print(jsonObject)
                    let messages = try? JSONDecoder().decode([Message].self, from: dataNotNil)
                    #warning("Implement this using Future and try to add a Future chain that performs all the operations")
                }
        }
        
        
    }
}
