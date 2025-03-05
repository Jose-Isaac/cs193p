//
//  ContentView.swift
//  Memorize
//
//  Created by Jose Isaac Barreiro Campos on 04/03/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
            Text("Hello, world")
        }
        .padding()
        .foregroundStyle(.red)
    }
}

#Preview {
    ContentView()
}
