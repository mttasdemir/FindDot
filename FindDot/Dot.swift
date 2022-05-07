//
//  Dot.swift
//  FindDot
//
//  Created by Mustafa Taşdemir on 6.05.2022.
//

import Foundation
import SwiftUI

struct Dot: Identifiable {
    let id = UUID()
    let width: CGFloat
    let offset: CGPoint
    var selected: Bool = false
    
    var center: CGPoint {
        CGPoint(x: offset.x + width/2 - 5, y: offset.y + width/2 - 5)
    }
    
    var radius: CGFloat {
        width / 2
    }
    
    init(inbound size: CGSize) {
        self.width = CGFloat.random(in: 20...150)
        self.offset = CGPoint(x: CGFloat.random(in: 0...size.width - width), y: CGFloat.random(in: 20...size.height - width - 10))
    }
    
    func intersect(with dot: Dot) -> Bool {
        let distance = sqrt(pow(self.center.x - dot.center.x, 2) + pow(self.center.y - dot.center.y, 2))
        return distance < (self.radius + dot.radius)
    }
}
