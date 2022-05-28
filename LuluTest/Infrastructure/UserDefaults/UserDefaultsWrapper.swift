//
//  UserDefaultsWrapper.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import Foundation

final class UserDefaultsWrapper {
    private let underlying: UserDefaults
    
    init(_ defaults: UserDefaults) {
        self.underlying = defaults
    }
}

extension UserDefaultsWrapper: Saver {
    func save(_ item: Garment) throws {
        var current: [UserDefaultsGarment] = []
        
        if let currentData = underlying.garments {
            current = try JSONDecoder().decode([UserDefaultsGarment].self, from: currentData)
        }
        current.append(UserDefaultsGarment(from: item))
          
        underlying.garments = try JSONEncoder().encode(current)
    }
}
