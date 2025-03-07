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
import Alamofire

class MatchMockService: MatchService, JSONFileLoadPerformer {
    @discardableResult
    func fetchMatches(page: Int, perPage: Int, completion: @escaping (_ result: [MatchObject]?, _ error: Error?) -> Void) -> DataRequest? {
        load(fileName: "MatchListResponse", type: [MatchObject].self) { result, error in
            print("parse error: \(error?.localizedDescription)")
            completion(result, error)
        }
        return nil
    }
    
    
}
