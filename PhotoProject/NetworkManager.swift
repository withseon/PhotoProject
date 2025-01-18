//
//  NetworkManager.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import Foundation
import Alamofire
/*
 200 - OK    Everything worked as expected
 400 - Bad Request    The request was unacceptable, often due to missing a required parameter
 401 - Unauthorized    Invalid Access Token
 403 - Forbidden    Missing permissions to perform request
 404 - Not Found    The requested resource doesn’t exist
 500, 503    Something went wrong on our end
 */
enum NetworkManager {
    static func networkRequest<T: Decodable>(url: String, parameters: Parameters? = nil,
                                             headerDict: [String: String]? = nil, type: T.Type,
                                             completion: @escaping (Result<T, Error>) -> Void) {
        var headers: HTTPHeaders?
        if let headerDict {
            headers = HTTPHeaders(headerDict)
        }
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
