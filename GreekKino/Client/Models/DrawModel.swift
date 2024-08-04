//
//  GameModel.swift
//  StrongFoundation
//
//  Created by Aleksandar Micic on 3.8.24..
//

import Foundation

struct DrawModel: Model, Hashable {
    let gameId: Int
    let drawId: Int
    let drawTime: Double
    let status: String
    let drawBreak: Int
    let visualDraw: Int
//    let pricePoints: PricePoints
//    let prizeCategories: [String]
//    let wagerStatistics: WagerStatistics
    
    enum Keys: String, CodingKey {
        case gameId = "gameId"
        case drawId = "drawId"
        case drawTime = "drawTime"
        case status = "status"
        case drawBreak = "drawBreak"
        case visualDraw = "visualDraw"
//        case pricePoints = "pricePoints"
//        case prizeCategories = "prizeCategories"
//        case wagerStatistics = "wagerStatistics"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        self.gameId = try container.decodeIfPresent(Int.self, forKey: .gameId, fallback: -1)
        self.drawId = try container.decodeIfPresent(Int.self, forKey: .drawId, fallback: -1)
        self.drawTime = try container.decodeIfPresent(Double.self, forKey: .drawTime, fallback: -1)
        self.status = try container.decodeIfPresent(String.self, forKey: .status, fallback: "")
        self.drawBreak = try container.decodeIfPresent(Int.self, forKey: .drawBreak, fallback: -1)
        self.visualDraw = try container.decodeIfPresent(Int.self, forKey: .visualDraw, fallback: -1)
//        self.pricePoints = try container.decodeIfPresent(PricePoints.self, forKey: .pricePoints, fallback: PricePoints(addOn: [], amount: 0))
//        self.prizeCategories = try container.decodeIfPresent([String].self, forKey: .prizeCategories, fallback: [])
//        self.wagerStatistics = try container.decodeIfPresent(WagerStatistics.self, forKey: .wagerStatistics, fallback: WagerStatistics(columns: -1, wagers: -1, addOn: []))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(self.gameId, forKey: .gameId)
        try container.encode(self.drawId, forKey: .drawId)
        try container.encode(self.drawTime, forKey: .drawTime)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.drawBreak, forKey: .drawBreak)
        try container.encode(self.visualDraw, forKey: .visualDraw)
//        try container.encode(self.pricePoints, forKey: .pricePoints)
//        try container.encode(self.prizeCategories, forKey: .prizeCategories)
//        try container.encode(self.wagerStatistics, forKey: .wagerStatistics)
    }
}

//struct PricePoints: Codable, Equatable {
//    let addOn: [AddOn]
//    let amount: Double
//    
//    enum Keys: String, CodingKey {
//        case addOn = "addOn"
//        case amount = "amount"
//    }
//}
//
//struct WagerStatistics: Codable, Equatable {
//    let columns: Int
//    let wagers: Int
//    let addOn: [AddOn]
//    
//    enum Keys: String, CodingKey {
//        case columns = "columns"
//        case wagers = "wagers"
//        case addOn = "addOn"
//    }
//}
//
//struct AddOn: Codable, Equatable {
//    let amount: Double
//    let gameType: String
//    
//    enum Keys: String, CodingKey {
//        case amount = "amount"
//        case gameType = "gameType"
//    }
//}


//// Example usage (if JSON data is available)
//if let jsonData = jsonString.data(using: .utf8) {
//    do {
//        let gameData = try JSONDecoder().decode(GameData.self, from: jsonData)
//        print(gameData)
//    } catch {
//        print("Failed to decode JSON: \(error)")
//    }
//}
