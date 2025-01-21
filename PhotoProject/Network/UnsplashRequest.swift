//
//  UnsplashRequest.swift
//  PhotoProject
//
//  Created by 정인선 on 1/21/25.
//

import Foundation
import Alamofire

enum UnsplashRequest {
    case search(params: SearchParams)
    case statistic(id: String)
    case topic(id: String)
    
    var endPoint: URLConvertible {
        switch self {
        case .search:
            return APIURL.UNSPLASH_BASE_URL + "search/photos"
        case .statistic(let id):
            return APIURL.UNSPLASH_BASE_URL + "photos/\(id)/statistics"
        case .topic(let id):
            return APIURL.UNSPLASH_BASE_URL + "topics/\(id)/photos"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        switch self {
        case .search(let params):
            return params.toParameters
        case .statistic(_):
            return nil
        case .topic(_):
            return nil
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(APIKEY.UNSPLASH_ACCESS_KEY)"]
    }
}

struct SearchParams: Encodable {
    let perPage = 20
    var page = 1
    var orderBy = Order.relevant
    var searchText = ""
    var color: Color?
    
    enum CodingKeys: String, CodingKey {
        case perPage = "per_page"
        case page
        case orderBy = "order_by"
        case searchText = "query"
        case color
    }
}

