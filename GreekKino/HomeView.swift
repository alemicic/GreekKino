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
    
    init() {
        fetchItems()
    }
    
    func fetchItems(){
        Task {
            self.items = try await Client<DrawEndpoint>().request1(.upcomingDraws)
            for i in items {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/YY - HH:mm:ss"
                let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: i.drawTime/1000))
            }
        }
        
    }
}

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
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
                DrawItemView(item: item)
            }
        }
    }
}

struct DrawItemView: View {
    var item: DrawModel
    
    var body: some View {
        HStack(spacing: 0) {
            Text(time())
            Spacer()
            Text(countDown())
        }
    }
    
    func time() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(item.drawTime / 1000)))
        return dateString
    }
    
    func countDown() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        let delta = Date.now.timeIntervalSince1970.distance(to: item.drawTime / 1000)
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: delta))
        return dateString
    }
}
