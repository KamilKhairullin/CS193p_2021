//
//  Memorize_2021App.swift
//  Memorize_2021
//
//  Created by Kamil on 02.07.2021.
//

import SwiftUI

@main
struct Memorize_2021App: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
