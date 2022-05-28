//
//  BinaryTabbedController.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import Combine
import UIKit

final class BinaryTabbedController {
    enum Mode {
        case primary
        case secondary
    }
    
    struct Model {
        let primaryTitle: String
        let secondaryTitle: String
    }

    lazy var view = binded(UIView())
    
    private let model: Model

    private let selection: CurrentValueSubject<Mode, Never>
    init(
        model: Model,
        selection: CurrentValueSubject<Mode, Never>
    ) {
        self.model = model
        self.selection = selection
    }
    
    private var cancellable: AnyCancellable?

    private lazy var first = UIButton().then {
        $0.setTitle(model.primaryTitle, for: .normal)
        $0.backgroundColor = .systemGray
        $0.addTarget(self, action: #selector(didTapFirst), for: .touchUpInside)
    }

    private lazy var second = UIButton().then {
        $0.setTitle(model.secondaryTitle, for: .normal)
        $0.backgroundColor = .systemGray
        $0.addTarget(self, action: #selector(didTapSecond), for: .touchUpInside)
    }
    
    func binded(_ container: UIView) -> UIView {
        container.backgroundColor = .gray
        
        bind()
        
        let stack = UIStackView(arrangedSubviews: [ first, second])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.layer.cornerRadius = 5
        stack.layer.masksToBounds = true
        
        container.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
        ])
        
                
        return container
    }
    
    private func bind() {
        cancellable = selection.sink { [weak self] in self?.select($0) }
    }
    
    private func select(_ mode: Mode) {
        switch mode {
        case .primary:
            first.backgroundColor = .systemGreen
            second.backgroundColor = .systemGray
        case .secondary:
            first.backgroundColor = .systemGray
            second.backgroundColor = .systemGreen
        }
    }
    
    // TODO: - these can be simplified with button combine extensions.
    @objc
    private func didTapFirst() {
        selection.send(.primary)
    }
    
    @objc
    private func didTapSecond() {
        selection.send(.secondary)
    }
}
