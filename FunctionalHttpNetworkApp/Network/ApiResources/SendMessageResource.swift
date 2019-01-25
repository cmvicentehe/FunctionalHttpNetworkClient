//
//  SendMessageResource.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Manuel Vicente Herrero on 04/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation
import FunctionalHttpClient

struct SendMessageResource {
    let username: String
    let content: String
    var endPoint: String
    var method: FunctionalHttpClient.Method {
        return .post
    }
    
    var bodyParameters: [AnyHashable: Any]? {
        return [Constants.Keys.username: self.username,
                    Constants.Keys.content: self.content]
    }
    
}

extension SendMessageResource: ApiResource {}
