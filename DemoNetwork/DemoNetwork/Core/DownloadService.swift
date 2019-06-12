//
//  DownloadService.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/11/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import Foundation
typealias DownloadCompleteHandler = ((_ index:Int?,_ error: Error?) -> Void)
class DownloadService:NSObject {
    
    // Get local file path: download task stores tune here; AV player plays it.
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    var activeDownloads : [URL:DownloadTask] = [:]

    var completionHandler: DownloadCompleteHandler?

    private lazy var downloadSession:URLSession = {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    func startDownload(_ track: Track,completion:DownloadCompleteHandler?) {
        self.completionHandler = completion
        let downloadTak = DownloadTask(track: track)
        downloadTak.task = downloadSession.downloadTask(with: track.previewURL)
        downloadTak.task?.resume()
        downloadTak.isDownloading = true
        
        activeDownloads[downloadTak.track.previewURL] = downloadTak
    }
    
    func cancelDownload(_ track: Track) {
        if let downloadTask = activeDownloads[track.previewURL] {
            downloadTask.task?.cancel()
            activeDownloads[track.previewURL] = nil
        }
    }
    
}

extension DownloadService:URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let sourceURL = downloadTask.originalRequest?.url else { return }
        let downloadTask = activeDownloads[sourceURL]
        activeDownloads[sourceURL] = nil
        let destinationURL = localFilePath(for: sourceURL)
        print(destinationURL)
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: destinationURL)
        do {
            try fileManager.copyItem(at: location, to: destinationURL)
            downloadTask?.track.downloaded = true
        } catch let error {
            if let completion = self.completionHandler {
                completion(nil,error)
            }
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
        DispatchQueue.main.async {
            if let completion = self.completionHandler {
                completion(downloadTask?.track.index,nil)
            }
            
        }
    }
    
   
    func localFilePath(for url: URL) -> URL {
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
}

