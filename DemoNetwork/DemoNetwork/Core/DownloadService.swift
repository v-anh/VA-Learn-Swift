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

    var downloadSession:URLSession
    
    init(session:URLSession) {
        self.downloadSession = session
    }
    
    func startDownload(_ track: Track,completion:DownloadCompleteHandler?) {
        self.completionHandler = completion
        let downloadTask = DownloadTask(track: track)
        downloadTask.task = downloadSession.downloadTask(with: track.previewURL)
        downloadTask.task?.resume()
        downloadTask.isDownloading = true
        
        activeDownloads[downloadTask.track.previewURL] = downloadTask
    }
    
    func cancelDownload(_ track: Track) {
        if let downloadTask = activeDownloads[track.previewURL] {
            downloadTask.task?.cancel()
            activeDownloads[track.previewURL] = nil
        }
    }
    
    func pauseDownload(_ track: Track)  {
        if let downloadTask = activeDownloads[track.previewURL] {
            downloadTask.task?.cancel(byProducingResumeData: { (data) in
                downloadTask.resume = data
            })
            downloadTask.isDownloading = false
        }
    }
    
    func resumeDownload(_ track: Track) {
        if let downloadTask = activeDownloads[track.previewURL] {
            if let resumeData = downloadTask.resume {
                downloadTask.task = downloadSession.downloadTask(withResumeData: resumeData)
            } else {
                downloadTask.task = downloadSession.downloadTask(with: downloadTask.track.previewURL)
            }
            downloadTask.task?.resume()
            downloadTask.isDownloading = true
        }
    }
    
}



