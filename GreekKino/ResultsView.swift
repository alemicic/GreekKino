//
//  ResultsView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 5.8.24..
//

import SwiftUI


@MainActor
class ResultsViewModel: ObservableObject {
    @Published var items: [DrawModel] = []
    
    init() {
        fetchItems()
    }
    
    func fetchItems(){
        Task { [weak self] in
            self?.items = try await Client<DrawEndpoint>().request1(.upcomingDraws)
        }
    }
}


//struct ResultsView: View {
//    var body: some View {
//        BallsView()
//    }
//}
