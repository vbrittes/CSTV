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
        let viewModel = MatchListViewModel()
        viewModel.coordinator = self
        
        let vc = MatchListTableViewController(viewModel: viewModel)
        
        navigationController.applyCustomStyling()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToDetail(for match: MatchObject) {
        let viewModel = MatchDetailViewModel()
        viewModel.prepareForNavigation(match: match)
        
        let vc = MatchDetailTableViewController(viewModel: viewModel)
        
        navigationController.pushViewController(vc, animated: true)
    }
    

}
