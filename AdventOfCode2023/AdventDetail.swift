//
//  AdventDetail.swift
//  AdventOfCode2023
//
//  Created by Phil Fishbein on 11/29/23.
//

import SwiftUI

struct AdventDetail: View {
    let advent: Advent

    var body: some View {
        NavigationStack {
            List(self.advent.data) {adventData in
                Section {
                    Text("Input: \(adventData.input)")
                    Text("Output: \(adventData.output)")
                }
            }
                .navigationTitle(advent.title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AdventDetail(advent: Advent(dayNumber: 1, name: "The first problem", data: [AdventData(input: "1", output: "1"), AdventData(input: "2", output: "2"), AdventData(input: "3", output: "3")]))
}
