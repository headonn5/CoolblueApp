//
//  AppError.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import Foundation

enum AppError: Error {
    case parseError
    case voidResponseError
    case invalidURL
    case responseError(error: Error)
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .parseError:
            return Constants.parseError
        case .voidResponseError:
            return Constants.voidResponseError
        case .invalidURL:
            return Constants.invalidURL
        case .responseError(let error):
            return error.localizedDescription
        }
    }
}
