//
//  Pokemon.swift
//  Pokedex
//
//  Created by Uldis Zingis on 11/10/16.
//  Copyright © 2016 Uldis Zingis. All rights reserved.
//

import Foundation

class Pokemon {
    
    private let kName = "name"
    private let kMoveName = "name"
    private let kType = "name"
    private let kImage = "front_shiny"
    
    let name: String
    let moveName: String
    let type: String
    let pictureURL: String
    
    init(name: String, moveName: String, type: String, pictureURL: String) {
        self.name = name
        self.moveName = moveName
        self.type = type
        self.pictureURL = pictureURL
    }
    
    init?(json: [String: Any]) {
        guard let name = json[kName] as? String,
             let movesArr = json["moves"] as? [[String: Any]],
             let movesDic = movesArr.first,
             let smallMovesDict = movesDic["move"] as? [String: String],
             let moveName = smallMovesDict[kMoveName],
             let typeArr = json["types"] as? [[String: Any]],
             let typeDict = typeArr.first,
             let smallTypeDict = typeDict["type"] as? [String: String],
             let typeName = smallTypeDict[kType],
             let spritesArr = json["sprites"] as? [String: Any],
             let pictureUrl = spritesArr[kImage] as? String else { return nil }

        self.name = name
        self.moveName = moveName
        self.type = typeName
        self.pictureURL = pictureUrl
    }
}
