//
//  SimpleButtonStyle.swift
//  NeumorphicTTT
//
//  Created by Janusz Polowczyk on 15/09/2021.
//

import SwiftUI

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                Group {
                    if configuration.isPressed {
                        Circle()
                            .fill(Color.offWhite)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 4)
                                    .blur(radius: 4.0)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle()
                                            .fill(LinearGradient(Color.black, Color.clear)))
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 8)
                                    .blur(radius: 4.0)
                                    .offset(x: -2, y: -2)
                                    .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                            )
                    } else {
                        Circle()
                            .fill(SwiftUI.Color.offWhite)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10.0, y: 10.0)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5.0, y: -5.0)
                    }
                }
            )
    }
}


