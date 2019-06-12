//
//  iTuneSearchInteractor.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/11/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String: Any]
class iTuneSearchInteractor: iTuneSearchPresenterToInteractor {
    
    var tracks: [Track] = []
    var errorMessage = ""
    
    weak var presenter: iTuneSearchInteractorToPresenter?
    
    var activeDownloads : [URL:DownloadTask] = [:]
    
    private var networkMaker = VANetworkWithConfig()
    
    private var downloadMaker = DownloadService()
    
    
    func doSearchiTune(text: String) {
        self.doQuery(text: text)
    }
    
    func cancelSearch() {
        
    }
    
    func downloadTrack(track:Track) {
        downloadMaker.startDownload(track) { (index, error) in
            self.presenter?.downloadComplete(index: index, error: error)
        }
    }
    
    func cancelDownload(track:Track) {
        
    }
    
    func pauseDownloadTrack(track:Track) {
        
    }
    
    func resumeTrack(track:Track) {
        
    }
    
    func getDownloadTask(url:URL) -> DownloadTask? {
        return self.downloadMaker.activeDownloads[url]
    }
}


extension iTuneSearchInteractor {
    fileprivate func doQuery(text: String) {
        if var urlComponents = URLComponents(string:
            "https://itunes.apple.com/search") {
            urlComponents.query = "media=music&entity=song&term=\(text)"
            
            guard let url = urlComponents.url else { return }
            networkMaker.load(url: url) { (data, error) in
                
                if let error = error {
                    print("LoadImagePresenter loadWebFailed: \(error)")
                    self.presenter?.searchResults(results: nil, error: error.localizedDescription)
                    return
                }
                guard let data = data else {
                    self.errorMessage = "LoadImagePresenter loadWebSuccess but there some thing hanpen with data"
                    print(self.errorMessage)
                    self.presenter?.searchResults(results: nil, error: self.errorMessage)
                    return
                }
                self.updateSearchResults(data)
                self.presenter?.searchResults(results: self.tracks, error: nil)
            }
        }
    }
    fileprivate func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        tracks.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        var index = 0
        for trackDictionary in array {
            if let trackDictionary = trackDictionary as? JSONDictionary,
                let previewURLString = trackDictionary["previewUrl"] as? String,
                let previewURL = URL(string: previewURLString),
                let name = trackDictionary["trackName"] as? String,
                let artist = trackDictionary["artistName"] as? String {
                tracks.append(Track(name: name, artist: artist, previewURL: previewURL, index: index))
                index += 1
            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
}
