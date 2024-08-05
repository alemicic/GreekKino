//
//  Client.swift
//  StrongFoundation
//
//  Created by Aleksandar Micic on 3.8.24..
//

import Foundation
import Combine

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType) async throws -> [T]
}

actor Client<EndpointType: APIEndpoint>: APIClient, ObservableObject {
    func request<T: Decodable>(_ endpoint: EndpointType) async throws -> [T] {
        
        var path: String = endpoint.path
        
        endpoint.parameters?.forEach { key, value in
            path = path.replacingOccurrences(of: key, with: (value as? String) ?? "" )
        }
        
        let url = endpoint.baseURL!.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        var fetchedData: [T] = []
        do {
            fetchedData = try JSONDecoder().decode([T].self, from: try mapResponse(response: (data,response)))
        } catch {
            fetchedData = [try JSONDecoder().decode(T.self, from: try mapResponse(response: (data,response)))]
        }
        return fetchedData
    }
    
    func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }
        
        switch httpResponse.statusCode {
            case 200..<300:
                return response.data
            default:
                throw APIError.invalidResponse
        }
    }
}
