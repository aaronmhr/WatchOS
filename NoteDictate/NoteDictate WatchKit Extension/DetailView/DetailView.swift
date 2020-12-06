//
//  DetailView.swift
//  NoteDictate WatchKit Extension
//
//  Created by Aaron Huánuco on 6/12/20.
//

import SwiftUI

struct DetailView: View {
    let index: Int
    let total: Int
    let note: Note

    var body: some View {
        Text(note.text)
            .navigationTitle("Note \(index + 1)/\(total)")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(index: 1, total: 2, note: Note(id: UUID(), text: "Hello World!"))
    }
}
