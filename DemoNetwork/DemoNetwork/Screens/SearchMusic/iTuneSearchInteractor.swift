//
//  iTuneSearchInteractor.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/11/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String: Any]
class iTuneSearchInteractor:NSObject, iTuneSearchPresenterToInteractor {
    
    var tracks: [Track] = []
    var errorMessage = ""
    
    weak var presenter: iTuneSearchInteractorToPresenter?
    
    private var networkMaker = VANetworkWithConfig()
    
    // Get local file path: download task stores tune here; AV player plays it.
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    private lazy var downloadSession:URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "backgroundSessionConfiguration")
        config.waitsForConnectivity = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    private lazy var downloadMaker = DownloadService(session: self.downloadSession)
    
    
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
        downloadMaker.cancelDownload(track)
    }
    
    func pauseDownloadTrack(track:Track) {
        self.downloadMaker.pauseDownload(track)
    }
    
    func resumeTrack(track:Track) {
        self.downloadMaker.resumeDownload(track)
    }
    
    func getDownloadTask(url:URL) -> DownloadTask? {
        return self.downloadMaker.activeDownloads[url]
    }
    
    func getLocalFilePath(for url: URL) -> URL {
        return documentsPath.appendingPathComponent(url.lastPathComponent)
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

extension iTuneSearchInteractor:URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let sourceURL = downloadTask.currentRequest?.url else { return }
        let downloadTask = downloadMaker.activeDownloads[sourceURL]
        downloadMaker.activeDownloads[sourceURL] = nil
        let destinationURL = getLocalFilePath(for: sourceURL)
        print(destinationURL)
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: destinationURL)
        do {
            try fileManager.copyItem(at: location, to: destinationURL)
            downloadTask?.track.downloaded = true
        } catch let error {
            self.presenter?.downloadComplete(index: nil, error: error)
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
        DispatchQueue.main.async {
            self.presenter?.downloadComplete(index: downloadTask?.track.index, error: nil)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard let url = downloadTask.currentRequest?.url, let download = downloadMaker.activeDownloads[url] else {
            return
        }
        download.progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
        download.totalSize = totalSize
        DispatchQueue.main.async {
            self.presenter?.updateTrackProgress(with: download.track.index, progress: download.progress, totalSize: totalSize)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print("didResumeAtOffset fileOffset \(fileOffset), expectedTotalBytes:\(expectedTotalBytes) ")
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate,let completionHandler = appDelegate.backgroundCompletionHandler {
                    appDelegate.backgroundCompletionHandler = nil
                    completionHandler()
            }
        }
    }
}
