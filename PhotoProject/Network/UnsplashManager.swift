//
//  UnsplashManager.swift
//  PhotoProject
//
//  Created by 정인선 on 1/23/25.
//

import Foundation
import Alamofire

enum UnsplashError: String, Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case wrongUnSplashSever
    case unknown
}

enum UnsplashManager {
    static func executeFetch<T: Decodable>(api: UnsplashRequest,
                                    type: T.Type,
                                    completion: @escaping (Result<T, UnsplashError>) -> Void) {
        NetworkManager.networkRequest(url: api.endPoint,
                                      method: api.method,
                                      parameters: api.parameters,
                                      headers: api.header,
                                      type: type) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                guard let statusCode = failure.responseCode else { return }
                let error = getUnsplashError(statusCode: statusCode)
                completion(.failure(error))
            }
        }
    }
}

extension UnsplashManager {
    private static func getUnsplashError(statusCode: Int) -> UnsplashError {
        switch statusCode {
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 500...:
            return .wrongUnSplashSever
        default:
            return .unknown
        }
    }

}
