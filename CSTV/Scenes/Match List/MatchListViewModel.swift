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
    var teamOneImageURL: URL?
    var teamOneName: String
    var teamTwoImageURL: URL?
    var teamTwoName: String
    var leagueName: String
}

class MatchListViewModel {
    
    weak var coordinator: Coordinator?
    
    @Published fileprivate var matches: [MatchObject] = []
    fileprivate var matchService: MatchService
    
    fileprivate(set) var errorMessage: String?
    fileprivate var cancellables = Set<AnyCancellable>()
    
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
                print("error getting matches: \(String(describing: error?.localizedDescription))")
                return
            }
            
            self.matches = matches
            
            print("got \(matches.count) matches")
        }
    }
    
    private func bind() {
            $matches.map { match in
                match.map { m in MatchDescriber(
                    formattedStartDate: "",
                    teamOneName: "",
                    teamTwoName: "",
                    leagueName: "") }
                }
            .assign(to: &$matchRepresentations)
        }
}
