//
//  Game.swift
//  NeumorphicTTT
//
//  Created by Janusz Polowczyk on 15/09/2021.
//

import Foundation

enum Player {
    case human, computer
}


struct Move {
    let player: Player
    let boardIndex: Int
    var isChecked: Bool
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
    
}


final class Moves: ObservableObject {
    let player: Player?
    @Published var boardIndex: Int?
    @Published var isChecked: Bool
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
    
    init(player: Player? = nil, boardIndex: Int? = nil, isChecked: Bool = false) {
        self.player = player
        self.boardIndex = boardIndex
        self.isChecked = isChecked
    }
    
}
