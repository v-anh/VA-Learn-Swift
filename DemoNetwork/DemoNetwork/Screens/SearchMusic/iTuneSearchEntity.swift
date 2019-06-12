//
//  iTuneSearchEntity.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/11/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import Foundation

class Track {
    let name: String
    let artist: String
    let previewURL: URL
    let index: Int
    var downloaded = false
    
    init(name: String, artist: String, previewURL: URL, index: Int) {
        self.name = name
        self.artist = artist
        self.previewURL = previewURL
        self.index = index
    }
}


class DownloadTask {
    var track:Track
    init(track:Track) {
        self.track = track
    }
    
    var task:URLSessionDownloadTask?
    var isDownloading = false
    var resume:Data?
    
    var progress:Float = 0
    var totalSize:String?
}
