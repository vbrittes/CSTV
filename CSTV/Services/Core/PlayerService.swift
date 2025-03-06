//
//  PlayerService.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 06/03/25.
//

protocol PlayerService {
    func fetchPlayers(team id: Int, completion: @escaping (_ result: [PlayerObject]?, _ error: Error?) -> Void)
}
