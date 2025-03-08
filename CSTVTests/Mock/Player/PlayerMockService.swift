//
//  PlayerMockService.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 06/03/25.
//

#if canImport(PlayerService)
import MatchService
#else
@testable import CSTV
#endif
import Foundation


class PlayerMockService: PlayerService {
    let service: PlayerService
    
    init(success: Bool = true) {
        self.service = success ? PlayerMockSuccessService() : PlayerMockFailureService()
    }
    
    func fetchPlayers(match id: Int, completion: @escaping ([OpponentObject]?, (any Error)?) -> Void) {
        service.fetchPlayers(match: id, completion: completion)
    }
}

class PlayerMockSuccessService: PlayerService, JSONFileLoadPerformer {
    func fetchPlayers(match id: Int, completion: @escaping (_ result: [OpponentObject]?, _ error: Error?) -> Void) {
        load(fileName: "PlayerListResponse", type: OpponentWrapperObject.self) { result, error in
            completion(result?.opponents, error)
        }
    }
}

class PlayerMockFailureService: PlayerService, JSONFileLoadPerformer {
    @discardableResult
    func fetchPlayers(match id: Int, completion: @escaping (_ result: [OpponentObject]?, _ error: Error?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion(nil, NSError(domain: "Forced error", code: 0))
        }
    }
}
