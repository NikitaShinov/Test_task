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
    
    private func configureUI() {
        title = "Избранное"
        viewModel = FavouritesViewModel()
        viewModel.retrievePhoto {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        print (viewModel.photos.count)
        tableView.register(FavouritesTableViewCell.self, forCellReuseIdentifier: FavouritesTableViewCell.indentifier)
        tableView.refreshControl = refresh
        
    }
    
    @objc private func pulledToRefresh(sender: UIRefreshControl) {
        viewModel.retrievePhoto {
            self.tableView.reloadData()
        }
        sender.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesTableViewCell.indentifier, for: indexPath) as! FavouritesTableViewCell
        cell.authorName.text = viewModel.getAuthorName(at: indexPath)
        cell.picture.kf.setImage(with: URL(string: viewModel.getPhotoURL(at: indexPath)))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let photoToDelete = viewModel.photos[indexPath.row]
            viewModel.photos.remove(at: indexPath.row)
            StorageManager.shared.delete(photo: photoToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
