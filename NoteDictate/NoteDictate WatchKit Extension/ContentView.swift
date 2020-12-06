//
//  ContentView.swift
//  NoteDictate WatchKit Extension
//
//  Created by Aaron Huánuco on 6/12/20.
//

import SwiftUI

struct ContentView: View {
    @State private var text = ""
    @State private var notes: [Note] = []
    
    var body: some View {
        VStack {
            List(0..<notes.count, id: \.self) { i in
                Text(notes[i].text)
            }
            HStack {
                TextField("Add new note", text: $text)
                Button {
                    guard !text.isEmpty else { return }
                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                } label: {
                    Image(systemName: "plus")
                        .padding()
                }
                .fixedSize()
                .buttonStyle(BorderedButtonStyle(tint: .blue))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
