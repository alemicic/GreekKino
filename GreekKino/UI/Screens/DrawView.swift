//
//  CouponView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 4.8.24..
//

import SwiftUI

struct DrawItem {
    let drawTime: Double
    let drawId: Int
}

struct BallItem: Identifiable {
    let id: Int
    var isSelected: Bool
}

class DrawViewModel: ObservableObject {
    let item: DrawItem
    @Published var balls: [BallItem] = []
    
    var selectedCount: Int {
        balls.filter { $0.isSelected }.count
    }
    
    init(item: DrawModel, balls: [BallItem] = []) {
        self.item = DrawItem(drawTime: item.drawTime, drawId: item.drawId)
        self.balls = balls.isEmpty ? generateBalls() : balls
    }
    
    init(item: DrawItem, balls: [BallItem]) {
        self.item = item
        self.balls = balls
    }
    
    func generateBalls() -> [BallItem] {
        (1...80).map { BallItem(id: $0, isSelected: false) }
    }
}

struct DrawView: View {
    @StateObject var viewModel: DrawViewModel
    private var rows: [GridItem] {
        Array(repeating: GridItem(.fixed(20), spacing: 24), count: 10)
    }
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                Text("B.K./Kvota | 1/3.75 | 2/14 | 3/65 | 4/275 | 5/1350 | 6/6500 | 7/25000")
                Text("Broj izabranih kuglica: \(viewModel.selectedCount)")
                Text("Preostalo vreme za uplatu: \(viewModel.item.drawTime)")
                
                BallsView(rowsCount: 10, viewModel: viewModel)
            }
        }
    }
}

class BallsViewModel: ObservableObject {
    let item: DrawItem
    @Published var balls: [BallItem] = []
    
    var selectedCount: Int {
        balls.filter { $0.isSelected }.count
    }
    
    init(item: DrawItem, balls: [BallItem]) {
        self.item = item
        self.balls = balls
    }
}

struct BallsView: View {
    var rows: [GridItem]
    var viewModel: DrawViewModel
    init(rowsCount: Int, viewModel: DrawViewModel) {
        self.rows = Array(repeating: GridItem(.fixed(20), spacing: 24), count: rowsCount)
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Vreme izvlacenja: \(viewModel.item.drawTime)")
            Text("Broj kola: \(viewModel.item.drawId)")
            LazyHGrid(rows: rows, spacing: 12) {
                ForEach(Array(zip(viewModel.balls.indices, viewModel.balls)), id: \.0) { index, ball in
                    Button(action: {
                        viewModel.balls[index].isSelected.toggle()
                    }) {
                        Text("\(ball.id)")
                            .padding(8)
                            .overlay(
                                encircleView(ball: ball)
                            )
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.size.width)
            Divider()
        }
    }
    
    @ViewBuilder
    func encircleView(ball: BallItem) -> some View {
        if ball.isSelected {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.red, lineWidth: 5)
                .frame(width: 30, height: 30)
        }
    }
}
