//
//  FindDotApp.swift
//  FindDot
//
//  Created by Mustafa Taşdemir on 6.05.2022.
//

import SwiftUI

@main
struct FindDotApp: App {
    @StateObject private var dotController = DotController()
    var body: some Scene {
        WindowGroup {
            FindDotView(controller: dotController)
        }
    }
}
