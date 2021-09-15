//
//  Helper.swift
//  NeumorphicTTT
//
//  Created by Janusz Polowczyk on 15/09/2021.
//

import SwiftUI

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    
    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
    
    static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
    static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}


struct DarkBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S
    
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                    .overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(Color.darkEnd, lineWidth: 4.0))
                    .shadow(color: Color.darkStart, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: -10.0, y: -10.0)
                    .shadow(color: Color.darkEnd, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 10.0, y: 10.0)
            }
        }
    }
}


struct ColorfulBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S
    
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.lightEnd, Color.lightStart))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4.0))
                    .shadow(color: Color.darkStart, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: -10.0, y: -10.0)
                    .shadow(color: Color.darkEnd, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 10.0, y: 10.0)
            }
        }
    }
}
