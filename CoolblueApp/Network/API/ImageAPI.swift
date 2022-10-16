//
//  ImageAPI.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation

struct ImageAPI: APIResourceProtocol {
    let urlString: String
    var isFullURL: Bool {
        return true
    }
    var path: String {
        return urlString
    }
    var httpMethod: RequestType {
        return .get
    }
    var queryParameters: [String : Any] {
        return [:]
    }
}
