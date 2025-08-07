//
//  NetworkService.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 07/08/2025.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error>
}

struct NetworkService: NetworkServiceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error> {
        guard let url = endpoint.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url, timeoutInterval: 10.0)
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.serverError
                }
                let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print("Response Data: \(String(describing: result))")
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder.iso8601)
            .mapError { error -> NetworkError in
                print("Error: \(error.localizedDescription)")

                if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                } else if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.unknownError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

