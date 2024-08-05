//
//  DrawViewModel.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 5.8.24..
//

import Foundation

struct DrawItem: Hashable {
    let drawTime: Double
    let drawId: Int
}

class DrawViewModel: ObservableObject {
    enum Constants {
        static let ballsRange = (1...80)
    }
    let item: DrawItem
    @Published var balls: [BallItem] = []
    
    var selectedCount: Int {
        balls.filter { $0.isSelected }.count
    }
    
    init(item: DrawItem, balls: [BallItem] = []) {
        self.item = item
        self.balls = balls.isEmpty ? generateBalls() : balls
    }
    
    func generateBalls() -> [BallItem] {
        Constants.ballsRange.map { BallItem(id: $0, isSelected: false) }
    }
}
