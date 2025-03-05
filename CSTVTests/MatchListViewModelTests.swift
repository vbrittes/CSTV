//
//  MatchListViewModelTests.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import XCTest
@testable import CSTV
import Combine

final class MatchListViewModelTests: XCTestCase {
    
    var sut: MatchListViewModel!
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        sut = MatchListViewModel(matchService: MatchMockService())
    }
    
    override class func tearDown() {
    }
    
    func bind(expectation: XCTestExpectation) {
        sut.$matchRepresentations
            .receive(on: DispatchQueue.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
    }
    
    func testFetchMatches() {
        let expectation = XCTestExpectation()
        
        bind(expectation: expectation)
        sut.loadContent()
        
        wait(for: [expectation])
        
        XCTAssertEqual(sut.matchRepresentations.count, 5)
    }
    
    
}
