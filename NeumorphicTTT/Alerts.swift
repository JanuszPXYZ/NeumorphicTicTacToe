//
//  Alerts.swift
//  Tic-Tac-Toe
//
//  Created by Janusz Polowczyk on 15/09/2021.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You win!"),
                             message: Text("Emphatic win!"),
                             buttonTitle: Text("Hell Yeah!"))

    static let computerWin = AlertItem(title: Text("You lost!"),
                             message: Text("AI beat you!"),
                             buttonTitle: Text("Rematch"))

    static let draw = AlertItem(title: Text("Draw"),
                             message: Text("Whew! That was a tight game!"),
                             buttonTitle: Text("Try Again"))

}

