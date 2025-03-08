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
        loadMatchMock()
    }
    
    func testFetchPlayers() {
        sut.prepareForNavigation(match: mockMatch)
        
        triggerLoadContent()
                
        XCTAssertEqual(sut.playerPairsRepresentation?.count, 6)
        
        XCTAssertNil(sut.errorMessage)
        
        let matchRepresentation = sut.matchRepresentation
        
        XCTAssertEqual(matchRepresentation?.formattedStartDate, "Hoje, 08:30")
        XCTAssertEqual(matchRepresentation?.formattedLeagueSerie, "European Pro League: ")
        XCTAssertEqual(matchRepresentation?.teamOneImageURL?.absoluteString, "https://cdn.pandascore.co/images/team/image/131505/893px_aurora_gaming_2023_allmode.png")
        XCTAssertEqual(matchRepresentation?.teamOneName, "Aurora Gaming")
        XCTAssertEqual(matchRepresentation?.teamTwoImageURL?.absoluteString, "https://cdn.pandascore.co/images/team/image/130342/bad_news_eagles_allmode.png")
        XCTAssertEqual(matchRepresentation?.teamTwoName, "Aurora Gaming")
            
        let playerRepresentation = sut.playerPairsRepresentation?.first
        
        XCTAssertEqual(playerRepresentation?.playerOneNickname, "MarKE")
        XCTAssertEqual(playerRepresentation?.playerOneFullname, "Edgar Maldonado")
        XCTAssertEqual(playerRepresentation?.playerOneImageURL?.absoluteString, "https://cdn.pandascore.co/images/player/image/18354/675px_mar_ke___epicenter_2018.png")
        XCTAssertEqual(playerRepresentation?.playerTwoNickname, "Experative")
        XCTAssertEqual(playerRepresentation?.playerTwoFullname, "Deniz Mutlum")
        XCTAssertEqual(playerRepresentation?.playerTwoImageURL?.absoluteString, nil)
    }
    
    func testErrorFetchPlayers() {
        sut = MatchDetailViewModel(playerService: PlayerMockService(success: false))
        
        let expectation = XCTestExpectation(description: "error expectation")
        expectation.expectedFulfillmentCount = 3
        
        sut.$errorMessage
            .sink { match in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        triggerLoadContent(expected: 1)
        
        wait(for: [expectation])
        
        XCTAssertEqual(sut.playerPairsRepresentation?.count, nil)
        
        XCTAssertEqual(sut.errorMessage, "")
        
    }
    
    override func tearDown() {
        cancellables = Set<AnyCancellable>()
    }
}

extension MatchDetailViewModelTests {
    func loadMatchMock() {
        let expectation = XCTestExpectation()
        
        let matchService = MatchMockService()
        matchService.fetchMatches(page: 0, perPage: 0) { result, error in
            self.mockMatch = result!.first
            expectation.fulfill()
        }
        
        wait(for: [expectation])
    }
    
    func bindMatch(expectation: XCTestExpectation) {
        sut.$matchRepresentation
            .sink { match in
                expectation.fulfill()
            }
            .store(in: &cancellables)
    }
    
    func bindPlayer(expectation: XCTestExpectation) {
        sut.$playerPairsRepresentation
            .sink { match in
                expectation.fulfill()
            }
            .store(in: &cancellables)
    }
    
    func triggerLoadContent(expected fulfillment: Int = 3) {
        sut.prepareForNavigation(match: mockMatch)
        
        let playerExpectation = XCTestExpectation()
        playerExpectation.expectedFulfillmentCount = fulfillment
        
        let matchExpectation = XCTestExpectation()
        
        bindPlayer(expectation: playerExpectation)
        bindMatch(expectation: matchExpectation)
        
        sut.loadContent()
        
        wait(for: [playerExpectation, matchExpectation])
    }
}
