//
//  InMemoryGarments.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import Combine

final class InMemoryGarments: ObservableObject {
    @Published private var garments: [Garment] = [
        .init(name: "??111", creationTime: .init()),
        .init(name: "A?22222", creationTime: .init().advanced(by: -210)),
        .init(name: "b?22222", creationTime: .init().advanced(by: -21)),
        .init(name: "E2", creationTime: .init().advanced(by: 291871)),
        .init(name: "f22", creationTime: .init().advanced(by: -274363)),
        .init(name: "C22", creationTime: .init().advanced(by: -2717)),
        .init(name: "D2", creationTime: .init().advanced(by: 746)),
    ]
    
    var publisher: AnyPublisher<[Garment], Never> {
        $garments.eraseToAnyPublisher()
    }
}
