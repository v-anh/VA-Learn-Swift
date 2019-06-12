//
//  iTuneSearchInterface.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/11/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import Foundation

protocol iTuneSearchPresenterToView:class {
    //Search Delegate
    func searchResult(results:[Track])
    func showError(error:String)
    
    //Download Delegate
    func updateTrack(with index:Int)
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
    
    func getDownloadTask(url:URL) -> DownloadTask?
}

protocol iTuneSearchPresenterToRouter:class {
    static func createModule() -> iTuneSearchViewController
    
    func showPlayTrack()
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
}



protocol iTuneSearchInteractorToPresenter:class {
    func searchResults(results:[Track]?,error:String?)
    
    func downloadComplete(index:Int?, error:Error?)
}


