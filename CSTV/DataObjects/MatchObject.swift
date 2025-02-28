//
//  MatchObject.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Foundation

enum MatchStatus: String, Codable {
    case notStarted = "not_started"
    case running
    case finished
    case postponed
    case canceled
}

struct MatchObject: Codable {
    let id: Int
    let name: String
    let status: MatchStatus
    let beginAt: String?
    let league: LeagueObject
    let opponents: [OpponentWrapperObject]
    
}

//Getters
extension MatchObject {
    fileprivate var dateFormatter: ISO8601DateFormatter { ISO8601DateFormatter() }

    var beginAtDate: Date? {
        guard let begin = beginAt else { return nil }
        return dateFormatter.date(from: begin)
    }
}
