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
        let future = Future.pure(messageListResource).flatMap(self.futureMessageResponse).runAsync { response in
            print("RESPOSE: \(response)")
            
            #warning("Implement and check if it is working")
        }
        
        
    }
}
