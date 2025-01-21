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
    static func networkRequest<T: Decodable>(url: URLConvertible,
                                             method: HTTPMethod,
                                             parameters: Parameters? = nil,
                                             encoding: ParameterEncoding = URLEncoding(destination: .queryString),
                                             headers: HTTPHeaders? = nil,
                                             type: T.Type,
                                             completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoding: encoding,  headers: headers)
            .validate(statusCode: [200])
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
