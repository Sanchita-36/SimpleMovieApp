//
//  DetailViewController.swift
//  MovieAppAssignment
//
//  Created by Mac on 05/03/22.
//

import UIKit
import youtube_ios_player_helper

class DetailViewController: UIViewController, YTPlayerViewDelegate {
    
    @IBOutlet weak var youtubePlayerView: YTPlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var videoKeySelected = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.videoKeySelected = UserDefaults.standard.string(forKey: "videoLinkString")!
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
        
        youtubePlayerView.delegate = self
        youtubePlayerView.load(withVideoId: "\(videoKeySelected)",
                               playerVars: ["playsinline": 1])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        youtubePlayerView.playVideo()
    }
    
    @objc func tapGestureAction(sender:UITapGestureRecognizer){
        removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}
