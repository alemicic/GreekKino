//
//  HomeViewModel.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 5.8.24..
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var items: [DrawItem] = []
    let service: DrawService
    
    init(service: DrawService) {
        self.service = service
        fetchItems()
    }
    
    func fetchItems(){
        Task { [weak self] in
            guard let self = self else {
                return
            }
            self.items = try await self.service.getUpcomingDraws()
        }
    }
}
