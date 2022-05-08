//
//  FindDotView.swift
//  FindDot
//
//  Created by Mustafa Taşdemir on 6.05.2022.
//

import SwiftUI

struct FindDotView: View {
    @ObservedObject var controller: DotController
    @State private var counter: Int = 0
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .foregroundColor(.black)
                HStack {
                    Text("Score: \(counter)").fontWeight(.bold)
                    Spacer()
                    if controller.gameStatus == .end {
                        Button("Restart") {
                            controller.restartGame(proxy.size)
                            counter = 0
                        }
                    }
                }.font(.title).foregroundColor(.accentColor)
                
                ForEach(controller.dots) { dot in
                    DotView(dot: dot, color: controller.dotsColor)
                        .onTapGesture {
                            if controller.checkSelected(dot) {
                                counter += 1
                                controller.startTimer()
                                controller.generateNewDot(in: proxy.size)
                            } else {
                                controller.gameOver()
                            }
                        }
                }
                if controller.gameStatus == .end {
                    gameOver
                }
            }
            .task {
                controller.generateNewDot(in: proxy.size)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    var gameOver: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("GAME OVER").foregroundColor(.red).font(.system(size: 60))
                Spacer()
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FindDotView(controller: DotController())
    }
}
