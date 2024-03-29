//
//  Results.swift
//  Hotels
//
//  Created by Евгений Фирман on 02.06.2021.
//

import Foundation

struct Results: Decodable{
    let id: Int
    let name: String
    let address: String
    let stars: Float
    let distance: Float
    let suites_availability: String
}

