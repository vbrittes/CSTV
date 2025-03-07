//
//  API.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import Foundation

enum API {
    
    private var host: URL { URL(string: "https://api.pandascore.co/")! }
    
    static var apiToken: String { "37RdDYBEr8u_7om870eY2hyoBLs3tx_tkXaDpBKLksy_uEarHAo" }
    
    case matches
    case matchOpponents(String)
    
    static var dateFormatter: ISO8601DateFormatter = ISO8601DateFormatter()
    
    func url() -> URL {
        var path: String
        
        switch self {
        case .matches: path = "csgo/matches"
        case .matchOpponents(let id): path = "matches/\(id)/opponents"
        }
        
        let pathURL = URL(fileURLWithPath: path, relativeTo: host)
        
        return pathURL
    }
}
