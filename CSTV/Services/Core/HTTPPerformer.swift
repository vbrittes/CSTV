//
//  HTTPService.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import Alamofire

protocol HTTPPerformer {
}

extension HTTPPerformer {
    func http() -> Session {
        return AF
    }
}
