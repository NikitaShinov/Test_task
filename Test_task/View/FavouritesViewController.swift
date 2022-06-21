//
//  FavouritesViewController.swift
//  Test_task
//
//  Created by max on 19.06.2022.
//

import UIKit

class FavouritesViewController: UITableViewController {
    
    var viewModel: FavouritesViewModelProtocol!
    
    let refresh: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        return refresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        title = "Избранное"
        viewModel = FavouritesViewModel()
        viewModel.retrievePhoto {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.register(FavouritesTableViewCell.self, forCellReuseIdentifier: FavouritesTableViewCell.indentifier)
        tableView.refreshControl = refresh
        
    }
    
    @objc private func pulledToRefresh(sender: UIRefreshControl) {
        viewModel.retrievePhoto {
            self.tableView.reloadData()
        }
        sender.endRefreshing()
    }
    
    // MARK: - UITableDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesTableViewCell.indentifier, for: indexPath) as! FavouritesTableViewCell
        cell.authorName.text = viewModel.getAuthorName(at: indexPath)
        cell.picture.kf.setImage(with: URL(string: viewModel.getPhotoURL(at: indexPath)))
        print (viewModel.getPhotoURL(at: indexPath))
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let photoToDelete = viewModel.photos[indexPath.row]
            viewModel.photos.remove(at: indexPath.row)
            StorageManager.shared.delete(photo: photoToDelete)
            presentAlert(title: nil, message: "Фото удалено из избранных")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = DetailViewController(photoURL: viewModel.getPhotoURL(at: indexPath),
                                      downloads: viewModel.photos[indexPath.row].downloads ?? "",
                                      author: viewModel.getAuthorName(at: indexPath),
                                      location: viewModel.getLocation(at: indexPath),
                                      creationDate: viewModel.getDate(at: indexPath))
        navigationController?.pushViewController(vc, animated: true)
    }
}
