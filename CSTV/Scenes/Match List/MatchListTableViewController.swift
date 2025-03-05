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
    
    fileprivate let cellReuseIdentifier = "matchCellIdentifier"
    
    init(viewModel: MatchListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        setupBinding()
        viewModel.loadContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Partidas"
    }
    
}

extension MatchListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.matchRepresentations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MatchTableViewCell
        
        cell.populate(match: viewModel.matchRepresentations[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176 + 8 + 8
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176 + 8 + 8
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layoutIfNeeded()
    }
}

fileprivate extension MatchListTableViewController {
    
    func setupInterface() {
        tableView.backgroundColor = UIColor(named: "main-bg-color")
        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
//        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func setupBinding() {
        viewModel.$matchRepresentations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}
