//
//  API.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import Foundation

enum API: String {
    
    private var host: URL { URL(string: "https://api.pandascore.co/")! }
    
    var apiToken: String { "37RdDYBEr8u_7om870eY2hyoBLs3tx_tkXaDpBKLksy_uEarHAo" }
    
    case matches
    case players
    
    func url(params: [String]? = nil) -> URL {
        let pathURL = URL(fileURLWithPath: rawValue, relativeTo: host)
        
        guard let params = params else {
            return pathURL
        }
        
        return params.reduce(pathURL) { $0.appending(path: $1) }
    }
}
