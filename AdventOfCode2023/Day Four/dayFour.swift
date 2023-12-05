//
//  dayFour.swift
//  AdventOfCode2023
//
//  Created by Phil Fishbein on 12/5/23.
//

import Foundation

class DayFourSolution {
    struct Card {
        let id: Int
        let winningNumbers: [Int]
        let myNumbers: [Int]
        
        var matchingNumbers: Double { Double(Set(winningNumbers).intersection(Set(myNumbers)).count) }
        
        var points: Double {
            matchingNumbers > 0 ? pow(2.0, Double(matchingNumbers - 1.0)) : 0
        }
    }

    func parseCardFrom(string: String) -> Card {
        var splitString = string.split(separator: ":")
        splitString[0].replace("Card ", with: "")
        let id = Int(splitString[0].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
        
        let numbers = splitString[1].split(separator: "|")
        let winning: [Int] = numbers[0].split(separator: " ").map { Int($0)! }
        let myNumbers: [Int] = numbers[1].split(separator: " ").map { Int($0)! }
        
        return Card(id: id, winningNumbers: winning, myNumbers: myNumbers)
    }
    
    init() {
        let input: String = loadFile(fileName: "dayFourInput")
        var cards: [Card] = []
        input.enumerateLines { card, _ in
            cards.append(self.parseCardFrom(string: card))
        }

        print("Points: \(cards.reduce(0, {acc, card in acc + card.points}))")
        
        var copies: [Int: Int] = [:]

        for (index, card) in cards.enumerated() {
            let numberOfSelfCopies: Int = copies[card.id] ?? 0
            let copiedCardIds = card.matchingNumbers > 0 ? cards[index + 1...Int(Double(index) + card.matchingNumbers)].map { $0.id } : []
                
            for copiedCardId in copiedCardIds {
                if((copies[copiedCardId]) != nil) {
                    copies[copiedCardId]! += 1 + 1 * numberOfSelfCopies;
                } else {
                    copies[copiedCardId] = 1 + 1 * numberOfSelfCopies
                }
            }
        }
        
        print("Total Cards: \(copies.reduce(cards.count, {acc, copyCount in acc + copyCount.value }))")
    }
}
