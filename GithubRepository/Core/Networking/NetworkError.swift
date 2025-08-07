//
//  NetworkError.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 07/08/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case serverError
    case decodingError(Error)
    case unknownError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The URL provided was invalid.", comment: "")
        case .serverError:
            return NSLocalizedString("A server error occurred. Please try again.", comment: "")
        case .decodingError(let error):
            return NSLocalizedString("Failed to decode the response: \(error.localizedDescription)", comment: "")
        case .unknownError(let error):
            return NSLocalizedString("An unknown error occurred: \(error.localizedDescription)", comment: "")
        }
    }
}
