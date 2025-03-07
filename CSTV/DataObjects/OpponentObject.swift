//
//  OpponentObject.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Foundation

struct OpponentWrapperObject: Codable {
    let opponents: [OpponentObject]
}

struct OpponentObject: Codable {
    enum OpponentType: String, Codable {
        case Team
        case Player
    }
    
    let type: OpponentType?
    let opponent: TeamObject?
    let players: [PlayerObject]?
}
