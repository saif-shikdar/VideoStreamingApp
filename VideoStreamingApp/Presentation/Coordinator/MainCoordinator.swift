//
//  AppCoordinator.swift
//  PhotoSearch
//
//  Created by Saif on 07/07/22
//

import Foundation
import UIKit
import VideoSubscriberAccount
import StreamingModule
protocol Coordinator: AnyObject {
    func navigatToGallery(for url: URL, target: UIViewController)
}

class MainCoordinator: Coordinator {
  
   private var navController: UINavigationController
    
    init(navBarController: UINavigationController) {
        self.navController = navBarController
    }
    
    func start() {
        let networkManager = NetworkManager()
        let searchRepository = DefaultSearchRepository(networkManager: networkManager)
        let searchUseCase = DefaultSearchUseCase(searchRepository: searchRepository)
        let  imageSearchViewModel =       SearchViewModel(searchUseCase: searchUseCase)
        
        let searchViewController = SearchViewController.storyboardViewController()
        
        navController.viewControllers = [searchViewController]
        
        searchViewController.viewModel = imageSearchViewModel
        
        searchViewController.coordinator = self
    }
    
    
    func navigatToGallery(for url: URL, target: UIViewController) {
        VideoUtility.shared.playVideo(for:url, target:target )
    }
}
