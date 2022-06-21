//
//  MainFeedViewController.swift
//  Test_task
//
//  Created by max on 19.06.2022.
//

import UIKit
import Kingfisher

class MainFeedViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    var viewModel: FeedViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupSearchBar()
        viewModel = FeedViewModel()
        createCollectionView()
        
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        title = "Лента"
    }
    
    private func createCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), collectionViewLayout: layout)
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        viewModel.getFeed {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
}

    // MARK: - UICollectionViewDataSource

extension MainFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, for: indexPath) as! FeedCollectionViewCell
        cell.image.kf.setImage(with: URL(string: self.viewModel.photos[indexPath.item].urls.small))
        return cell
    }
}

    // MARK: - UICollectionViewDelegate

extension MainFeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = viewModel.photos[indexPath.item]
        let vc = DetailViewController(photoURL: selectedItem.urls.regular,
                                      downloads: "\(selectedItem.downloads ?? 0)",
                                      author: selectedItem.user.name,
                                      location: selectedItem.user.location ?? "Неизвестно",
                                      creationDate: selectedItem.created_at)

        navigationController?.pushViewController(vc, animated: true)
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension MainFeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.size.width / 2) - 1, height: (collectionView.frame.size.width / 2) - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainFeedViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else { return }
        viewModel.searchPhotos(searchQuery: searchQuery) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getFeed {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
