//
//  CustomDateFormatter.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 5.8.24..
//

import Foundation

struct CustomDateFormatter {
    let dateFormatter: DateFormatter
    
    init(dateFormatter: DateFormatter = DateFormatter()) {
        self.dateFormatter = dateFormatter
    }
    
    func dateString(from millis: Double, dateFormat: String) -> String {
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(millis / 1000)))
        return dateString
    }
    
    func countDown(from millis: Double, dateFormat: String) -> String {
        dateFormatter.dateFormat = dateFormat
        let delta = Date.now.timeIntervalSince1970.distance(to: millis / 1000)
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: delta))
        return dateString
    }
}
