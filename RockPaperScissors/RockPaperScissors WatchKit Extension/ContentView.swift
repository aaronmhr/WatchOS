//
//  ContentView.swift
//  RockPaperScissors WatchKit Extension
//
//  Created by Aaron Huánuco on 7/12/20.
//

import SwiftUI

enum Move {
    case rock
    case paper
    case scissors

    var win: Move {
        switch self {
        case .rock: return .paper
        case .paper: return .scissors
        case .scissors: return .rock
        }
    }

    var lose: Move {
        switch self {
        case .rock: return .scissors
        case .paper: return .rock
        case .scissors: return .paper
        }
    }
}

extension Move {
    var image: String {
        switch self {
        case .rock: return "cube"
        case .paper: return "newspaper"
        case .scissors: return "scissors"
        }
    }
}

struct ContentView: View {
    let moves: Set<Move>  = [.rock, .paper, .scissors]
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    @State private var currentArrangement: [Move] = []
    @State private var question = Move.rock
    @State private var shouldWin = true
    @State private var level = 0
    @State private var currentTime = Date()
    @State private var startTime = Date()
    @State private var gameOver = false

    var body: some View {
        VStack {
            if gameOver {
                Text("You Win!")
                    .font(.largeTitle)
                Text("Your time: \(time) seconds")

                Button("Play Again") {
                    startTime = Date()
                    gameOver = false
                    level = 1
                    newLevel()
                }
                .buttonStyle(BorderedButtonStyle(tint: .green))
            } else {
                Image(systemName: question.image)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(
                        Rectangle()
                            .foregroundColor(shouldWin ? .green : .red)
                            .opacity(0.5)
                            .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            .cornerRadius(10)
                    )

                Divider()
                    .padding(.vertical)

                HStack {
                    ForEach(currentArrangement, id: \.self) { move in
                        Button(action: {
                            select(move: move)
                        }, label: {
                            Image(systemName: move.image)
                        })
                    }
                }

                HStack {
                    Text("\(level)/20")
                    Spacer()
                    Text("Time: \(time)")
                }
                .padding([.top, .horizontal])
            }
        }
        .onAppear(perform: newLevel)
        .onReceive(timer, perform: { newTime in
            guard !gameOver else { return }
            currentTime = newTime
        })
        .navigationTitle(shouldWin ? "Win!" : "Lose!")
    }



    var time: String {
        let difference = currentTime.timeIntervalSince(startTime)
        return String(Int(difference))
    }

    func select(move: Move) {
        let isCorrect: Bool
        if shouldWin {
            isCorrect = move == question.win
        } else {
            isCorrect = move == question.lose
        }

        if isCorrect {
            level += 1
        } else {
            level -= 1
            if level < 1 { level = 1 }
        }
        newLevel()
    }

    func newLevel() {
        guard level < 20 else {
            gameOver = true
            return
        }
        shouldWin = Bool.random()
        question = moves.subtracting([question]).randomElement()!
        currentArrangement = moves.shuffled()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("Apple Watch Series 5 - 40mm")
    }
}
