//
//  ResultModel.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 5.8.24..
//

import Foundation

struct ContentModel: Model {
    let content: [ResultModel]
    
    enum Keys: String, CodingKey {
        case content = "content"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.content = try container.decodeIfPresent([ResultModel].self, forKey: .content, fallback: [])
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(self.content, forKey: .content)
    }
}

struct ResultModel: Model {
    let gameId: Int
    let drawId: Int
    let drawTime: Double
    let winningNumbers: WinningNumbers
    
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
        self.winningNumbers = try container.decodeIfPresent(WinningNumbers.self, forKey: .winningNumbers, fallback: WinningNumbers(list: []))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(self.gameId, forKey: .gameId)
        try container.encode(self.drawId, forKey: .drawId)
        try container.encode(self.drawTime, forKey: .drawTime)
        try container.encode(self.winningNumbers, forKey: .winningNumbers)
    }
}

struct WinningNumbers: Model {
    let list: [Int]
    
    enum Keys: String, CodingKey {
        case list = "list"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.list = try container.decodeIfPresent([Int].self, forKey: .list, fallback: [])
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(self.list, forKey: .list)
    }
    
    public init(list: [Int]) {
        self.list = list
    }
}
