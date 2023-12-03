//
//  solution.swift
//  AdventOfCode2023
//
//  Created by Phil Fishbein on 12/1/23.
//

import Foundation

struct NumberStringMapping {
    let string: String;
    let digit: Int;
}

let numberStringMappings: [NumberStringMapping] = [NumberStringMapping(string: "one", digit: 1), NumberStringMapping(string: "two", digit: 2), NumberStringMapping(string: "three", digit: 3), NumberStringMapping(string: "four", digit: 4), NumberStringMapping(string: "five", digit: 5), NumberStringMapping(string: "six", digit: 6), NumberStringMapping(string: "seven", digit: 7), NumberStringMapping(string: "eight", digit: 8), NumberStringMapping(string: "nine", digit: 9)]

class DayOneSolution {
    func loadFile(fileName: String) -> String
    {
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt")
        {
            let fm = FileManager()
            let exists = fm.fileExists(atPath: path)
            if(exists){
                let content = fm.contents(atPath: path)
                let contentAsString = String(data: content!, encoding: String.Encoding.utf8)
                
                return contentAsString ?? ""
            }
        }
        
        return ""
    }
    
    func findDigits(string: String) -> [Int] {
        var digits: [Int] = [];
        for (index, character) in string.enumerated() {
            if (character.isWholeNumber && character.wholeNumberValue != nil) {
                digits.append(character.wholeNumberValue!)
            } else {
                let range = String.Index(utf16Offset: index, in: string)
                let stringToReview = string[range...]
                   
               for mapping in numberStringMappings {
                   if (stringToReview.starts(with: mapping.string)) {
                       digits.append(mapping.digit)
                       continue
                   }
               }
            }
        }
        
        return digits
    }

    
    init() {
        let input: String = loadFile(fileName: "input")
        var inputs: [String] = []
        input.enumerateLines { word, _ in
            inputs.append(word)
        }
        
        let numbers = inputs.map {
            let digits = findDigits(string: $0)
            let firstDigit = digits.first
            let lastDigit = digits.last
            
            if (firstDigit != nil && lastDigit != nil) {
                return Int("\(firstDigit!)\(lastDigit!)")
            } else {
                return 0
            }
        }

        print(numbers.reduce(0, {x, y in x + (y ?? 0)}))
    }
}
