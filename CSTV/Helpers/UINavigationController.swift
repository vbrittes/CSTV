//
//  UINavigationController.swift
//  CSTV
//
//  Created by Victor Milen Brittes on 07/03/25.
//

import UIKit

struct NavigationBarAppearences {
    static var standardAppearence: UINavigationBarAppearance?
    static var scrollAppearence: UINavigationBarAppearance?
}

extension UINavigationController {
    func applyCustomStyling() {
        
        let barButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        barButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]

        let backImage = UIImage(systemName: "arrow.backward")
        
        //When opaque
        let standardAppearence = UINavigationBarAppearance()
        standardAppearence.configureWithDefaultBackground()
        standardAppearence.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        standardAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.mainBg]
        standardAppearence.titleTextAttributes = [.foregroundColor: UIColor.mainBg]
        standardAppearence.backButtonAppearance = barButtonAppearance
        
        navigationBar.standardAppearance = standardAppearence
        navigationBar.compactAppearance = standardAppearence
        navigationBar.compactScrollEdgeAppearance = standardAppearence
        
        //When transparent
        let scrollAppearence = UINavigationBarAppearance()
        scrollAppearence.configureWithTransparentBackground()
        scrollAppearence.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        scrollAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.primaryText]
        scrollAppearence.titleTextAttributes = [.foregroundColor: UIColor.primaryText]
        scrollAppearence.backButtonAppearance = barButtonAppearance

        navigationBar.scrollEdgeAppearance = scrollAppearence
        
        navigationBar.tintColor = .primaryText
    }
}
