//
//  OpponentObject.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Foundation

struct OpponentWrapperObject: Codable {
    let opponent: OpponentObject
}

struct OpponentObject: Codable {
    let name: String
}
