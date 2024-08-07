//
//  GameModel.swift
//  StrongFoundation
//
//  Created by Aleksandar Micic on 3.8.24..
//

import Foundation

struct DrawModel: Model {
    let gameId: Int
    let drawId: Int
    let drawTime: Double
    let status: String
    let drawBreak: Int
    let visualDraw: Int
    
    enum Keys: String, CodingKey {
        case gameId = "gameId"
        case drawId = "drawId"
        case drawTime = "drawTime"
        case status = "status"
        case drawBreak = "drawBreak"
        case visualDraw = "visualDraw"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.gameId = try container.decodeIfPresent(Int.self, forKey: .gameId, fallback: -1)
        self.drawId = try container.decodeIfPresent(Int.self, forKey: .drawId, fallback: -1)
        self.drawTime = try container.decodeIfPresent(Double.self, forKey: .drawTime, fallback: -1)
        self.status = try container.decodeIfPresent(String.self, forKey: .status, fallback: "")
        self.drawBreak = try container.decodeIfPresent(Int.self, forKey: .drawBreak, fallback: -1)
        self.visualDraw = try container.decodeIfPresent(Int.self, forKey: .visualDraw, fallback: -1)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(self.gameId, forKey: .gameId)
        try container.encode(self.drawId, forKey: .drawId)
        try container.encode(self.drawTime, forKey: .drawTime)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.drawBreak, forKey: .drawBreak)
        try container.encode(self.visualDraw, forKey: .visualDraw)
    }
}
