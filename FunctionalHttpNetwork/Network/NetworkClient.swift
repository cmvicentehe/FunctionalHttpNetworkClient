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
     func performRequest(at endPoint: String)
}

struct NetworkClient {
    let session: NetworkSession

}

extension NetworkClient: NetworkClientInput {
    func performRequest(at endPoint: String) {
        
    }
}
