//
//  iTuneSearchPresenter.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/11/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit


class iTuneSearchPresenter: iTuneSearchViewToPresenter {
    
    
    weak var view: iTuneSearchPresenterToView?
    
    var interactor: iTuneSearchPresenterToInteractor?
    
    var router: iTuneSearchPresenterToRouter?
    
    func doSearchiTune(text: String) {
        interactor?.doSearchiTune(text: text)
    }
    
    func cancelSearch() {
        interactor?.cancelSearch()
    }
    
    func downloadTrack(track:Track) {
        interactor?.downloadTrack(track: track)
    }
    
    func cancelDownload(track:Track) {
        interactor?.cancelDownload(track: track)
    }
    
    func pauseDownloadTrack(track:Track) {
        interactor?.pauseDownloadTrack(track: track)
    }
    
    func resumeTrack(track:Track) {
        interactor?.resumeTrack(track: track)
    }
    
    func getDownloadTask(url: URL) -> DownloadTask? {
        return interactor?.getDownloadTask(url: url)
    }
    
    
}

extension iTuneSearchPresenter: iTuneSearchInteractorToPresenter {
    func searchResults(results: [Track]?, error: String?) {
        
        if let error = error {
            self.view?.showError(error: error)
            return
        }
        guard let results = results else {
            return
        }
        
        self.view?.searchResult(results: results)
    }
    
    
}
