//
//  SaveUseCaseTest.swift
//  LuluTestTests
//
//  Created by Jamie Chu on 5/28/22.
//

@testable import LuluTest
import XCTest

final class SaveUseCaseTest: XCTestCase {
    func test_start_withProvidedItem_defersToSaver() {
        let providedItem = 100
        let (sut, spy) = makeSUT(item: { providedItem })

        sut.start()
        
        XCTAssertEqual(spy.calledSave, [ 100 ])
    }
    
    
    func test_start_withProvidedItem_defersToSaverDynamically() {
        var providedItem = 100
        
        let (sut, spy) = makeSUT(item: { providedItem })
        
        providedItem = 845737
        sut.start()
        
        XCTAssertEqual(spy.calledSave, [ 845737 ])
    }
    
    // handling errors is outside of the scope of the assignment.
    func test_start_withNoProvidedItem_failsSilently() {
        var providedItem: Int? = 100
        
        let (sut, spy) = makeSUT(item: { providedItem })
        
        providedItem = nil
        sut.start()
        
        XCTAssertEqual(spy.calledSave, [])
    }



    // MARK: - Helpers

    private func makeSUT(
        item: @escaping () -> Int? = { 231 }
    ) -> (
        sut: SaveUseCase<SaverSpy<Int>>,
        spy: SaverSpy<Int>
    ) {
        let spy = SaverSpy<Int>()
        let sut = SaveUseCase(
            saver: spy,
            item: item
        )

        return (sut, spy)
    }
    
    private final class SaverSpy<T>: Saver {
        private(set) var calledSave: [T] = []
        
        func save(_ item: T) throws {
            calledSave.append(item)
        }
    }
}
