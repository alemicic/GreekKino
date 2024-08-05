//
//  HomeRouter.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 4.8.24..
//

import Foundation
import SwiftUI

enum ScreenNavigation: Hashable {
    case draw(drawModel: DrawModel)
    
    func hash(into hasher: inout Hasher) {
        switch self {
            case .draw(let value):
                hasher.combine(value)
        }
    }
}

protocol HomeRoutable {
    func presentDrawScreen(drawModel: DrawModel)
}

class Router: ObservableObject {
    @Published var homeNavigationStack: [ScreenNavigation] = []
}

extension Router: HomeRoutable {
    func presentDrawScreen(drawModel: DrawModel) {
        homeNavigationStack.append(.draw(drawModel: drawModel))
    }
}
