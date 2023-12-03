//
//  Advent.swift
//  AdventOfCode2023
//
//  Created by Phil Fishbein on 11/29/23.
//

import Foundation

struct AdventData: Identifiable, Hashable {
    let id = UUID()
    var input: String
    var output: String
}

struct Advent: Hashable {
    static func == (lhs: Advent, rhs: Advent) -> Bool {
        lhs.dayNumber == rhs.dayNumber
    }
    
    var dayNumber: Int
    var name: String
    var data: [AdventData]
    
    var title: String { return "Day \(dayNumber): \(name)" }
}
