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
            List {
                ForEach(0..<notes.count, id: \.self) {  i in
                    NavigationLink(
                        destination:
                            DetailView(index: i, note: notes[i]),
                        label: {
                            Text(notes[i].text)
                                .lineLimit(1)
                        })
                }
                .onDelete(perform: delete)
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

    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
