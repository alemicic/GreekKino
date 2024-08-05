//
//  DrawItemView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 5.8.24..
//

import SwiftUI

struct DrawItemView: View {
    enum Constants {
        static let padding: CGFloat = 8
        static let rowsCount = 3
        static let hoursMinutes = "HH:mm"
        static let hoursMinutesSeconds = "HH:mm:ss"
    }
    
    @State var countDown = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let item: DrawItem
    let formatter: CustomDateFormatter
    let action: (DrawItem) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Text(formatter.dateString(from: item.drawTime,
                                      dateFormat: Constants.hoursMinutes))
            Spacer()
            Text(countDown)
                .onReceive(timer) { time in
                    countDown = formatter.countDown(from: item.drawTime, dateFormat: Constants.hoursMinutesSeconds)
                }
        }
        .padding(Constants.padding)
        .background(.black)
        .foregroundStyle(.white)
        .border(.white)
        .onTapGesture {
            action(item)
        }
    }
}
