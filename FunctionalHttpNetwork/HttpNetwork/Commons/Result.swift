//
//  Result.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Vicente on 16/5/18.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation

enum Result<Value, ErrorInfo: Error> {
    case succuess(Value)
    case error(ErrorInfo)
}
