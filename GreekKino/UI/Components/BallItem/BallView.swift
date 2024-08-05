//
//  BallView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 5.8.24..
//

import SwiftUI

struct BallItem: Identifiable {
    let id: Int
    var isSelected: Bool
}

struct BallView: View {
    enum Constants {
        static let padding: CGFloat = 8
        static let gridItemSize: CGFloat = 20
        static let gridColumnSpacing: CGFloat = 24
        static let gridRowSpacing: CGFloat = 12
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 5
        static let width: CGFloat = 30
        static let height: CGFloat = 30
        static let screenWidth: CGFloat = UIScreen.main.bounds.size.width - 2 * padding
        static let drawTimeText = "Vreme izvlacenja: "
        static let drawCountText = "Broj kola: "
    }
    
    let rows: [GridItem]
    let viewModel: DrawViewModel
    
    init(rowsCount: Int, viewModel: DrawViewModel) {
        self.rows = Array(repeating: GridItem(.fixed(Constants.gridItemSize), spacing: Constants.gridColumnSpacing), count: rowsCount)
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(Constants.drawTimeText)\(viewModel.drawTimeString)")
            Text("\(Constants.drawCountText)\(viewModel.item.drawId)")
            
            LazyHGrid(rows: rows, spacing: Constants.gridRowSpacing) {
                ForEach(Array(zip(viewModel.balls.indices, viewModel.balls)), id: \.0) { index, ball in
                    Button(action: {
                        viewModel.balls[index].isSelected.toggle()
                    }) {
                        Text("\(ball.id)")
                            .padding(Constants.padding)
                            .overlay(
                                encircleView(ball: ball)
                            )
                    }
                }
            }
            .padding(Constants.padding)
            .frame(width: Constants.screenWidth)
            Divider()
        }
    }
    
    @ViewBuilder
    func encircleView(ball: BallItem) -> some View {
        if ball.isSelected {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(.red, lineWidth: Constants.lineWidth)
                .frame(width: Constants.width, height: Constants.height)
        }
    }
}
