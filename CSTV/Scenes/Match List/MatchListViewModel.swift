//
//  MatchListViewModel.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Foundation
import Combine
import Alamofire

struct MatchListItemDescriber {
    var formattedStartDate: String
    var startDateHighlight: Bool
    var teamOneImageURL: URL?
    var teamOneName: String
    var teamTwoImageURL: URL?
    var teamTwoName: String
    var leagueName: String
    var leagueImageURL: URL?
    
    static var empty: MatchListItemDescriber {
        MatchListItemDescriber(
            formattedStartDate: "",
            startDateHighlight: false,
            teamOneName: "",
            teamTwoName: "",
            leagueName: "")
    }
}

final class MatchListViewModel {
    
    weak var coordinator: Coordinator?
    
    fileprivate var matchService: MatchService
    fileprivate var fetchRequest: DataRequest?
    fileprivate var loadingNextPage = false
    
    fileprivate var cancellables = Set<AnyCancellable>()
    
    ///Bind internaly to sync [MatchObject] -> [MatchListItemDescriber]
    @Published fileprivate var matches: [MatchObject] = []
    
    ///Bind to display error feedback
    @Published var errorMessage: String?
    ///Bind to update interface according to loaded content
    @Published var matchRepresentations: [MatchListItemDescriber] = []
    
    
    ///Max number of elements retrieved
    fileprivate let pageLength = 10
    ///The last page missing portion to trigger next page loading
    fileprivate let nextPageTrigger = 0.25
    
    init(matchService: MatchService = MatchHTTPService()) {
        self.matchService = matchService
        bind()
    }
    
    ///Load enough listing content, page management is done by view model according to updateLastDisplayed()
    func loadContent() {
        loadContent(force: true, page: 0)
    }
    
    fileprivate func loadContent(force: Bool, page: Int) {
        if force {
            fetchRequest?.cancel()
            loadingNextPage = false
            matches = []
        }
        
        if loadingNextPage {
            fetchRequest?.cancel()
        }
        
        loadingNextPage = true
        
        fetchRequest = matchService.fetchMatches(page: page, perPage: pageLength) { [weak self] result, error in
            guard let self = self else {
                return
            }
            
            guard let matches = result,
                  error == nil else {
                if error?.asAFError?.isExplicitlyCancelledError == true {
                    self.errorMessage = nil
                    return
                }
                
                self.errorMessage = "Falha ao obter partidas"
                return
            }
            
            self.errorMessage = nil
            
            if force {
                self.matches = matches
            } else {
                self.matches.append(contentsOf: matches)
            }
        }
    }
    
    ///Call wight before displaying UI element, to assure automatic paging
    func updateLastDisplayed(element index: Int) {
        guard matches.count > 0 else { return }
        
        let triggerElement = Double(matches.count) * (1.0 - nextPageTrigger)
        
        let nextPage = matches.count / pageLength
        
        if Double(index) == floor(triggerElement) {
            loadContent(force: false, page: nextPage)
        }
    }
    
    func navigateToMatch(index: Int) {
        let match = matches[index]
        
        coordinator?.navigateToDetail(for: match)
    }
}

fileprivate extension MatchListViewModel {
    func bind() {
        let f = DateFormatHelper()
        
        $matches.map { match in
            match.map { m in
                MatchListItemDescriber(
                    formattedStartDate: m.status == .running ? "AGORA" : f.format(dateString: m.beginAt) ?? "",
                    startDateHighlight: m.status == .running,
                    teamOneImageURL: URL(string: m.opponents.first?.opponent?.imageURL ?? ""),
                    teamOneName: m.opponents.first?.opponent?.name ?? "Não definido",
                    teamTwoImageURL: URL(string: m.opponents.last?.opponent?.imageURL ?? ""),
                    teamTwoName: m.opponents.last?.opponent?.name ?? "Não definido",
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

}
