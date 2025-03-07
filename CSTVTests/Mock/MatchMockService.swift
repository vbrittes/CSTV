//
//  MatchMockService.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 04/03/25.
//

#if canImport(MatchService)
import MatchService
#else
@testable import CSTV
#endif
import Foundation

class MatchMockService: MatchService, JSONFileLoadPerformer {
    func fetchMatches(videogame id: Int, completion: @escaping (_ result: [MatchObject]?, _ error: Error?) -> Void) {
        load(fileName: "MatchListResponse", type: [MatchObject].self) { result, error in
            print("parse error: \(error?.localizedDescription)")
            completion(result, error)
        }
    }
    
    
}
