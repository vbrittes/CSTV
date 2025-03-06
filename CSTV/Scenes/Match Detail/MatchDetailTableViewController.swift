//
//  MatchDetailTableViewController.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import UIKit
import Combine

class MatchDetailTableViewController: UITableViewController {

    var viewModel: MatchDetailViewModel
    
    fileprivate var cancellables = Set<AnyCancellable>()
    
    fileprivate let cellReuseIdentifier = "playerCellIdentifier"
    
    private var headerView: MatchDetailHeaderView?
    
    init(viewModel: MatchDetailViewModel) {
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
        
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layoutIfNeeded()
    }
}

extension MatchDetailTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.matchRepresentation?.playerPairs.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MatchPlayerTableViewCell
        
        if let pair = viewModel.matchRepresentation?.playerPairs[indexPath.row] {
            cell.populate(pair: pair)
        }
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58 + 6 + 6
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58 + 6 + 6
    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return headerView
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 136
//    }
}

fileprivate extension MatchDetailTableViewController {
    
    func setupInterface() {
        tableView.backgroundColor = UIColor(named: "main-bg-color")
        tableView.register(MatchPlayerTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        headerView = MatchDetailHeaderView.ibInstance()
        
        headerView?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 136)
        tableView.tableHeaderView = headerView
    }
    
    func setupBinding() {
        viewModel.$matchRepresentation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}

