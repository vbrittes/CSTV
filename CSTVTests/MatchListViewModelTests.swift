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
    
    func testFetchMatches() {
        triggerLoadContent()
        
        XCTAssertEqual(sut.matchRepresentations.count, 10)
        
        XCTAssertNil(sut.errorMessage)
        
        let representation = sut.matchRepresentations.first
        
        XCTAssertEqual(representation?.formattedStartDate, "AGORA")
        XCTAssertEqual(representation?.startDateHighlight, true)
        XCTAssertEqual(representation?.teamOneImageURL, URL(string: "https://cdn.pandascore.co/images/team/image/131505/893px_aurora_gaming_2023_allmode.png"))
        XCTAssertEqual(representation?.teamOneName, "Aurora Gaming")
        XCTAssertEqual(representation?.teamTwoImageURL, URL(string: "https://cdn.pandascore.co/images/team/image/130342/bad_news_eagles_allmode.png"))
        XCTAssertEqual(representation?.teamTwoName, "Bad News Eagles")
        XCTAssertEqual(representation?.leagueName, "European Pro League")
        XCTAssertEqual(representation?.leagueImageURL, URL(string: "https://cdn.pandascore.co/images/league/image/4854/799px-european_pro_league_2023_lightmode-png"))
        
    }
    
    func testErrorFetchMatch() {
        sut = MatchListViewModel(matchService: MatchMockService(success: false))
        
        triggerLoadContent()
        
        XCTAssertEqual(sut.matchRepresentations.count, 0)
        XCTAssertEqual(sut.errorMessage, "")
    }
    
    func testNavigateToDetail() {
        let expectation = XCTestExpectation()
        
        let coordinator = MockCoordinator(expectation: expectation)
        
        triggerLoadContent()
        
        sut.navigateToMatch(index: 0)
        
        XCTAssertEqual(coordinator.lastGottenMatch?.id, 0)
    }
    
    func testUpdateLastDisplayed() {
        //paginate
        
        triggerLoadContent()
        
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 9
        
        bind(expectation: expectation)
        
        //check not loading automaticallly
        sut.updateLastDisplayed(element: 0)
        //check loading automaticallly
        sut.updateLastDisplayed(element: 10)
        
        wait(for: [expectation])
        
        XCTAssertEqual(sut.matchRepresentations.count, 20)
    }
    
    override func tearDown() {
        cancellables = Set<AnyCancellable>()
    }
}

extension MatchListViewModelTests {
    func triggerLoadContent() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 3
        
        bind(expectation: expectation)
        sut.loadContent()
        
        wait(for: [expectation])
    }
    
    func bind(expectation: XCTestExpectation) {
        sut.$matchRepresentations
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
    }
}

fileprivate class MockCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    let expectation: XCTestExpectation
    
    var lastGottenMatch: MatchObject?
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
        self.navigationController = UINavigationController()
    }
    
    func start() {
    }
    
    func navigateToDetail(for match: CSTV.MatchObject) {
        lastGottenMatch = match
        expectation.fulfill()
    }
    
}
