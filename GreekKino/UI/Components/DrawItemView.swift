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
    }
    
    var item: DrawItem
    var action: (DrawItem) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Text(time())
            Spacer()
            Text(countDown())
        }
        .padding(Constants.padding)
        .background(.black)
        .foregroundStyle(.white)
        .border(.white)
        .onTapGesture {
            action(item)
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
        dateFormatter.dateFormat = "HH:mm:ss"
        let delta = Date.now.timeIntervalSince1970.distance(to: item.drawTime / 1000)
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: delta))
        return dateString
    }
}
