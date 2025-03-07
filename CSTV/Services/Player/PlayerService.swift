//
//  PlayerService.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 06/03/25.
//

protocol PlayerService {
    func fetchPlayers(match id: Int, completion: @escaping (_ result: [OpponentObject]?, _ error: Error?) -> Void) 
}
