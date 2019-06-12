//
//  iTuneSearchViewController.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/11/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit

class iTuneSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter : iTuneSearchViewToPresenter?
    
    fileprivate var data:[Track]?
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

}
extension iTuneSearchViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = self.data {
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell") as? TrackCell else {
            fatalError("TrackCell isn't registered!!!!")
        }
        
        if let track = data?[indexPath.row] {
            cell.delegate = self
            cell.setupCell(track: track, downloadTask: presenter?.getDownloadTask(url: track.previewURL))
        }
        return cell
    }
}

extension iTuneSearchViewController:TrackCellDelegate {
    func pauseTapped(_ cell: TrackCell) {
        
    }
    
    func resumeTapped(_ cell: TrackCell) {
        
    }
    
    func cancelTapped(_ cell: TrackCell) {
        
    }
    
    func downloadTapped(_ cell: TrackCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let track = data?[indexPath.row]
            presenter?.downloadTrack(track: track!)
            reload(indexPath.row)
        }
        
    }
    
    // Update track cell's buttons
    func reload(_ row: Int) {
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
    }
    
}

extension iTuneSearchViewController:UISearchBarDelegate {
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        if !searchBar.text!.isEmpty {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            presenter?.doSearchiTune(text: searchBar.text!)
        }
    }
}

extension iTuneSearchViewController:iTuneSearchPresenterToView {
    func updateTrack(with index: Int) {
        reload(index)
    }
    
    func searchResult(results: [Track]) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.data = results
        self.tableView.reloadData()
        self.tableView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func showError(error: String) {
        self.tableView.reloadData()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapRecognizer)
    }
}
