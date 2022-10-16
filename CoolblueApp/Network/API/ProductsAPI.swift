//
//  API.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation

struct ProductsAPI: APIResourceProtocol {
    private let query: String
    private let page: String
    
    var isFullURL: Bool {
        return false
    }
    var path: String {
        return "/ios-assignment/search"
    }
    var httpMethod: RequestType {
        return .get
    }
    var queryParameters: [String : Any] {
        return [
            "query": query,
            "page": page
        ]
    }
    
    init(query: String, page: Int) {
        self.query = query
        self.page = String(page)
    }
}
