//
//  DrawMapper.swift
//  GreekKino
//
//  Created by Aleksandar Micic on 5.8.24..
//

import Foundation

struct DrawMapper {
    func mapDrawModelToItem(model: DrawModel) -> DrawItem {
        DrawItem(drawTime: model.drawTime, drawId: model.drawId)
    }
    
    func mapResultModelToItem(model: ResultModel) -> ResultItem {
        let drawItem = DrawItem(drawTime: model.drawTime,
                                drawId: model.drawId)
        
        let ballItems = model.winningNumbers.list.map {
            BallItem(id: $0, isSelected: true)
        }
        
        return ResultItem(draw: drawItem, balls: ballItems)
    }
}
