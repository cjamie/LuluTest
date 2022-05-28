//
//  UserDefaults.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import Foundation


extension UserDefaults {
    @objc
    var garments: Data? {
        get {
            data(forKey: Constants.garments)
        }
        set {
            set(newValue, forKey: Constants.garments)
        }
    }
    
    private enum Constants {
        static let garments = "garments"
    }
}
