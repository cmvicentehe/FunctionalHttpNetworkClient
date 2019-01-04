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
     func performMessageListRequest(for endPoint: String)
}

struct NetworkClient {
    let sessionWrapper: NetworkSession
}

extension NetworkClient: NetworkClientInput {
    func performMessageListRequest(for endPoint: String) {
        let _ = MessageListResource(endPoint: endPoint)
        
    }
}
