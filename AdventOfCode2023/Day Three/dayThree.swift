//
//  dayThree.swift
//  AdventOfCode2023
//
//  Created by Phil Fishbein on 12/4/23.
//

import Foundation

struct NumberMap {
    let lineIndex: Int
    let characterRangeStart: Int
    let characterRangeEnd: Int
    let number: Int
}

struct SymbolMap {
    let lineIndex: Int
    let characterIndex: Int
    let symbol: String
}

struct Gear {
    let numberOne: Int
    let numberTwo: Int
    var ratio: Int {
        numberOne * numberTwo
    }
}

class DayThreeSolution {
    var numbers: [NumberMap] = []
    var symbols: [SymbolMap] = []
    
    init() {
        let input: String = loadFile(fileName: "dayThreeInput")
        var inputs: [String] = []
        input.enumerateLines { line, _ in
            inputs.append(line)
        }
        
        for (lineIndex, line) in inputs.enumerated() {
            var number = ""
            var numberStartIndex: Int? = nil
            
            for (characterIndex, character) in line.enumerated() {
                if (character == ".") {
                    // record + reset
                    if (number.count > 0) {
                        numbers.append(NumberMap(lineIndex: lineIndex, characterRangeStart: numberStartIndex!, characterRangeEnd: characterIndex - 1, number: Int(number)!))
                    }
                    number = ""
                    numberStartIndex = nil
                } else if (character.isWholeNumber) {
                    if (numberStartIndex == nil) {
                        numberStartIndex = characterIndex
                    }
                    
                    number += String(character)
                } else {
                    if (number.count > 0) {
                        numbers.append(NumberMap(lineIndex: lineIndex, characterRangeStart: numberStartIndex!, characterRangeEnd: characterIndex - 1, number: Int(number)!))
                    }
                    number = ""
                    numberStartIndex = nil
                    symbols.append(SymbolMap(lineIndex: lineIndex, characterIndex: characterIndex, symbol: String(character)))
                }
            }
            
            // if the line is complete but a number has been built, add it to the list
            if (number.count > 0) {
                numbers.append(NumberMap(lineIndex: lineIndex, characterRangeStart: numberStartIndex!, characterRangeEnd: line.count - 1, number: Int(number)!))
                
            }
        }
        
        var numbersToAdd: [Int] = []
        for numberMapping in numbers {
            let adjacentSymbol = symbols.firstIndex(
                where: {(
                    $0.lineIndex == numberMapping.lineIndex &&
                        ($0.characterIndex == numberMapping.characterRangeStart - 1 || $0.characterIndex == numberMapping.characterRangeEnd + 1)
                ) || (
                    $0.lineIndex == numberMapping.lineIndex - 1 &&
                        (
                            $0.characterIndex >= numberMapping.characterRangeStart - 1 && $0.characterIndex <= numberMapping.characterRangeEnd + 1
                        )
                ) || (
                    $0.lineIndex == numberMapping.lineIndex + 1 &&
                        (
                            $0.characterIndex >= numberMapping.characterRangeStart - 1 && $0.characterIndex <= numberMapping.characterRangeEnd + 1
                        )
                )}
            )
                        
            if(adjacentSymbol != nil) {
                numbersToAdd.append(numberMapping.number)
            }
        }
        
        let potentialGears = symbols.filter({x in x.symbol == "*"})
        var gears: [Gear] = []
        for potentialGear in potentialGears {
            let adjacentNumbers = numbers.filter({ numberMapping in
                (
                    potentialGear.lineIndex == numberMapping.lineIndex &&
                        (potentialGear.characterIndex == numberMapping.characterRangeStart - 1 || potentialGear.characterIndex == numberMapping.characterRangeEnd + 1)
                ) || (
                    potentialGear.lineIndex == numberMapping.lineIndex - 1 &&
                        (
                            potentialGear.characterIndex >= numberMapping.characterRangeStart - 1 && potentialGear.characterIndex <= numberMapping.characterRangeEnd + 1
                        )
                ) || (
                    potentialGear.lineIndex == numberMapping.lineIndex + 1 &&
                        (
                            potentialGear.characterIndex >= numberMapping.characterRangeStart - 1 && potentialGear.characterIndex <= numberMapping.characterRangeEnd + 1
                        )
                )
            })
            
            if (adjacentNumbers.count == 2) {
                gears.append(Gear(numberOne: adjacentNumbers[0].number, numberTwo: adjacentNumbers[1].number))
            }
        }

        print("Part Numbers: \(numbersToAdd.reduce(0, {x, y in x + y}))")
        print("Gear ratios: \(gears.reduce(0, {acc, gear in acc + gear.ratio}))")
    }
}
