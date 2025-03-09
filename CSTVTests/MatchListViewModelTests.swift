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
        
        let expectation = XCTestExpectation(description: "error expectation")
        expectation.expectedFulfillmentCount = 1

        sut.$errorMessage
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.loadContent()
        
        wait(for: [expectation])
        
        sleep(1) //binding thread performance issue, not ideal solution :(
        
        XCTAssertEqual(sut.matchRepresentations.count, 0)
        XCTAssertEqual(sut.errorMessage, "Falha ao obter partidas")
    }
    
    func testNavigateToDetail() {
        let expectation = XCTestExpectation()
        
        let coordinator = MockCoordinator(expectation: expectation)
        sut.coordinator = coordinator
        
        triggerLoadContent()
        
        sleep(1) //binding thread performance issue, not ideal solution :(
        
        sut.navigateToMatch(index: 0)
        
        XCTAssertEqual(coordinator.lastGottenMatch?.id, 1135296)
    }
    
    func testUpdateLastDisplayed() {
        //paginate
        
        triggerLoadContent()
        
        let expectation = XCTestExpectation(description: "last displayed expectation")
        expectation.expectedFulfillmentCount = 2
        
        bind(expectation: expectation)
        
        (0..<sut.matchRepresentations.count).forEach { index in
            sut.updateLastDisplayed(element: index)
        }
                
        wait(for: [expectation])
                
        XCTAssertEqual(sut.matchRepresentations.count, 20)
    }
    
    override func tearDown() {
        cancellables = Set<AnyCancellable>()
    }
}

extension MatchListViewModelTests {
    func triggerLoadContent(expected fulfillment: Int = 3) {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = fulfillment
        
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
