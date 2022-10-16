//
//  MockAPIResource.swift
//  CoolblueAppTests
//
//  Created by Nishant Paul on 16/10/22.
//

@testable import CoolblueApp

struct MockApiResource: APIResourceProtocol {
    var isFullURL: Bool
    var queryParameters: [String : Any]
    let path: String
    let httpMethod: RequestType
    
    init(path: String,
         httpMethod: RequestType = .get,
         isFullURL: Bool = false,
         queryParameters: [String: Any] = [:]) {
        self.path = path
        self.httpMethod = httpMethod
        self.isFullURL = isFullURL
        self.queryParameters = queryParameters
    }
}
