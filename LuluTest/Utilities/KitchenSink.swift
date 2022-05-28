//
//  KitchenSink.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import Combine
import UIKit

func compose<A, B, C>(
    _ first: @escaping (A) -> B,
    _ second: @escaping (B) -> C
) -> (A) -> C {
    {
        second(first($0))
    }
}

extension UITextField {

    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .compactMap { ($0.object as? UITextField)?.text }
        .eraseToAnyPublisher()
    }

}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach(addSubview)
    }
}
