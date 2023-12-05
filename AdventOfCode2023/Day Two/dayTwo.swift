//
//  solution.swift
//  AdventOfCode2023
//
//  Created by Phil Fishbein on 12/3/23.
//

import Foundation

struct GameAttempt {
    var red: Int;
    var blue: Int;
    var green: Int;
    
    mutating func setCubesForColor(color: String, value: Int) {
        if (color == "red") {
            red = value
        } else if (color == "blue") {
            blue = value
        } else if (color == "green") {
            green = value
        }
    }
}

struct Game {
    let id: Int;
    let attempts: [GameAttempt]
    
    var power: Int {
        var mostRed = 0
        var mostBlue = 0
        var mostGreen = 0
        
        for attempt in attempts {
            if (attempt.blue > mostBlue) {
                mostBlue = attempt.blue
            }
            if (attempt.red > mostRed) {
                mostRed = attempt.red
            }
            if (attempt.green > mostGreen) {
                mostGreen = attempt.green
            }
        }
        
        return mostRed * mostBlue * mostGreen
    }
}

struct Bag {
    let red: Int;
    let blue: Int;
    let green: Int;
}

class DayTwoSolution {
    func parse(gameString: String) -> Game {
        let colors = ["red", "blue", "green"]
        var attempts: [GameAttempt] = []
        
        var splitString = gameString.split(separator: ":")
        // remove ID from string component
        splitString[0].replace("Game ", with: "")
        let gameAttempts = splitString[1].split(separator: ";")

        for attempt in gameAttempts {
            var gameAttempt = GameAttempt(red: 0, blue: 0, green: 0)
            let cubes = attempt.split(separator: ",")
            for cube in cubes {
                var cubeNumber = cube;
                for color in colors {
                    if (cube.contains(color)) {
                        cubeNumber.replace(color, with: "")
                        let cubeNumberValue = Int(cubeNumber.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
                        gameAttempt.setCubesForColor(color: color, value: cubeNumberValue)
                        break
                    }
                }
            }
            attempts.append(gameAttempt)
        }
        
        return Game(id: Int(splitString[0]) ?? 0, attempts: attempts)
    }
    
    func isGamePossible(game: Game, bag: Bag) -> Bool {
        var isPossible = true
        
        for gameAttempt in game.attempts {
            if (bag.blue < gameAttempt.blue || bag.green < gameAttempt.green || bag.red < gameAttempt.red) {
                isPossible = false
                break
            } else {
                continue
            }
        }
        
        return isPossible
    }

    func possibleGamesForBag(games: [Game], bag: Bag) -> [Game] {
        var possibleGames: [Game] = []
        for game in games {
            if (isGamePossible(game: game, bag: bag)) {
                possibleGames.append(game)
            }
        }
        
        return possibleGames
    }
    
    init() {
        let input: String = loadFile(fileName: "dayTwoInput")
        var inputs: [Game] = []
        input.enumerateLines { game, _ in
            inputs.append(self.parse(gameString: game))
        }
        
        let bag = Bag(red: 12, blue: 14, green: 13)
        let possibleGames = possibleGamesForBag(games: inputs, bag: bag)
            
        print("Sum of possible game IDs: \(possibleGames.reduce(0, {value, game in value + game.id}))")
        print("Power sum: \(inputs.reduce(0, {res, game in res + game.power}))")
    }
}
