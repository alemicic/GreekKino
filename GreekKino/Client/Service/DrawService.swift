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
    
    init(client: Client<DrawEndpoint>) {
        self.client = client
    }
    
    func getUpcomingDraws() async throws -> [DrawItem] {
        let drawModels: [DrawModel] = try await client.request(.upcomingDraws)
        
        let drawItems: [DrawItem] = drawModels.compactMap { [weak self] model in
            guard let self = self else { return nil }
            
            return mapDrawModelToItem(model: model)
        }
        
        return drawItems
    }
    
    func getDraws(for dateString: String) async throws -> [ResultItem] {
        let contentModel: [ContentModel] = try await client.request(.drawDate(from: dateString, to: dateString))
        
        let resultItems: [ResultItem] = contentModel.first?.content.compactMap { [weak self] model in
            guard let self = self else { return nil }
            
            return mapResultModelToItem(model: model)
        } ?? []
        
        return resultItems
    }
    
    func mapDrawModelToItem(model: DrawModel) -> DrawItem {
        DrawItem(drawTime: model.drawTime, drawId: model.drawId)
    }
    
    func mapResultModelToItem(model: ResultModel) -> ResultItem {
        let drawItem = DrawItem(drawTime: model.drawTime,
                                drawId: model.drawId)
        
        let ballItems = model.winningNumbers.list.map {
            BallItem(id: $0, isSelected: true)
        }
        
        return ResultItem(draw: drawItem, balls: ballItems)
    }
}
