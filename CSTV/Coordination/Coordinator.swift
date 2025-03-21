//
//  Coordinator.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
    func navigateToDetail(for match: MatchObject)
}
