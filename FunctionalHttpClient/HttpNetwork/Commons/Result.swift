//
//  Result.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Vicente on 16/5/18.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation

public enum Result<Value, ErrorInfo: Error> {
    case success(Value)
    case error(ErrorInfo)
    
    /******************************* FUNCTOR *******************************/
    public func map<Output>(transform: (Value) -> Output) -> Result<Output, ErrorInfo> {
        return self.flatMap { .success(transform($0)) }
    }
    
    /******************************* MONAD *******************************/
    public func flatMap<Output>(transform: (Value) -> Result<Output, ErrorInfo>) -> Result<Output, ErrorInfo> {
        switch self {
        case .success(let value):
            return transform(value)
        case .error(let reason):
            return .error(reason)
        }
    }
    
    /******************************* APPLICATIVE *******************************/
    public static func pure(_ value: Value) -> Result<Value, ErrorInfo> {
        return .success(value)
    }
    
    public func apply<Output>(resultValueToOutput: Result<(Value) -> Output, ErrorInfo>) -> Result<Output, ErrorInfo> {
        return self.flatMap { input  in
            resultValueToOutput.map { transform in
                transform(input)
            }
        }
    }
}
