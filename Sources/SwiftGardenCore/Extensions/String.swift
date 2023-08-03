//
//  String.swift
//  
//
//  Created by Yugo Sugiyama on 2023/08/03.
//

import Foundation

public extension String {
    static var random: String {
        let length = Int.random(in: 0...300)
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ012345678"
        var randomString: String = ""
        
        for _ in 0...length {
            let randomValue = Int.random(in: 0 ... base.count - 1)
            let index: Index = base.index(base.startIndex, offsetBy: randomValue)
            let character: Character = base[index]
            randomString += String(character)
        }
        return randomString
    }
}
