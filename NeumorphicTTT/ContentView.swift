//
//  ContentView.swift
//  NeumorphicTTT
//
//  Created by Janusz Polowczyk on 15/09/2021.
//

import SwiftUI

struct ContentView: View {
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    @State var toggled = Array(repeating: false, count: 9)
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var humanScore = 0
    @State private var draw = 0
    @State private var computerScore = 0
    @State private var isGameboardDisabled = false
    @State private var alertItem: AlertItem?
    var body: some View {
            ZStack {
                LinearGradient(Color.darkStart, Color.darkEnd)
                
                LazyVGrid(columns: columns) {
                    ForEach(0..<9) { item in

                            ZStack {
                                Circle()
                                    .foregroundColor(Color.black)
                                    .shadow(color: moves[item]?.boardIndex != nil ? Color.darkStart : Color.darkEnd, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 10.0, y: 10.0)
                                    .shadow(color: moves[item]?.boardIndex != nil ? Color.darkEnd : Color.darkStart, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: -5.0, y: -5.0)
                                    .frame(width: 80, height: 80)
        //
                                Image(systemName: moves[item]?.indicator ?? "")
                            }
                            .onTapGesture {
                                if isSquareOccupied(in: moves, for: item) { return }
                                moves[item] = Move(player: .human, boardIndex: item, isChecked: true)
                                toggled[item] = true
                                //                            check for win condition or draw
                                
                                if checkWinCondition(for: .human, in: moves) {
                                    print("Human wins")
                                    humanScore += 1
                                    alertItem = AlertContext.humanWin
                                    return
                                }
                                if checkForDraw(in: moves) {
                                    print("Draw")
                                    draw += 1
                                    alertItem = AlertContext.draw
                                    return
                                }
                                isGameboardDisabled = true
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    let computerPosition = determineComputerMovePosition(in: moves)
                                    moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition, isChecked: true)
                                    toggled[computerPosition] = true
                                    isGameboardDisabled = false
                                    
                                    if checkWinCondition(for: .computer, in: moves) {
                                        print("Computer wins")
                                        computerScore += 1
                                        alertItem = AlertContext.computerWin
                                        return
                                    }
                                    if checkForDraw(in: moves) {
                                        print("Draw")
                                        draw += 1
                                        return
                                    }
                                }
                        }
                        }
                    }
                .disabled(isGameboardDisabled)
                .padding()
                .alert(item: $alertItem) { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message,
                          dismissButton: .default(alertItem.buttonTitle,
                                                  action: { resetGame() }))
                }
                VStack(spacing: 20) {
                    Text("Tic - Tac - Toe")
                        .font(.system(size: 35, weight: .light, design: .monospaced))
                        .foregroundColor(.white)
                    Spacer()
// MARK: Scoreboard here, uncomment to add to the VStack
//                    VStack(alignment: .center, spacing: 5) {
//                        Text("AI score: \(computerScore)")
//                            .font(.system(.headline))
//                            .foregroundColor(Color.white)
//                        Text("Draws: \(draw)")
//                            .font(.system(.headline))
//                            .foregroundColor(Color.white)
//                        Text("Human score: \(humanScore)")
//                            .font(.system(.headline))
//                            .foregroundColor(Color.white)
//                    }
//                    .frame(width: 200, height: 80)
//                    .background(Color.black)
//                    .cornerRadius(10.0)
//                    .shadow(color: Color.darkStart, radius: 10, x: 10, y: 10)
//                    .shadow(color: Color.darkEnd, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: -5.0, y: -5.0)
                }
                .padding(.top, 100)
                .padding(.bottom, 100)
                
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
    
    func isSquareOccupied(in moves: [Move?], for index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        
        // If AI can win, then win
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6],
                                          [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let computerMoves = moves.compactMap { $0 }.filter{ $0.player == .computer }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, for: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }
        
        // If AI can't win, then block
        
        let humanMoves = moves.compactMap { $0 }.filter{ $0.player == .human }
        let humanPositions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, for: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }
        // If AI can't block, then take middle square
        let centerSquare = 4
        if !isSquareOccupied(in: moves, for: centerSquare) {
            return centerSquare
        }
        
        // If AI can't take middle square, take random available square
        var movePosition = Int.random(in: 0..<9)
        
        
        while isSquareOccupied(in: moves, for: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6],
                                          [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap { $0 }.filter{ $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
