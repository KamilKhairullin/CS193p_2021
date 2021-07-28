//
//  Diamond.swift
//  SetGame_2
//
//  Created by Kamil on 22.07.2021.
//

import SwiftUI

struct Diamond : Shape {
    
    func path(in rect: CGRect) -> Path {
        let horizontalDiagonal = rect.size.width * 5 / 8
        let verticalDiagonal = horizontalDiagonal / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let topPoint = CGPoint(
            x : center.x,
            y : center.y + verticalDiagonal / 2
        )
        
        let botPoint = CGPoint(
            x : center.x,
            y : center.y - verticalDiagonal / 2
        )
        
        let leftPoint = CGPoint(
            x : center.x - horizontalDiagonal / 2,
            y : center.y
        )
        
        let rightPoint = CGPoint(
            x : center.x + horizontalDiagonal / 2,
            y : center.y
        )
        
        var p = Path()
        p.move(to: topPoint)
        p.addLine(to: leftPoint)
        p.addLine(to: botPoint)
        p.addLine(to: rightPoint)
        p.addLine(to: topPoint)
        return p
    }
}

