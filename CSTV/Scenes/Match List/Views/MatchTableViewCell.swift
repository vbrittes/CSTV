//
//  MatchTableViewCell.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 05/03/25.
//

import UIKit

final class MatchTableViewCell: UITableViewCell {

    fileprivate(set) lazy var matchView = MatchView.ibInstance()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInterface()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) { }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        matchView.alpha = highlighted ? 0.5 : 1
        matchView.layer.borderColor = highlighted ? UIColor.borderSeparator.cgColor : UIColor.clear.cgColor
        matchView.layer.borderWidth = highlighted ? 1 : 0
    }
    
    func populate(match describer: MatchListItemDescriber) {
        matchView.populate(match: describer)
    }

}

fileprivate extension MatchTableViewCell {
    
    func setupConstraints() {
        matchView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(matchView)
        
        NSLayoutConstraint.activate([
            matchView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            matchView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            matchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            matchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
            ])
    }
    
    func setupInterface() {
        contentView.backgroundColor = .clear
        
        selectionStyle = .default
        backgroundColor = .clear
    }
    
}
