//
//  UserInputPolicy.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import Foundation

enum UserInputPolicy {
    static func validate(_ input: String?) -> Bool {
        guard let input = input, !input.isEmpty else {
             return false
        }
        return true
    }
}
