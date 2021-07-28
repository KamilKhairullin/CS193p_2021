//
//  SetGame_2App.swift
//  SetGame_2
//
//  Created by Kamil on 22.07.2021.
//

import SwiftUI

@main
struct SetGame_2App: App {
    var body: some Scene {
        WindowGroup {
            let game = ShapeSetGame()
            ShapeSetGameView(game: game)
        }
    }
}
