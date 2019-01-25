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
    case info
    case clientError
    case serverError
    case redirection
    case unknownError
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
            return self.manageHttpStatus(for: response)
        }

        return Future.pure(Result.success(output))
    }

    private func manageHttpStatus<Output: Codable>
        (for response: ApiResponseProtocol?) -> Future<Result<Output, ServiceError>> {
        guard let responseNotNil = response else { return Future.pure(Result.error(.unknownError)) }

        let status = responseNotNil.status
        switch status {
        case .info:
            #warning("TODO: Info status should be considerated an error?")
            return Future.pure(Result.error(.info))
        case .success:

             #warning("TODO: Important! Delete force cast and search for a mechanism without using generics")
            // swiftlint:disable force_cast
            let emptyResponse: Output = EmptyResponse() as! Output
            let result = Result<Output, ServiceError>.success(emptyResponse)
            let future = Future.pure(result)
             // swiftlint:enable force_cast
            return future
        case .clientError:
            return Future.pure(Result.error(.clientError))
        case .redirection:
            return Future.pure(Result.error(.redirection))
        case .serverError:
           return Future.pure(Result.error(.serverError))
        case .unknown:
            return Future.pure(Result.error(.unknownError))
        }
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
