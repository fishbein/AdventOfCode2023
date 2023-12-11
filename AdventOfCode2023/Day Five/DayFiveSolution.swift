//
//  DayFiveSolution.swift
//  AdventOfCode2023
//
//  Created by Phil Fishbein on 12/11/23.
//

import Foundation

class DayFiveSolution {
    struct Range {
        let destinationRangeStart: Int
        let sourceRangeStart: Int
        let range: Int
        
        var sourceRangeEnd: Int {
            sourceRangeStart + range - 1
        }
    }
    
    struct SeedRange {
        let start: Int
        let end: Int
    }
    
    struct Seed: CustomStringConvertible {
        let id: Int
        let soil: Int
        let fertilizer: Int
        let water: Int
        let light: Int
        let temperature: Int
        let humidity: Int
        let location: Int
        
        var description: String {
            return "Seed \(id), soil \(soil), fertilizer \(fertilizer), water \(water), light \(light), temperature \(temperature), humidity \(humidity), location \(location)."
        }
    }
    
    func stringToRange(string: String) -> Range {
        let separated = string.split(separator: " ")
        
        return Range(destinationRangeStart: Int(separated[0])!, sourceRangeStart: Int(separated[1])!, range: Int(separated[2])!)
    }
    
    func mapSeed(ranges: [Range], inputId: Int) -> Int {
        let matchingRanges: [Range] = ranges.filter({range in
            inputId >= range.sourceRangeStart && inputId <= range.sourceRangeEnd
        })
        
        if (matchingRanges.count == 0) {
            return inputId
        }
        
        let range = matchingRanges[0]
        let offset = inputId - range.sourceRangeStart
        let destinationId = range.destinationRangeStart + offset
        
        return destinationId
    }
    
    func seedsAsRange(string: String) -> [SeedRange] {
        var seedRanges: [SeedRange] = []
        let seedComponents = string.split(separator: " ")
    
        for (index, _) in seedComponents.enumerated() {
            if (index % 2 == 0) {
                seedRanges.append(SeedRange(start: Int(seedComponents[index])!, end: Int(seedComponents[index])! + Int(seedComponents[index + 1])! - 1))
            }
        }
        
        return seedRanges
    }
    
    init() {
        let seeds = "858905075 56936593 947763189 267019426 206349064 252409474 660226451 92561087 752930744 24162055 75704321 63600948 3866217991 323477533 3356941271 54368890 1755537789 475537300 1327269841 427659734"
        
        let seedRanges = seedsAsRange(string: seeds)
                
        let seedToSoilInput: String = loadFile(fileName: "seedToSoil")
        let soilToFertilizerInput: String = loadFile(fileName: "soilToFertilizer")
        let fertilizerToWaterInput: String = loadFile(fileName: "fertilizerToWater")
        let waterToLightInput: String = loadFile(fileName: "waterToLight")
        let lightToTemperatureInput: String = loadFile(fileName: "lightToTemperature")
        let temperatureToHumidityInput: String = loadFile(fileName: "temperatureToHumidity")
        let humidityToLocationInput: String = loadFile(fileName: "humidityToLocation")
        
        var seedToSoilRanges: [Range] = []
        var soilToFertilizerRanges: [Range] = []
        var fertilizerToWaterRanges: [Range] = []
        var waterToLightRanges: [Range] = []
        var lightToTemperatureRanges: [Range] = []
        var temperatureToHumidityRanges: [Range] = []
        var humidityToLocationRanges: [Range] = []
        
        seedToSoilInput.enumerateLines { line, _ in
            seedToSoilRanges.append(self.stringToRange(string: line))
        }
        soilToFertilizerInput.enumerateLines { line, _ in
            soilToFertilizerRanges.append(self.stringToRange(string: line))
        }
        fertilizerToWaterInput.enumerateLines { line, _ in
            fertilizerToWaterRanges.append(self.stringToRange(string: line))
        }
        waterToLightInput.enumerateLines { line, _ in
            waterToLightRanges.append(self.stringToRange(string: line))
        }
        lightToTemperatureInput.enumerateLines { line, _ in
            lightToTemperatureRanges.append(self.stringToRange(string: line))
        }
        temperatureToHumidityInput.enumerateLines { line, _ in
            temperatureToHumidityRanges.append(self.stringToRange(string: line))
        }
        humidityToLocationInput.enumerateLines { line, _ in
            humidityToLocationRanges.append(self.stringToRange(string: line))
        }
        
        var seedArray: [Seed] = []
        for seed in seeds.split(separator: " ") {
            let soilId = mapSeed(ranges: seedToSoilRanges, inputId: Int(seed)!)
            let fertilizerId = mapSeed(ranges: soilToFertilizerRanges, inputId: soilId)
            let waterId = mapSeed(ranges: fertilizerToWaterRanges, inputId: fertilizerId)
            let lightId = mapSeed(ranges: waterToLightRanges, inputId: waterId)
            let temperatureId = mapSeed(ranges: lightToTemperatureRanges, inputId: lightId)
            let humidityId = mapSeed(ranges: temperatureToHumidityRanges, inputId: temperatureId)
            let locationId = mapSeed(ranges: humidityToLocationRanges, inputId: humidityId)
            
            seedArray.append(Seed(id: Int(seed)!, soil: soilId, fertilizer: fertilizerId, water: waterId, light: lightId, temperature: temperatureId, humidity: humidityId, location: locationId))
        }
        
        
        let lowestLocatedSeed = seedArray.min(by: {x, y in x.location < y.location})
        print(lowestLocatedSeed?.location ?? "uh oh!")
    }
}
