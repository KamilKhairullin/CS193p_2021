//
//  Oval.swift
//  SetGame_2
//
//  Created by Kamil on 22.07.2021.
//

import SwiftUI

struct Oval : Shape {
    
    func path(in rect: CGRect) -> Path {
        let height: CGFloat = rect.width * 0.55
        let width: CGFloat = height / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = width / 2
        
        let topArcCenter = CGPoint(
            x: center.x - height / 2 + radius / 2,
            y: center.y
        )
        
        let botArcCenter = CGPoint(
            x: center.x + height / 2 - radius / 2,
            y: center.y
        )
        
        let finishPoint = CGPoint(
            x: center.x - height / 2 + radius / 2,
            y: topArcCenter.y + radius
        )
        var p = Path()
        p.addArc(
            center: topArcCenter,
            radius: radius,
            startAngle: Angle(degrees: 90),
            endAngle: Angle(degrees: 270),
            clockwise: false
        )
        p.addArc(
            center: botArcCenter,
            radius: radius,
            startAngle: Angle(degrees: 270),
            endAngle: Angle(degrees: 90),
            clockwise: false
        )
        p.addLine(to: finishPoint)
        p.move(to: center)
        return p
    }
}

