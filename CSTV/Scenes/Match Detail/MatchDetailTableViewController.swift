//
//  MatchDetailTableViewController.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import UIKit
import Combine

final class MatchDetailTableViewController: UITableViewController {

    var viewModel: MatchDetailViewModel
    
    fileprivate var cancellables = Set<AnyCancellable>()
    
    fileprivate let cellReuseIdentifier = "playerCellIdentifier"
    
    private var headerView: MatchDetailHeaderView?
    private var headerViewWidthConstraint: NSLayoutConstraint?
    
    init(viewModel: MatchDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - UIViewController lifecycle
extension MatchDetailTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        viewModel.loadContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInterface()
        setupNavigationBar()
        
        reloadHeaderView()
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

        headerView?.dynamicWidth = size.width
        
        coordinator.animate(alongsideTransition: { _ in
            self.view.layoutIfNeeded()
        })
    }
}

//MARK: State management
extension MatchDetailTableViewController {
    @objc func refreshAction() {
        viewModel.loadContent()
    }
    
    fileprivate func shouldDisplayLoading() -> Bool {
        return viewModel.playerPairsRepresentation?.count == 0 && viewModel.errorMessage == nil
    }
}

//MARK: UITableViewDelegate & UITableViewDataSource
extension MatchDetailTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shouldDisplayLoading() ? 1 : viewModel.playerPairsRepresentation?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !shouldDisplayLoading() else {
            return LoadingTableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MatchPlayerTableViewCell
        
        if let pair = viewModel.playerPairsRepresentation?[indexPath.row] {
            cell.populate(pair: pair)
        }
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard !shouldDisplayLoading() else {
            return tableView.frame.height * 0.5
        }
        
        return 58 + 6 + 6
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
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //Force navigation bar appearence to update
        navigationController?.navigationBar.setNeedsLayout()
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.setNeedsDisplay()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let transparentNavigation = scrollView.contentOffset.y > -view.safeAreaInsets.top
        navigationController?.navigationBar.tintColor = transparentNavigation ? .mainBg : .primaryText
    }
    
}

//MARK: UI setup
fileprivate extension MatchDetailTableViewController {
    
    func setupInterface() {
        tableView.backgroundColor = .mainBg
        tableView.register(MatchPlayerTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        headerView = MatchDetailHeaderView.ibInstance()
        headerView?.dynamicWidth = tableView.frame.width
                
        tableView.tableHeaderView = headerView
        
        setupNavigationBar()
        reloadNavigationBar()
    }
    
    func setupBinding() {
        viewModel.$matchRepresentation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
                self?.reloadHeaderView()
                self?.reloadNavigationBar()
            }
            .store(in: &cancellables)
        
        viewModel.$playerPairsRepresentation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
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
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let backImage = UIImage(systemName: "arrow.backward")
        
        let backItem = UIBarButtonItem(customView: UIImageView(image: backImage))
        backItem.tintColor = .primaryText
        
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .primaryText
        navigationController?.navigationItem.backBarButtonItem = backItem
    }
    
}

//MARK: UI updating
fileprivate extension MatchDetailTableViewController {
    
    func reloadHeaderView() {
        guard let representation = viewModel.matchRepresentation else { return }
                
        headerView?.populate(match: representation)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func reloadNavigationBar() {
        navigationItem.title = viewModel.matchRepresentation?.formattedLeagueSerie
    }
    
}
