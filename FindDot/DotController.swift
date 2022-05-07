//
//  DotController.swift
//  FindDot
//
//  Created by Mustafa Taşdemir on 6.05.2022.
//

import Foundation
import SwiftUI
import Combine

class DotController: ObservableObject {
    let timerPublisher = Timer.publish(every: 1, tolerance: nil, on: RunLoop.main, in: RunLoop.Mode.common, options: nil)
    private var cancellable: AnyCancellable?

    @Published var dots: Array<Dot> = []
    @Published var gameStatus: Status = .running
    @Published var dotsColor: RadialGradient = DotController.VisibleGradient
    static let VisibleGradient = RadialGradient(
                                        gradient   : Gradient(colors: [.yellow, .red]),
                                        center     : UnitPoint(x: 0.25, y: 0.25),
                                        startRadius: 0.2,
                                        endRadius  : 200
                                    )
    static let InvisibleGradinet = RadialGradient(
                                        gradient   : Gradient(colors: [.black, .black]),
                                        center     : UnitPoint(x: 0.25, y: 0.25),
                                        startRadius: 0.2,
                                        endRadius  : 200
                                    )
    
    // MARK: - intents
    func generateNewDot(in size: CGSize) {
        for _ in 1...100 {
            let dot = Dot(inbound: size)
            if addedable(dot) {
                dots.append(dot)
                break
            }
        }
    }
    
    private func addedable(_ newDot: Dot) -> Bool {
        for dot in dots {
            if dot.intersect(with: newDot) {
                return false
            }
        }
        return true
    }
    
    func checkSelected(_ dot: Dot) -> Bool {
        if let index = dots.firstIndex(where: { $0.id == dot.id }),
           !dots[index].selected
        {
            dots[index].selected.toggle()
            return true
        }
        return false
    }
        
    func startTimer() {
        dotsColor = DotController.InvisibleGradinet
        cancellable = nil
        cancellable = timerPublisher
                        .autoconnect()
                        .sink { _ in
                            self.dotsColor = DotController.VisibleGradient
                        }
    }
    
    func gameOver() {
        dots.removeAll()
        gameStatus = .end
    }
    
    func restartGame(_ size: CGSize) {
        gameStatus = .running
        generateNewDot(in: size)
    }
}

enum Status {
    case end, running
}
