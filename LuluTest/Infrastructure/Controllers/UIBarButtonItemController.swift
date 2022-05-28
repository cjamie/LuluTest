//
//  UIBarButtonItemController.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import UIKit

final class UIBarButtonItemController: NSObject {
    private(set) lazy var view = UIBarButtonItem(
        barButtonSystemItem: .add,
        target: self,
        action: #selector(didTapAdd)
    )
    
    private let onAddTapped: () -> Void
    
    init(
        onAddTapped: @escaping () -> Void) {
        self.onAddTapped = onAddTapped
    }
    
    // MARK: - Helpers

    @objc
    private func didTapAdd() {
        onAddTapped()
    }
}
