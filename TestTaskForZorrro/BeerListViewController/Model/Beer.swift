//
//  Beer.swift
//  TestTaskForZorrro
//
//  Created by Vladimir Bulakhov on 27.07.2021.
//

import Foundation

struct Beer: Decodable, Equatable {
    static func == (lhs: Beer, rhs: Beer) -> Bool {
        return lhs.name == rhs.name 
    } 
    
    let name: String
    let description: String
    let ingredients: IngredientsModel
    let foodPairing: [String]
    let imageUrl: String?
}

struct IngredientsModel: Decodable {
    let malt: [Ingredient]
    let hops: [Ingredient]
    let yeast: String?
}

struct Ingredient: Decodable {
    let name: String
    let amount: AmountModel
    let add: String?
    let attribute: String?
}

struct AmountModel: Decodable {
    let value: Float
    let unit: String
}
