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
    
    var url: URL { URL(fileURLWithPath: rawValue, relativeTo: host) }
}
