//
//  MatchListTableViewController.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import UIKit
import Combine

class MatchListTableViewController: UITableViewController {
    
    var viewModel: MatchListViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: MatchListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        viewModel.loadContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension MatchListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.matchRepresentations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)" //viewModel.matchRepresentations[indexPath.row].leagueName
        
        return cell
    }
}

fileprivate extension MatchListTableViewController {
    func setupBinding() {
        viewModel.$matchRepresentations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}
