//
//  LoadingTableViewCell.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 09/03/25.
//

import UIKit

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
