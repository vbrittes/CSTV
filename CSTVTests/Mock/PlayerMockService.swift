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

class PlayerMockService: PlayerService, JSONFileLoadPerformer {
    func fetchPlayers(team id: Int, completion: @escaping ([PlayerObject]?, (any Error)?) -> Void) {
        load(fileName: "PlayerListResponse", type: [PlayerObject].self) { result, error in
            print("parse error: \(error?.localizedDescription ?? "")")
            print("result count: \(result?.count ?? 0)")
            
            completion(result, error)
        }
    }
}
