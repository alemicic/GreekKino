//
//  CouponView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 4.8.24..
//

import SwiftUI

struct DrawView: View {
    enum Constants {
        static let padding: CGFloat = 8
        static let gridItemSize: CGFloat = 20
        static let gridItemSpacing: CGFloat = 24
        static let rowsCount = 10
        static let quotaText = "B.K. / Kvota | 1 / 3.75 | 2 / 14 | 3 / 65 | 4 / 275 | 5 / 1350 | 6 / 6500 | 7 / 25000"
        static let ballsCountText = "Broj izabranih kuglica: "
        static let timeRemainingText = "Preostalo vreme za uplatu: "
    }
    
    @StateObject var viewModel: DrawViewModel
    @State var countDown = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var rows: [GridItem] {
        Array(repeating: GridItem(.fixed(Constants.gridItemSize),
                                  spacing: Constants.gridItemSpacing),
              count: Constants.rowsCount)
    }
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                Text(Constants.quotaText)
                Text("\(Constants.ballsCountText)\(viewModel.selectedCount)")
                Text("\(Constants.timeRemainingText)\(countDown)")
                    .onReceive(timer) { time in
                        countDown = viewModel.countDown
                    }
                
                BallView(rowsCount: Constants.rowsCount, viewModel: viewModel)
            }
            .padding(8)
        }
    }
}
