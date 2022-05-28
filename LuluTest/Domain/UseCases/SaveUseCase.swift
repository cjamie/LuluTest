//
//  SaveUseCase.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import Foundation

final class SaveUseCase<S: Saver>: UseCase {
    let saver: S
    let item: () -> S.Item?
    
    init(
        saver: S,
        item: @escaping () -> S.Item?
    ) {
        self.saver = saver
        self.item = item
    }
    
    func start() {
        guard let item = item() else { return }
        try? saver.save(item)
    }
}
