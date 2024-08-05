//
//  ResultsViewModel.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 5.8.24..
//

import Foundation

@MainActor
class ResultsViewModel: ObservableObject {
    enum Constants {
        static let dateString = "2024-08-05"
    }
    
    @Published var items: [ResultItem] = []
    let service: DrawService
    
    init(service: DrawService) {
        self.service = service
        fetchItems()
    }
    
    func fetchItems(){
        Task { [weak self] in
            guard let self = self else {
                return
            }
            self.items = try await self.service.getDraws(for: Constants.dateString)
        }
    }
    func resultItem(from resultModel: ResultModel) -> ResultItem {
        let drawItem = DrawItem(drawTime: resultModel.drawTime,
                                drawId: resultModel.drawId)
        
        let ballItems = resultModel.winningNumbers.list.map {
            BallItem(id: $0, isSelected: true)
        }
        
        return ResultItem(draw: drawItem, balls: ballItems)
    }
}

struct ResultItem {
    let draw: DrawItem
    let balls: [BallItem]
}
