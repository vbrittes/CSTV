//
//  MatchListViewModelTests.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import XCTest
@testable import CSTV

final class MatchListViewModelTests: XCTestCase {
    
    var sut: MatchListViewModel!
    
    override func setUp() {
        sut = MatchListViewModel(matchService: MatchMockService())
    }
    
    override class func tearDown() {
        
    }
    
    func testFetchMatches() {
        sut.loadContent()
        
        sleep(5)
    }
    
    
}
