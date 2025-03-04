//
//  MatchListViewModel.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Foundation

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
    
    fileprivate var matches: [MatchObject] = []
    fileprivate var matchService: MatchService
    
    fileprivate(set) var errorMessage: String?
    var matchRepresentations: [MatchDescriber] = []
    
    init(matchService: MatchService = MatchHTTPService()) {
        self.matchService = matchService
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
}
