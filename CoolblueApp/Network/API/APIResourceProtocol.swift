//
//  APIResourceProtocol.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation

enum RequestType: String {
    case get = "GET"
}

protocol APIResourceProtocol {
    var path: String { get }
    var httpMethod: RequestType { get }
    var isFullURL: Bool { get }
    var queryParameters: [String: Any] { get }
    
    func fetchURLRequest() throws -> URLRequest
}

extension APIResourceProtocol {
    
    func fetchURLRequest() throws -> URLRequest {
        
        // Build URL
        let url = isFullURL ? URL(string: self.path) : URL(string: Constants.urlString + self.path)
        guard let url = url,
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            // Handler incorrect url Error
            throw AppError.invalidURL
        }
        
        var urlQueryItems: [URLQueryItem] = []
        queryParameters.forEach { (key, value) in
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlQueryItems.append(queryItem)
        }
        urlComponents.queryItems = urlQueryItems
        
        // Create Request
        guard let fullURL = urlComponents.url else {
            // Handler incorrect url Error
            throw AppError.invalidURL
        }
        var request = URLRequest(url: fullURL)
        request.httpMethod = self.httpMethod.rawValue
        
        return request
    }
}
