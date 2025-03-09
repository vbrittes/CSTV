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
    var formattedLeagueSerie: String
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
    
    fileprivate var cancellables = Set<AnyCancellable>()
    
    fileprivate var teamOnePlayers: [PlayerObject]?
    fileprivate var teamTwoPlayers: [PlayerObject]?
    
    ///Bind internaly to sync MatchObject -> MatchDetailDescriber
    @Published fileprivate var match: MatchObject?
    
    ///Bind to display error feedback
    @Published var errorMessage: String?
    
    ///Bind to update interface according to loaded content
    @Published var matchRepresentation: MatchDetailDescriber?
    ///Bind to update interface according to loaded content
    @Published var playerPairsRepresentation: [MatchPlayerPairDescriber]?
    
    init(playerService: PlayerService = PlayerHTTPService()) {
        self.playerService = playerService
        bind()
    }
    
    ///Load players list; match values are reused from navigation
    func loadContent() {
        guard let matchID = match?.id else {
            return
        }
        
        self.teamOnePlayers = []
        self.teamTwoPlayers = []
        
        playerService.fetchPlayers(match: matchID) { [weak self] result, error in
            guard let self = self else { return }
            
            guard let result = result,
                  result.count == 2 &&
                    error == nil else {
                self.errorMessage = "Falha ao obter jogadores"
                return
            }
            
            self.teamOnePlayers = result.first?.players
            self.teamTwoPlayers = result.last?.players
            self.synchronizePlayerDescribers()
        }
        
    }
    
    ///The match correponding to detail and players list to be shown 
    func prepareForNavigation(match: MatchObject) {
        self.match = match
        loadContent()
    }
}

fileprivate extension MatchDetailViewModel {
    
    func bind() {
        let f = DateFormatHelper()
        
        $match.map { match in
            match.map { m in
                let firstOpponent = m.opponents.first?.opponent
                let secondOpponent = m.opponents.last?.opponent
                return MatchDetailDescriber(
                    formattedStartDate: f.format(dateString: m.beginAt) ?? "",
                    formattedLeagueSerie: "\(m.league.name): \(m.serie.name ?? "")",
                    teamOneImageURL: URL(string: firstOpponent?.imageURL ?? ""),
                    teamOneName: firstOpponent?.name ?? "Não definido",
                    teamTwoImageURL: URL(string: secondOpponent?.imageURL ?? ""),
                    teamTwoName: firstOpponent?.name ?? "Não definido")
            }
        }
        .assign(to: &$matchRepresentation)
    }
    
    func synchronizePlayerDescribers() {
        guard let teamOnePlayers = teamOnePlayers,
              let teamTwoPlayers = teamTwoPlayers else {
            return
        }
        
        let maxNumber = max(teamOnePlayers.count, teamTwoPlayers.count)
        
        playerPairsRepresentation = (0..<maxNumber).map { index in
            let teamOneMember = teamOnePlayers.safeFind(index: index)
            let teamTwoMember = teamTwoPlayers.safeFind(index: index)
            
            return MatchPlayerPairDescriber(
                playerOneNickname: teamOneMember?.name ?? "Não definido",
                playerOneFullname: "\(teamOneMember?.firstName ?? "") \(teamOneMember?.lastName ?? "")",
                playerOneImageURL: URL(string: teamOneMember?.imageURL ?? ""),
                playerTwoNickname: teamTwoMember?.name ?? "Não definido",
                playerTwoFullname: "\(teamTwoMember?.firstName ?? "") \(teamTwoMember?.lastName ?? "")",
                playerTwoImageURL: URL(string: teamTwoMember?.imageURL ?? ""))
        }
    }
    
}
