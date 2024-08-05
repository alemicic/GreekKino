//
//  AssetService.swift
//  StrongFoundation
//
//  Created by Aleksandar Micic on 3.8.24..
//

import Foundation

protocol DrawServiceProtocol {
    func getUpcomingDraws() async throws -> [DrawModel]
    func getDraws(for dateString: String) async throws -> [ResultModel]
}

class DrawService: DrawServiceProtocol, ObservableObject {
    let client: Client<DrawEndpoint>
    
    init(client: Client<DrawEndpoint>) {
        self.client = client
    }
    
    func getUpcomingDraws() async throws -> [DrawModel] {
        try await client.request(.upcomingDraws)
    }
    
    func getDraws(for dateString: String) async throws -> [ResultModel] {
        let results: [ContentModel] = try await client.request(.drawDate(from: dateString, to: dateString))
        
        return results.first?.content ?? []
    }
}
