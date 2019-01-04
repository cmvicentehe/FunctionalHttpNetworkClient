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
    let message: Message
    var endPoint: String
    var method: FunctionalHttpClient.Method {
        get { return .post }
    }
    
    var bodyParameters: [AnyHashable : Any]? {
        get {
            return [Constants.Keys.username: self.message.username,
                    Constants.Keys.content : self.message.content]
        }
    }
    
}

extension SendMessageResource: ApiResource {}
