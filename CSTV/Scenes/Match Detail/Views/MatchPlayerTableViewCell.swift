//
//  MatchPlayerTableViewCell.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import UIKit

final class MatchPlayerTableViewCell: UITableViewCell {
    
    fileprivate(set) lazy var matchPlayerView = MatchPlayerView.ibInstance()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInterface()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(pair describer: MatchPlayerPairDescriber) {
        matchPlayerView.populate(pair: describer)
    }
    
}

fileprivate extension MatchPlayerTableViewCell {
    func setupInterface() {
        contentView.backgroundColor = .clear
        
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func setupConstraints() {
        matchPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(matchPlayerView)
        
        NSLayoutConstraint.activate([
            matchPlayerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            matchPlayerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            matchPlayerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            matchPlayerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
            ])
    }
}
