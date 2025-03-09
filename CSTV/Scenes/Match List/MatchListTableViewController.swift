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

}

//MARK: - UIViewController lifecycle
extension MatchListTableViewController {
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.view.layoutIfNeeded()
        })
    }
}

//MARK: State management
extension MatchListTableViewController {
    @objc func refreshAction() {
        viewModel.loadContent()
        refreshControl?.endRefreshing()
    }
    
    fileprivate func shouldDisplayLoading() -> Bool {
        return viewModel.matchRepresentations.count == 0 && viewModel.errorMessage == nil
    }
}

//MARK: UITableViewDelegate & UITableViewDataSource
extension MatchListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shouldDisplayLoading() ? 1 : viewModel.matchRepresentations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !shouldDisplayLoading() else {
            return LoadingTableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MatchTableViewCell
        
        cell.populate(match: viewModel.matchRepresentations[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard !shouldDisplayLoading() else {
            return tableView.frame.height * 0.5
        }
        
        return 176 + 12 + 12
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return shouldDisplayLoading() ? 44 : 0
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
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //Force navigation bar appearence to update
        navigationController?.navigationBar.setNeedsLayout()
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.setNeedsDisplay()
    }

}

//MARK: UI setup and updating
fileprivate extension MatchListTableViewController {
    
    func setupInterface() {
        tableView.backgroundColor = .mainBg
        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func setupBinding() {
        viewModel.$matchRepresentations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.reloadData()
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
    }
    
    func reloadData() {
        if tableView.visibleCells.count == 0 {
            tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        } else {
            tableView.reloadData()
        }
    }
}
