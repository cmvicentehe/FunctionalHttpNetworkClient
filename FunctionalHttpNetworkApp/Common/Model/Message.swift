//
//  Message.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Manuel Vicente Herrero on 04/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation

struct Message {
    let id: String
    let username: String
    let content: String
    let date: String
}

extension Message: Codable {}
