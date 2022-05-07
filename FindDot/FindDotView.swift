//
//  FindDotView.swift
//  FindDot
//
//  Created by Mustafa Taşdemir on 6.05.2022.
//

import SwiftUI

struct FindDotView: View {
    @ObservedObject var controller: DotController
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .foregroundColor(.black)
                ForEach(controller.dots) { dot in
                    DotView(dot: dot, color: controller.dotsColor)
                        .onTapGesture {
                            if controller.checkSelected(dot) {
                                controller.startTimer()
                                controller.generateNewDot(in: proxy.size)
                            }
                        }
                }
            }
            .ignoresSafeArea()
            .task {
                controller.generateNewDot(in: proxy.size)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FindDotView(controller: DotController())
    }
}

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
