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

protocol MessageListServiceOutput {
    
}

struct MessageListService {
    var networkCient: NetworkClientInput
}

extension MessageListService: MessageListServiceInput {
    func retrieveMssages() {
        self.networkCient.performMessageListRequest()
    }
}
