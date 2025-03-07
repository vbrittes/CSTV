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
}

struct MatchPlayerPairDescriber {
    var playerOneNickname: String?
    var playerOneFullname: String?
    var playerOneImageURL: URL?
    
    var playerTwoNickname: String?
    var playerTwoFullname: String?
    var playerTwoImageURL: URL?
}

final class MatchDetailViewModel {
    
    weak var coordinator: Coordinator?
    
    fileprivate var playerService: PlayerService
    @Published fileprivate var match: MatchObject?
    fileprivate var teamOnePlayers: [PlayerObject]?
    fileprivate var teamTwoPlayers: [PlayerObject]?
    
    fileprivate var cancellables = Set<AnyCancellable>()
    
    fileprivate(set) var errorMessage: String?
    
    @Published var matchRepresentation: MatchDetailDescriber?
    @Published var playerPairsRepresentation: [MatchPlayerPairDescriber]?
    
    init(playerService: PlayerService = PlayerHTTPService()) {
        self.playerService = playerService
        bind()
    }
    
    func loadContent() {
        guard let teamOneID = match?.opponents.first?.opponent.id,
              let teamTwoID = match?.opponents.last?.opponent.id,
              match?.opponents.count == 2 else {
            return
        }
        
        playerService.fetchPlayers(team: teamOneID) { players, error in
            self.teamOnePlayers = players
            self.synchronizePlayerDescribers()
        }
        
        playerService.fetchPlayers(team: teamTwoID) { players, error in
            self.teamTwoPlayers = players
            self.synchronizePlayerDescribers()
        }
    }
    
    func prepareForNavigation(match: MatchObject) {
        self.match = match
        loadContent()
    }
    
}

fileprivate extension MatchDetailViewModel {
    
    func bind() {
        $match.map { match in
            match.map { m in
                let firstOpponent = m.opponents.first?.opponent
                let secondOpponent = m.opponents.last?.opponent
                return MatchDetailDescriber(
                    formattedStartDate: m.beginAt ?? "",
                    teamOneImageURL: URL(string: firstOpponent?.imageUrl ?? ""),
                    teamOneName: firstOpponent?.name ?? "",
                    teamTwoImageURL: URL(string: secondOpponent?.imageUrl ?? ""),
                    teamTwoName: firstOpponent?.name ?? "")
            }
        }
        .assign(to: &$matchRepresentation)
    }
    
    func synchronizePlayerDescribers() {
        guard let teamOnePlayers = teamOnePlayers,
              let teamTwoPlayers = teamTwoPlayers,
              teamOnePlayers.count == teamTwoPlayers.count else {
            return
        }
                
        playerPairsRepresentation = (0..<teamOnePlayers.count).map { index in
            let teamOneMember = teamOnePlayers[index]
            let teamTwoMember = teamTwoPlayers[index]
                        
            return MatchPlayerPairDescriber(
                playerOneNickname: teamOneMember.name,
                playerOneFullname: "\(teamOneMember.firstName ?? "") \(teamOneMember.lastName ?? "")",
                playerOneImageURL: URL(string: teamOneMember.imageURL ?? ""),
                playerTwoNickname: teamTwoMember.name,
                playerTwoFullname: "\(teamTwoMember.firstName ?? "") \(teamTwoMember.lastName ?? "")",
                playerTwoImageURL: URL(string: teamTwoMember.imageURL ?? ""))
        }
    }
    
}
