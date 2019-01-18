//
//  NetworkClient.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Manuel Vicente Herrero on 07/10/2018.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation

public protocol NetworkClientInput {
     var networkClientOutput: NetworkClientOutput? { get set }
     func performRequest<Output>(for resource: ApiResource, type: Output.Type) where Output: Codable
}

public protocol NetworkClientOutput {
    func outputResult<OutputResult>(_ outputResult: OutputResult)
    func error<ServiceError>(_ error: ServiceError)
}

public enum ServiceError: Error {
    case invalidResponse
}

public class NetworkClient {
    public let networkSession: NetworkSessionInput
    public var networkClientOutput: NetworkClientOutput?
    
    public init(networkSession: NetworkSessionInput) {
        self.networkSession = networkSession
    }
    
    private func futureResponse(for apiResource: ApiResource) -> Future<ApiResponseProtocol?> {
        return Future.async(self.networkSession.performRequest(for: apiResource))
    }
    
    private func futureResult<Output: Codable>
        (for response: ApiResponseProtocol?)
        -> Future<Result<Output, ServiceError>> {
        guard let dataNotNil = response?.data,
        let output = try? JSONDecoder().decode(Output.self, from: dataNotNil) else {
            print("Data is nil")
            return  Future.pure(Result.error(ServiceError.invalidResponse))
        }

        return Future.pure(Result.success(output))
    }
}

extension NetworkClient: NetworkClientInput {
    public func performRequest<Output>(for resource: ApiResource, type: Output.Type) where Output: Codable {
            Future.pure(resource)
                .flatMap(self.futureResponse)
                .flatMap(self.futureResult)
                .runAsync { (result: Result<Output, ServiceError>) in
                    switch result {
                    case .success(let value):
                        self.networkClientOutput?.outputResult(value)
                    case .error(let error):
                        self.networkClientOutput?.error(error)
                    }
            }
        }
}
