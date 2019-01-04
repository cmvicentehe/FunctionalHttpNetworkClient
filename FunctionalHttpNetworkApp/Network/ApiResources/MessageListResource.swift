//
//  MessageListResource.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Vicente on 19/12/2018.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation
import FunctionalHttpClient

struct MessageListResource {
    var endPoint: String
    var method: FunctionalHttpClient.Method {
        get {  return .get }
    }
}

extension MessageListResource: ApiResource {}
