//
//  MatchListViewModel.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

class MatchListViewModel {
    
    weak var coordinator: Coordinator?
    
    fileprivate var matches: [MatchObject] = []
    fileprivate var matchService: MatchService
    
    init(matchService: MatchService = MatchHTTPService()) {
        self.matchService = matchService
    }
    
    func loadContent() {
        
    }
}
