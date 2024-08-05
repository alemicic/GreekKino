//
//  AssetService.swift
//  StrongFoundation
//
//  Created by Aleksandar Micic on 3.8.24..
//

import Foundation

protocol DrawServiceProtocol {
    func getUpcomingDraws() async throws -> [DrawItem]
    func getDraws(for dateString: String) async throws -> [ResultItem]
}

class DrawService: DrawServiceProtocol, ObservableObject {
    let client: Client<DrawEndpoint>
    let mapper: DrawMapper
    
    init(client: Client<DrawEndpoint>, mapper: DrawMapper = DrawMapper()) {
        self.client = client
        self.mapper = mapper
    }
    
    func getUpcomingDraws() async throws -> [DrawItem] {
        let drawModels: [DrawModel] = try await client.request(.upcomingDraws)
        
        let drawItems: [DrawItem] = drawModels.compactMap { [weak self] model in
            guard let self = self else { return nil }
            
            return self.mapper.mapDrawModelToItem(model: model)
        }
        
        return drawItems
    }
    
    func getDraws(for dateString: String) async throws -> [ResultItem] {
        let contentModel: [ContentModel] = try await client.request(.drawDate(from: dateString, to: dateString))
        
        let resultItems: [ResultItem] = contentModel.first?.content.compactMap { [weak self] model in
            guard let self = self else { return nil }
            
            return self.mapper.mapResultModelToItem(model: model)
        } ?? []
        
        return resultItems
    }
}
