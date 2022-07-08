//
//  SearchViewController.swift
//  PhotoSearch
//
//  Created by Saif on 07/07/22
//

import UIKit
import Combine

final class SearchViewController: UIViewController, Alertable {

    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel:SearchViewModel?
    weak var coordinator: Coordinator?

    private var bindings = Set<AnyCancellable>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("search", comment:"")
        search()
        setupBinding()
    }
}


// MARK: - Private Methods

extension SearchViewController {
    private func search() {
        Task {
            await viewModel?.getGalleryVideos()
        }
    }
    
    private func setupBinding() {
        viewModel?.$state.receive(on: RunLoop.main).sink(receiveValue: {[weak self] states in
            switch states {
            case .showActivityIndicator:
                self?.showActivity()
            case .showVideosList:
                self?.hideActivity()
                self?.tableView.reloadData()
            case .showError( let message):
                self?.hideActivity()
                self?.showAlert(message:message)
            case .none:
                self?.hideActivity()
            case .showVideoGallery(let url):
                self?.coordinator?.navigatToGallery(for: url, target: self!)
            }
        }).store(in: &bindings)
    }
        
    private func showActivity() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    private func hideActivity() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.videoRecordsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
        
        if let viewModel = viewModel {
            let videoDetils = viewModel.getVideoDetails(index: indexPath.row)
            cell.textLabel?.text = "\(videoDetils.location) - \(videoDetils.name)"
        }
     
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.navigateToGallery(for: indexPath.row)
    }
}
