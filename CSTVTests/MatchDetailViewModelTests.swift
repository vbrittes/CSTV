//
//  MatchDetailViewModelTests.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 06/03/25.
//

import XCTest
@testable import CSTV
import Combine

final class MatchDetailViewModelTests: XCTestCase {
    var sut: MatchDetailViewModel!
    
    private var cancellables = Set<AnyCancellable>()
    private var mockMatch: MatchObject!
    
    override func setUp() {
        sut = MatchDetailViewModel(playerService: PlayerMockService())
        
        let expectation = XCTestExpectation()
        
        let matchService = MatchMockService()
        matchService.fetchMatches { result, error in
            self.mockMatch = result!.first
            expectation.fulfill()
        }
        
        wait(for: [expectation])
    }
    
    func testFetchMatches() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 6
        
        bind(expectation: expectation)
        
        sut.prepareForNavigation(match: mockMatch)
        sut.loadContent()
        
        wait(for: [expectation], timeout: 5)
                
        XCTAssertEqual(sut.playerPairsRepresentation?.count, 50)
    }
    
    func bind(expectation: XCTestExpectation) {
        sut.$matchRepresentation
            .sink { match in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.$playerPairsRepresentation
            .sink { match in
                expectation.fulfill()
            }
            .store(in: &cancellables)
    }
}
