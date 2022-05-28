//
//  UserDefaultsGarment.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import Foundation

struct UserDefaultsGarment: Codable {
    let name: String
    let creation: Date
    
    init(from domain: Garment) {
        self.name = domain.name
        self.creation = domain.creationTime
    }
    
    var toDomain: Garment {
        .init(
            name: name,
            creationTime: creation
        )
    }
}


extension Array where Element == UserDefaultsGarment {
    var toDomain: [Garment] {
        map(\.toDomain)
    }
}
