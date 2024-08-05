//
//  ResultsView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 5.8.24..
//

import SwiftUI

@MainActor
class ResultsViewModel: ObservableObject {
    enum Constants {
        static let dateString = "2024-08-05"
    }
    
    @Published var items: [ResultModel] = []
    
    init() {
        fetchItems()
    }
    
    func fetchItems(){
        Task { [weak self] in
            let results: [ContentModel] = try await Client<DrawEndpoint>().request(.drawDate(from: Constants.dateString,
                                                                              to: Constants.dateString))
            
            self?.items = results.first?.content ?? []
            
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

struct ResultsView: View {
    @StateObject var viewModel: ResultsViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(viewModel.items, id: \.drawId) { item in
                    let result = viewModel.resultItem(from: item)
                    BallsView(rowsCount: 3, viewModel: DrawViewModel(item: result.draw, balls: result.balls))
                }
            }
        }.clipped()
    }
}
