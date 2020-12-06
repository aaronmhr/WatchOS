//
//  CreditsView.swift
//  NoteDictate WatchKit Extension
//
//  Created by Aaron Huánuco on 6/12/20.
//

import SwiftUI

struct CreditsView: View {
    let date: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Credits")
                .font(.title2)

            Divider()

            Label("aaronmhr", systemImage: "person")

            Label(formatedDate, systemImage: "clock")

            HStack {
                Text("Thanks!   🤹‍♀️")
                    .font(.headline)
                    .padding()
                Spacer()
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
    }

    var formatter: DateFormatter {
        return DateFormatter()
    }

    var formatedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView(date: .init())
    }
}
