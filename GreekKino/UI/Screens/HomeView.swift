//
//  HomeView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 3.8.24..
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var items: [DrawModel] = []
    let service: DrawService
    
    init(service: DrawService) {
        self.service = service
        fetchItems()
    }
    
    func fetchItems(){
        Task { [weak self] in
            if let self = self {
                self.items = try await self.service.getUpcomingDraws()
            }
        }
    }
}

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    var router: HomeRoutable
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Grcki kino")
            .padding(8)
            
        HStack {
            Text("Vreme izvlacenja")
            Spacer()
            Text("Preostalo za uplatu")
        }
        .padding(8)
        }
        .foregroundStyle(.white)
        .background(.gray)
        Spacer()
        ScrollView(showsIndicators: false) {
            ForEach(viewModel.items, id: \.drawId) { item in
                DrawItemView(item: item, action: router.presentDrawScreen)
            }
        }
    }
}
