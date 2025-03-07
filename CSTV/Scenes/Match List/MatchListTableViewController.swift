//
//  MatchListTableViewController.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 28/02/25.
//

import UIKit
import Combine

final class MatchListTableViewController: UITableViewController {
    
    fileprivate(set) var viewModel: MatchListViewModel
    
    fileprivate var cancellables = Set<AnyCancellable>()
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
        
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setupRefreshControl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layoutIfNeeded()
    }
    
    @objc func refreshAction() {
        viewModel.loadContent()
        refreshControl?.endRefreshing()
    }
}

extension MatchListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.matchRepresentations.count
        return count == 0 ? 1 : count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let count = viewModel.matchRepresentations.count
        
        guard count > 0 else {
            return LoadingTableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MatchTableViewCell
        
        cell.populate(match: viewModel.matchRepresentations[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let count = viewModel.matchRepresentations.count
        
        guard count > 0 else {
            return tableView.frame.height * 0.5
        }
        
        return 176 + 12 + 12
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.errorMessage != nil ? 44 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let message = viewModel.errorMessage else { return nil }
        let label = UILabel()
        label.backgroundColor = .borderSeparator
        label.numberOfLines = 0
        label.attributedText = .formattedErrorDisplay(content: message)
        
        return label
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let count = viewModel.matchRepresentations.count
        
        guard count > 0 else {
            return
        }
        
        viewModel.navigateToMatch(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.updateLastDisplayed(element: indexPath.row)
    }
}

fileprivate extension MatchListTableViewController {
    
    func setupInterface() {
        tableView.backgroundColor = .mainBg
        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func setupBinding() {
        viewModel.$matchRepresentations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func setupRefreshControl() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        refresh.tintColor = .primaryText
        
        tableView.refreshControl = refresh
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Partidas"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.primaryText]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainBg]
    }
    
}

class LoadingTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addActivityIndicator() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        let activityIndicador = UIActivityIndicatorView()
        activityIndicador.style = .large
        activityIndicador.color = .primaryText
        activityIndicador.startAnimating()
        
        activityIndicador.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(activityIndicador)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: activityIndicador, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: activityIndicador, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
        ])
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) { }
    
    override func setSelected(_ selected: Bool, animated: Bool) { }
}
