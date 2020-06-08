//
//  Pie.swift
//  Memorize
//
//  Created by Vincent on 6/4/20.
//  Copyright © 2020 CS193. All rights reserved.
//

import SwiftUI

struct Pie: Shape, Animatable {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise = false
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.degrees, endAngle.degrees)
        }
        set {
            startAngle = Angle.degrees(newValue.first)
            endAngle = Angle.degrees(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        var p = Path()
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        p.addLine(to: center)
        return p
    }
}

#if DEBUG
struct Pie_Previews: PreviewProvider {
    static var previews: some View {
        Pie(startAngle: .degrees(90), endAngle: .degrees(170))
    }
}
#endif
