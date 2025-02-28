//
//  MainCoordinator.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        //display main list
        let vc = MatchListTableViewController(viewModel: MatchListViewModel())
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToDetail(for match: MatchObject) {
        
    }
    

}
