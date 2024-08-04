//
//  AssetService.swift
//  StrongFoundation
//
//  Created by Aleksandar Micic on 3.8.24..
//

import Foundation
import Combine

protocol DrawServiceProtocol {
    func getUpcomingDraws() async throws -> AnyPublisher<[DrawModel], Error>
}

class DrawService: DrawServiceProtocol {
    let client = Client<DrawEndpoint>()
    
    func getUpcomingDraws() -> AnyPublisher<[DrawModel], Error> {
        return client.request(.upcomingDraws)
    }
}
