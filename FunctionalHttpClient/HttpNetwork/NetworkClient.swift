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
    func outputResult<OutputResult>(_ outputResult: OutputResult, for apiResource: ApiResource)
    func error<ServiceError>(_ error: ServiceError, for apiResource: ApiResource)
}

public enum ServiceError: Error {
    case info(Int)
    case clientError(Int)
    case serverError(Int)
    case redirection(Int)
    case invalidResponse
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
            let json = try? JSONSerialization.jsonObject(with: dataNotNil,
                                                         options: .allowFragments),
            let output = try? JSONDecoder().decode(Output.self, from: dataNotNil) else {
            return self.manageHttpStatus(for: response)
        }
        Logger.shared.logDebug("RESPONSE")
        Logger.shared.logDebug("JSON: \(json)")

        return Future.pure(Result.success(output))
    }

    private func createEmptyResponse<Output: Codable>() -> Future<Result<Output, ServiceError>> {
        guard let emptyResponse = EmptyResponse() as? Output else {
            Logger.shared.logError("Error casting empty response")
            return Future.pure(Result.error(.invalidResponse))
        } // Search for better option than returning error when casting fails
        let result = Result<Output, ServiceError>.success(emptyResponse)
        let future = Future.pure(result)
        return future
    }

    private func manageHttpStatus<Output: Codable>
        (for response: ApiResponseProtocol?) -> Future<Result<Output, ServiceError>> {
        guard let responseNotNil = response else { return Future.pure(Result.error(.unknownError)) }
        Logger.shared.logDebug("HTTP STATUS")
        let status = responseNotNil.status
        switch status {
        case .info(let code):
            Logger.shared.logInfo("RESPONSE with <INFO> status and code \(code)")
            return self.createEmptyResponse()
        case .success:
            Logger.shared.logInfo("RESPONSE with <SUCCESS> status")
            return self.createEmptyResponse()
        case .clientError(let code):
            Logger.shared.logInfo("RESPONSE with <CLIENT ERROR> status and code \(code)")
            return Future.pure(Result.error(.clientError(code)))
        case .redirection(let code):
            Logger.shared.logInfo("RESPONSE with <REDIRECTION ERROR> status and code \(code)")
            return Future.pure(Result.error(.redirection(code)))
        case .serverError(let code):
            Logger.shared.logInfo("RESPONSE with <SERVER ERROR> status and code \(code)")
           return Future.pure(Result.error(.serverError(code)))
        case .unknown:
            Logger.shared.logInfo("RESPONSE with <UNKNOWN ERROR> status")
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
                        Logger.shared.logDebug("\(value)")
                        self.networkClientOutput?.outputResult(value, for: resource)
                    case .error(let error):
                        Logger.shared.logDebug(" --- ERROR: -- ")
                        Logger.shared.logDebug("\(error)")
                        self.networkClientOutput?.error(error, for: resource)
                    }
            }
        }
}
