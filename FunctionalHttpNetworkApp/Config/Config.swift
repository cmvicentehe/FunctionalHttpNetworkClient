//
//  Config.swift
//  FunctionalHttpNetworkApp
//
//  Created by Carlos Manuel Vicente Herrero on 04/01/2019.
//  Copyright © 2019 cmvicentehe. All rights reserved.
//

import Foundation

struct Config {
    static let scheme: String = Bundle.main.object(forInfoDictionaryKey: Constants.Keys.scheme) as? String ?? ""
    static let hostUrl: String = Bundle.main.object(forInfoDictionaryKey: Constants.Keys.hostUrl) as? String ?? ""
    static let port: String? = Bundle.main.object(forInfoDictionaryKey: Constants.Keys.port) as? String
}
