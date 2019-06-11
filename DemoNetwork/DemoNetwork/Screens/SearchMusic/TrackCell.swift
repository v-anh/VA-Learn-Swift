
//
//  TrackCell.swift
//  DemoNetwork
//
//  Created by Anh Tran on 6/11/19.
//  Copyright © 2019 Anh Tran. All rights reserved.
//

import UIKit

protocol TrackCellDelegate:class {
    func pauseTapped(_ cell: TrackCell)
    func resumeTapped(_ cell: TrackCell)
    func cancelTapped(_ cell: TrackCell)
    func downloadTapped(_ cell: TrackCell)
}

class TrackCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    
    weak var delegate : TrackCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title.text = ""
        self.artist.text = ""
        progress.progress = 0.0
        progress.isHidden = true
        progressLabel.isHidden = true
        cancelButton.isHidden = true
        pauseButton.isHidden = true
        downloadButton.isHidden = true
    }
    
    func setupCell(track:Track,downloadTask:DownloadTask?) {
        
        // Download controls are Pause/Resume, Cancel buttons, progress info
        var showDownloadControls = false
        // Non-nil Download object means a download is in progress
        if let download = downloadTask {
            showDownloadControls = true
            let title = download.isDownloading ? "Pause" : "Resume"
            pauseButton.setTitle(title, for: .normal)
            progressLabel.text = download.isDownloading ? "Downloading..." : "Paused"
        }
        
        pauseButton.isHidden = !showDownloadControls
        cancelButton.isHidden = !showDownloadControls
        progress.isHidden = !showDownloadControls
        progressLabel.isHidden = !showDownloadControls
        
        self.title.text = track.name
        self.artist.text = track.artist
        
        // If the track is already downloaded, enable cell selection and hide the Download button
        selectionStyle = track.downloaded ? UITableViewCell.SelectionStyle.gray : UITableViewCell.SelectionStyle.none
        downloadButton.isHidden = track.downloaded || showDownloadControls
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func downloadAction(_ sender: Any) {
        self.delegate?.downloadTapped(self)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.delegate?.cancelTapped(self)
    }
    
    @IBAction func pauseAction(_ sender: Any) {
        if(pauseButton.titleLabel!.text == "Pause") {
            delegate?.pauseTapped(self)
        } else {
            delegate?.resumeTapped(self)
        }
    }
}
