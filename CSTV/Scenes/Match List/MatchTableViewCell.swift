//
//  MatchTableViewCell.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import UIKit

class MatchTableViewCell: UITableViewCell {

    fileprivate(set) lazy var matchView = MatchView.ibInstance()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInterface()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupInterface() {
        contentView.backgroundColor = .clear
        
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    fileprivate func setupConstraints() {
        matchView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(matchView)
        
        NSLayoutConstraint.activate([
            matchView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            matchView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            matchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            matchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
            ])
    }
    
    func populate(match describer: MatchDescriber) {
        matchView.populate(match: describer)
    }

}
