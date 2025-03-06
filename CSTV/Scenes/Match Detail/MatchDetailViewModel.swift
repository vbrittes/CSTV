//
//  MatchDetailViewModel.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import Foundation
import Combine

struct MatchDetailDescriber {
    var formattedStartDate: String
    var teamOneImageURL: URL?
    var teamOneName: String
    var teamTwoImageURL: URL?
    var teamTwoName: String
    
    var playerPairs: [MatchPlayerPairDescriber]
}

struct MatchPlayerPairDescriber {
    var playerOneNickname: String?
    var playerOneFullname: String?
    var playerOneImageURL: URL?
    
    var playerTwoNickname: String?
    var playerTwoFullname: String?
    var playerTwoImageURL: URL?
}

class MatchDetailViewModel {
    
    weak var coordinator: Coordinator?
    
    fileprivate var matchService: MatchService
    @Published fileprivate var match: MatchObject?
    
    fileprivate var cancellables = Set<AnyCancellable>()
    
    fileprivate(set) var errorMessage: String?
    @Published var matchRepresentation: MatchDetailDescriber?
    
    init(matchService: MatchService = MatchHTTPService()) {
        self.matchService = matchService
        bind()
    }
    
    func loadContent() {
    }
    
    func prepareForNavigation(match: MatchObject) {
        self.match = match
        loadContent()
    }
    
    private func bind() {
        $match.map { match in
            match.map { m in
//                m.opponents.map { $0.opponent }
                let players = [MatchPlayerPairDescriber(playerOneNickname: "one", playerOneFullname: "one one", playerOneImageURL: nil, playerTwoNickname: "two", playerTwoFullname: "two two", playerTwoImageURL: nil)]
                return MatchDetailDescriber(formattedStartDate: "start", teamOneName: "team one", teamTwoName: "team two", playerPairs: players)
            }
        }
        .assign(to: &$matchRepresentation)
    }
}
