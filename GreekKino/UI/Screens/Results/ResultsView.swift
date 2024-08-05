//
//  ResultsView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 5.8.24..
//

import SwiftUI

struct ResultsView: View {
    enum Constants {
        static let padding: CGFloat = 8
        static let rowsCount = 3
    }
    
    @StateObject var viewModel: ResultsViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(viewModel.items, id: \.draw.drawId) { item in
                    BallView(rowsCount: Constants.rowsCount, viewModel: DrawViewModel(item: item.draw, balls: item.balls))
                }
            }
            .padding(Constants.padding)
        }.clipped()
    }
}
