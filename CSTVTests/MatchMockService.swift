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

protocol JSONFileLoadPerformer { }

extension JSONFileLoadPerformer {
    func load<T: Decodable>(fileName: String, type: T.Type, completion: ((_ result: T?, _ error: Error?) -> Void)) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Failed to load \(fileName).json. \nMake sure the file is added correctly (Build Phases > Copy Bundle Resources)")
            completion(nil, NSError(domain: "Failed to load file \(fileName)", code: 1))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            let result = try decoder.decode(type, from: data)
            
            completion(result, nil)
        } catch {
            completion(nil, NSError(domain: "Failed to parse file \(fileName)", code: 1))
        }
    }
}

class MatchMockService: MatchService, JSONFileLoadPerformer {
    func fetchMatches(completion: (_ result: [MatchObject]?, _ error: Error?) -> Void) {
        load(fileName: "MatchListResponse", type: [MatchObject].self) { result, error in
            completion(result, error)
        }
    }
    
    
}
