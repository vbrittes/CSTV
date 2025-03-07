//
//  MatchListViewModel.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Foundation
import Combine

struct MatchListItemDescriber {
    var formattedStartDate: String
    var startDateHighlight: Bool
    var teamOneImageURL: URL?
    var teamOneName: String
    var teamTwoImageURL: URL?
    var teamTwoName: String
    var leagueName: String
    var leagueImageURL: URL?
}

final class MatchListViewModel {
    
    weak var coordinator: MainCoordinator?
    
    private let counterStrikeID = 3
    
    fileprivate var matchService: MatchService
    @Published fileprivate var matches: [MatchObject] = []
    
    fileprivate var cancellables = Set<AnyCancellable>()
    
    fileprivate(set) var errorMessage: String?
    @Published var matchRepresentations: [MatchListItemDescriber] = []
    
    init(matchService: MatchService = MatchHTTPService()) {
        self.matchService = matchService
        bind()
    }
    
    func loadContent() {
        matchService.fetchMatches(videogame: counterStrikeID) { [weak self] result, error in
            guard let self = self else {
                return
            }
            
            guard let matches = result else {
                self.errorMessage = error?.localizedDescription ?? "Falha ao obter partidas"
                return
            }
            
            self.matches = matches
        }
    }
    
    func navigateToMatch(index: Int) {
        let match = matches[index]
        
        coordinator?.navigateToDetail(for: match)
    }
}

fileprivate extension MatchListViewModel {
    func bind() {
        $matches.map { match in
            match.map { m in
                MatchListItemDescriber(
                formattedStartDate: m.beginAt ?? "",
                startDateHighlight: m.status == .running,
                teamOneImageURL: URL(string: m.opponents.first?.opponent?.imageURL ?? ""),
                teamOneName: m.opponents.first?.opponent?.name ?? "",
                teamTwoImageURL: URL(string: m.opponents.last?.opponent?.imageURL ?? ""),
                teamTwoName: m.opponents.last?.opponent?.name ?? "",
                leagueName: m.league.name,
                leagueImageURL: URL(string: m.league.imageURL ?? "")) }
        }
        .assign(to: &$matchRepresentations)
    }
}

fileprivate extension MatchListViewModel {
    func formattedStartDate(match: MatchObject) -> String {
        switch match.status {
        case .finished:
            return "Encerrado"
        case .postponed:
            return "Adiado"
        case .canceled:
            return "Cancelado"
        case .notStarted, .running:
            return match.beginAt ?? ""
        }
    }
    
    func formattedStartDate(date: Date?) -> String {
        let now = Date.now
        
        guard let date = date else {
            return "Erro"
        }
        
        guard date > now else {
            return "Agora"
        }
        
        return "\(formattedDay(for: date)), \(formattedHour(for: date))"
    }
    
    private func formattedDay(for date: Date) -> String {
        return ""
    }
    
    private func formattedHour(for date: Date) -> String {
        return ""
    }
}
