//
//  MatchService.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

protocol MatchService {
    func fetchMatches(videogame id: Int, completion: @escaping (_ result: [MatchObject]?, _ error: Error?) -> Void)
}
