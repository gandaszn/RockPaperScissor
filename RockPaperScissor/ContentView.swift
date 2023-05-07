//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by GANDA on 07/05/23.
//

import SwiftUI

struct ContentView: View {
    private static let moves = ["👊 Rock", "✋ Paper", "✌️ Scissor"]
    private static let playerShouldWinMoves = ["✌️ Scissor", "👊 Rock", "✋ Paper"]
    private static let playerShouldLoseMoves = ["✋ Paper", "✌️ Scissor", "👊 Rock",]
    @State private var computerIndex = Int.random(in: 0..<3);
    @State private var playerMove = 0
    @State private var shouldWin = Bool.random()

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var showingGameOverAlert = false

    @State private var round = 1
    @State private var score = 0

    private let numberOfRound = 10

    var body: some View {
        VStack(spacing: 30) {
            Text("Rock, Paper, Scissors")
                .font(.largeTitle.bold())

            Text("Round: \(round)")

            Text("User Score: \(score)")


            Text("The computer move: \(shouldWin ? Self.playerShouldWinMoves[computerIndex] : Self.playerShouldLoseMoves[computerIndex])")
                .font(.title2)

            ForEach(0..<3) { index in
                Button {
                    checkAnswer(index)
                    showingAlert = true
                } label: {
                    Text(Self.moves[index])
                        .font(.title3.bold())
                }
            }

            Text(shouldWin ? "Beat the computer!" : "Let the computer win!")
                .font(.title3)

        }
        .padding()
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("Continue") {
                nextQuestion()
            }
        } message: {
            Text(alertMessage)
        }
        .alert(alertTitle, isPresented: $showingGameOverAlert) {
            Button("Reset Game") {
                resetGame()
            }
        } message: {
            Text(alertMessage)
        }
    }

    func nextQuestion() {
        computerIndex = Int.random(in: 0..<3);
        if round < numberOfRound {
            round += 1
        } else {
            showGameOverAlert()
        }

        shouldWin = Bool.random()
    }

    func checkAnswer(_ index: Int) {
        alertTitle = index == computerIndex ? "Correct" : "Wrong"

        if index == computerIndex {
            score += 1
        }
    }

    func resetGame() {
        round = 1
        score = 0
        alertMessage = ""
    }

    func showGameOverAlert() {
        alertTitle = "Game Over"
        alertMessage = "Your final score is \(score)"
        showingGameOverAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
