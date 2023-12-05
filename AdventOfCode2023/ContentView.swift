//
//  ContentView.swift
//  AdventOfCode2023
//
//  Created by Phil Fishbein on 11/29/23.
//

import SwiftUI

struct ContentView: View {
    let advents: [Advent] = [
        Advent(dayNumber: 1, name: "A Test", data: [1, 2, 3].map({ AdventData(input: String($0), output: "Num: \($0)") }))
    ]
    
    let dayTwoSolution = DayFourSolution()
    
    var body: some View {
        NavigationStack {
            List(advents, id: \.self.dayNumber) { advent in
                NavigationLink(advent.title, value: advent)
            }
            .navigationDestination(for: Advent.self) { AdventDetail(advent: $0) }
            .navigationTitle("🎅🏻 Advent Of Code 2023 🕎")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
