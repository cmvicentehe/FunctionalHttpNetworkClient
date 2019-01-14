//
//  DeleteMessageResource.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Manuel Vicente Herrero on 05/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation
import FunctionalHttpClient

struct DeleteMessageResource {
    var endPoint: String
    var method: FunctionalHttpClient.Method {
       return .delete 
    }
}

extension DeleteMessageResource: ApiResource {}
