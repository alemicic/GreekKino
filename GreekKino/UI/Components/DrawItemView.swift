//
//  DrawItemView.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 5.8.24..
//

import SwiftUI

struct DrawItemView: View {
    var item: DrawModel
    var action: (DrawModel) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Text(time())
            Spacer()
            Text(countDown())
        }
        .padding(8)
        .background(.black)
        .foregroundStyle(.white)
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
        dateFormatter.dateFormat = "mm:ss"
        let delta = Date.now.timeIntervalSince1970.distance(to: item.drawTime / 1000)
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: delta))
        return dateString
    }
}
