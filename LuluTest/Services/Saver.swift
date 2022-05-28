//
//  Saver.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import Foundation

protocol Saver {
    associatedtype Item
    
    func save(_ item: Item) throws
}
