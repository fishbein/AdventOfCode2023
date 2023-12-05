//
//  loadFile.swift
//  AdventOfCode2023
//
//  Created by Phil Fishbein on 12/4/23.
//

import Foundation

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
