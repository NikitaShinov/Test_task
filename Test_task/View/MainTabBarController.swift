//
//  ViewController.swift
//  Test_task
//
//  Created by max on 19.06.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        viewControllers = [
            setupVC(vc: MainFeedViewController(), vcTitle: "Random feed", vcImage: UIImage(systemName: Constants.feedImage.rawValue)!),
            setupVC(vc: FavouritesViewController(), vcTitle: "Favourites", vcImage: UIImage(systemName: Constants.favouritesImage.rawValue)!)
        ]
    }
    
    private func setupVC(vc: UIViewController, vcTitle: String, vcImage: UIImage) -> UINavigationController {
        let vc = UINavigationController(rootViewController: vc)
        vc.tabBarItem.title = vcTitle
        vc.tabBarItem.image = vcImage
        return vc
    }
}

