//
//  iTuneSearchInterface.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/11/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit
import AVFoundation

protocol iTuneSearchPresenterToView:class {
    //Search Delegate
    func searchResult(results:[Track])
    func showError(error:String)
    
    //Download Delegate
    func updateTrack(with index:Int)
    func updateTrackProgress(with index: Int,progress: Float, totalSize: String)
}

protocol iTuneSearchViewToPresenter:class {
    var view:iTuneSearchPresenterToView?{get set}
    var interactor:iTuneSearchPresenterToInteractor? {get set}
    var router:iTuneSearchPresenterToRouter? {get set}
    
    func doSearchiTune(text:String)
    func cancelSearch()
    
    func downloadTrack(track:Track)
    func cancelDownload(track:Track)
    func pauseDownloadTrack(track:Track)
    func resumeTrack(track:Track)
    
    func playTrack(track:Track)
    func getDownloadTask(url:URL) -> DownloadTask?
}

protocol iTuneSearchPresenterToRouter:class {
    static func createModule() -> UINavigationController
    
    func showPlayTrack(player:AVPlayer)
}

protocol iTuneSearchPresenterToInteractor:class {
    
    var presenter:iTuneSearchInteractorToPresenter? {get set}
    
    func doSearchiTune(text:String)
    func cancelSearch()
    
    func downloadTrack(track:Track)
    func cancelDownload(track:Track)
    func pauseDownloadTrack(track:Track)
    func resumeTrack(track:Track)
    
    func getDownloadTask(url:URL) -> DownloadTask?
    func getLocalFilePath(for url:URL) -> URL
}



protocol iTuneSearchInteractorToPresenter:class {
    func searchResults(results:[Track]?,error:String?)
    
    func downloadComplete(index:Int?, error:Error?)
    
    func updateTrackProgress(with index: Int,progress: Float, totalSize: String)
}


