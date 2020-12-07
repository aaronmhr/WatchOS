//
//  ContentView.swift
//  RockPaperScissors WatchKit Extension
//
//  Created by Aaron Huánuco on 7/12/20.
//

import SwiftUI

struct ContentView: View {
    let moves = ["cube", "newspaper", "scissors"]
    @State private var question = "cube"
    @State private var title = "Win!"
    @State private var shouldWin = true
    @State private var level = 1

    var body: some View {
        VStack {
            Image(systemName: question)
                .resizable()
                .frame(width: 30, height: 30)

            Divider()
                .padding(.vertical)

            HStack {
                ForEach(moves, id: \.self) { move in
                    Button(action: {
                        select(move: move)
                    }, label: {
                        Image(systemName: move)
                    })
                }
            }
        }
        .navigationTitle(title)
    }

    func select(move: String) {
        question = move
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("Apple Watch Series 5 - 40mm")
    }
}
