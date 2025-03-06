//
//  MatchListViewModel.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Foundation
import Combine

struct MatchDescriber {
    var formattedStartDate: String
    var startDateHighlight: Bool
    var teamOneImageURL: URL?
    var teamOneName: String
    var teamTwoImageURL: URL?
    var teamTwoName: String
    var leagueName: String
    var leagueImageURL: URL?
}

class MatchListViewModel {
    
    weak var coordinator: Coordinator?
    
    fileprivate var matchService: MatchService
    @Published fileprivate var matches: [MatchObject] = []
    
    fileprivate var cancellables = Set<AnyCancellable>()
    
    fileprivate(set) var errorMessage: String?
    @Published var matchRepresentations: [MatchDescriber] = []
    
    init(matchService: MatchService = MatchHTTPService()) {
        self.matchService = matchService
        bind()
    }
    
    func loadContent() {
        matchService.fetchMatches { [weak self] result, error in
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
    
    private func bind() {
            $matches.map { match in
                match.map { m in MatchDescriber(
                    formattedStartDate: "",//self.formattedStartDate(date: m.beginAt),
                    startDateHighlight: m.status == .running,
                    teamOneImageURL: URL(string: m.opponents.first?.opponent.imageUrl ?? ""),
                    teamOneName: m.opponents.first?.opponent.name ?? "",
                    teamTwoImageURL: URL(string: m.opponents.last?.opponent.imageUrl ?? ""),
                    teamTwoName: m.opponents.last?.opponent.name ?? "",
                    leagueName: m.league.name,
                    leagueImageURL: URL(string: m.league.imageUrl ?? "")) }
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
            return formattedStartDate(date: Date())//match.beginAt)
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
