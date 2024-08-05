//
//  ResultModel.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 5.8.24..
//

import Foundation

struct ResultModel: Model {
    let gameId: Int
    let drawId: Int
    let drawTime: Double
    let winningNumbers: [Int]
    
    enum Keys: String, CodingKey {
        case gameId = "gameId"
        case drawId = "drawId"
        case drawTime = "drawTime"
        case winningNumbers = "winningNumbers"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.gameId = try container.decodeIfPresent(Int.self, forKey: .gameId, fallback: -1)
        self.drawId = try container.decodeIfPresent(Int.self, forKey: .drawId, fallback: -1)
        self.drawTime = try container.decodeIfPresent(Double.self, forKey: .drawTime, fallback: -1)
        self.winningNumbers = try container.decodeIfPresent([Int].self, forKey: .winningNumbers, fallback: [])
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(self.gameId, forKey: .gameId)
        try container.encode(self.drawId, forKey: .drawId)
        try container.encode(self.drawTime, forKey: .drawTime)
        try container.encode(self.winningNumbers, forKey: .winningNumbers)
    }
}

