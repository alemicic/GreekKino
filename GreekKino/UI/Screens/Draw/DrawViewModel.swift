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
        static let dateMonthHourMin = "dd.MM. HH.mm"
        static let hoursMinutesSeconds = "HH:mm:ss"
    }
    
    let item: DrawItem
    @Published var balls: [BallItem] = []
    let formatter: CustomDateFormatter
    
    var selectedCount: Int {
        balls.filter { $0.isSelected }.count
    }
    
    var drawTimeString: String {
        formatter.dateString(from: item.drawTime, dateFormat: Constants.dateMonthHourMin)
    }
    
    var countDown: String {
        formatter.countDown(from: item.drawTime, dateFormat: Constants.hoursMinutesSeconds)
    }
    
    init(item: DrawItem, balls: [BallItem] = [], formatter: CustomDateFormatter = CustomDateFormatter()) {
        self.item = item
        self.formatter = formatter
        self.balls = balls.isEmpty ? generateBalls() : balls
    }
    
    func generateBalls() -> [BallItem] {
        Constants.ballsRange.map { BallItem(id: $0, isSelected: false) }
    }
}
