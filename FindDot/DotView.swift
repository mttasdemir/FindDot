//
//  DotView.swift
//  FindDot
//
//  Created by Mustafa Taşdemir on 8.05.2022.
//

import SwiftUI

struct DotView: View {
    let dot: Dot
    let color: RadialGradient
    
    var body: some View {
        Circle()
            .fill(color)
            .offset(x: dot.offset.x, y: dot.offset.y)
            .frame(width: dot.width, height: dot.width, alignment: .center)
    }
}

