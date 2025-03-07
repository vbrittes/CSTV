//
//  MatchService.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Foundation
import Alamofire

protocol MatchService {
    @discardableResult
    func fetchMatches(page: Int, perPage: Int, completion: @escaping (_ result: [MatchObject]?, _ error: Error?) -> Void) -> DataRequest?
}
