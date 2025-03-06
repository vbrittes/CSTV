//
//  MatchDetailHeaderView.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 06/03/25.
//

import UIKit

class MatchDetailHeaderView: UIView {

    @IBOutlet var firstTeamImageView: UIImageView!
    @IBOutlet var firstTeamNameLabel: UILabel!
    
    @IBOutlet var secondTeamImageView: UIImageView!
    @IBOutlet var secondTeamNameLabel: UILabel!
        
    @IBOutlet var vsLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        setupInterface()
    }
    
    private func setupInterface() {
        backgroundColor = .clear
        
        let labels: [UILabel] = [firstTeamNameLabel, secondTeamNameLabel, dateLabel]
        labels.forEach { l in
            l.textColor = .white
        }
        
        let imageViews: [UIImageView] = [firstTeamImageView, secondTeamImageView]
        imageViews.forEach { iv in
            iv.backgroundColor = UIColor(named: "placeholder-bg-color")
        }
    }

}

extension MatchDetailHeaderView {
    private static var nibName: String {
        return "MatchDetailHeaderView"
    }
    
    static func ibInstance() -> MatchDetailHeaderView {
        let instance = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as! MatchDetailHeaderView
        instance.translatesAutoresizingMaskIntoConstraints = false
        
        return instance
    }
}
