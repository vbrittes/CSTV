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

class MatchMockService: MatchService {
    let service: MatchService
    
    init(success: Bool = true) {
        self.service = success ? MatchMockSuccessService() : MatchMockFailureService()
    }
    
    @discardableResult
    func fetchMatches(page: Int, perPage: Int, completion: @escaping ([MatchObject]?, (any Error)?) -> Void) -> Alamofire.DataRequest? {
        service.fetchMatches(page: page, perPage: perPage, completion: completion)
    }
}

class MatchMockSuccessService: MatchService, JSONFileLoadPerformer {
    @discardableResult
    func fetchMatches(page: Int, perPage: Int, completion: @escaping (_ result: [MatchObject]?, _ error: Error?) -> Void) -> DataRequest? {
        load(fileName: "MatchListResponse", type: [MatchObject].self) { result, error in
            completion(result, error)
        }
        return nil
    }
}

class MatchMockFailureService: MatchService, JSONFileLoadPerformer {
    @discardableResult
    func fetchMatches(page: Int, perPage: Int, completion: @escaping (_ result: [MatchObject]?, _ error: Error?) -> Void) -> DataRequest? {
        load(fileName: "x", type: [MatchObject].self) { result, error in
            completion(result, error)
        }
        return nil
    }
}
