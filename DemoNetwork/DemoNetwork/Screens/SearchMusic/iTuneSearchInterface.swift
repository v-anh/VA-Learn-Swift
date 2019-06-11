//
//  iTuneSearchInterface.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/11/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import Foundation

protocol iTuneSearchPresenterToView:class {
    func searchResult(results:[Track])
    func showError(error:String)
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
}


