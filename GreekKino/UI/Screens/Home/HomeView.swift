//
//  HomeView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 3.8.24..
//

import SwiftUI

struct HomeView: View {
    enum Constants {
        static let titleText = "Grcki kino"
        static let drawTimeText = "Vreme izvlacenja"
        static let timeRemainingText = "Preostalo za uplatu"
        static let padding: CGFloat = 8
    }
    
    @StateObject var viewModel: HomeViewModel
    var router: HomeRoutable
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(Constants.titleText)
                .padding(Constants.padding)
            
            HStack {
                Text(Constants.drawTimeText)
                Spacer()
                Text(Constants.timeRemainingText)
            }
            .padding(Constants.padding)
        }
        .foregroundStyle(.white)
        .background(.gray)
        Spacer()
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(viewModel.items, id: \.drawId) { item in
                    DrawItemView(item: item, action: router.presentDrawScreen)
                }
            }
        }
    }
}
