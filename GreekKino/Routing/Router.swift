//
//  HomeRouter.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 4.8.24..
//

import Foundation
import SwiftUI

enum ScreenNavigation: Hashable {
    case draw(drawItem: DrawItem)
    
    func hash(into hasher: inout Hasher) {
        switch self {
            case .draw(let value):
                hasher.combine(value)
        }
    }
}

protocol HomeRoutable {
    func presentDrawScreen(drawItem: DrawItem)
}

class Router: ObservableObject {
    @Published var homeNavigationStack: [ScreenNavigation] = []
}

extension Router: HomeRoutable {
    func presentDrawScreen(drawItem: DrawItem) {
        homeNavigationStack.append(.draw(drawItem: drawItem))
    }
}
