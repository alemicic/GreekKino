//
//  CouponView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 4.8.24..
//

import SwiftUI

struct BallItem: Identifiable {
    let id: Int
    var isSelected: Bool
}

class DrawViewModel: ObservableObject {
    let item: DrawModel
    @Published var balls: [BallItem] = []
    
    var selectedCount: Int {
        balls.filter { $0.isSelected }.count
    }
    init(item: DrawModel) {
        self.item = item
        self.balls = generateBalls()
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
                Text("B.K.      1      2    3     4     5      6       7   ")
                Text("Kvota  3.75   14   65   275   1350   6500   25000   ")
                Text("Broj izabranih kuglica: \(viewModel.selectedCount)")
                Text("Vreme izvlacenja: \(viewModel.item.drawTime)")
                Text("Broj kola: \(viewModel.item.drawId)")
                Text("Preostalo vreme za uplatu: \(viewModel.item.drawTime)")
                
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
            }
            .frame(width: UIScreen.main.bounds.size.width)
            Spacer()
        }
    }
    
    @ViewBuilder
    func encircleView(ball: BallItem) -> some View {
        if ball.isSelected {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.red, lineWidth: 5)
        }
    }
}
