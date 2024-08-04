//
//  AssetsEndpoint.swift
//  StrongFoundation
//
//  Created by Aleksandar Micic on 3.8.24..
//

import Foundation

enum DrawEndpoint: APIEndpoint {
    case upcomingDraws
    case getDraw//(Int)
    case drawDate
    
    var baseURL: URL? {
        return URL(string: "https://api.opap.gr/draws/v3.0/1100")
    }
    
    var path: String {
        switch self {
            case .upcomingDraws:
                return "/upcoming/20"
            case .getDraw://(let drawId):
                return "/{drawId}"
            case .drawDate:
                return "/draw-date/{fromDate}/{toDate}"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .upcomingDraws, .getDraw, .drawDate:
                return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
            case .upcomingDraws, .getDraw, .drawDate:
                return ["" : ""]
        }
    }
}
