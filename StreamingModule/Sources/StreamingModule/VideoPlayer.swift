//
//  VideoPlayer.swift
//  
//
//  Created by Saif on 08/07/22.
//

import Foundation
import UIKit
import AVKit


protocol VideoPlayerActions  {
    func playVideo(for url:URL, from target:UIViewController)
}

class VideoPlayer {
    lazy var  playerViewController: AVPlayerViewController = {
       
        let playerController = AVPlayerViewController()
                
        playerController.videoGravity = .resizeAspectFill

        return playerController
    }()
}

extension VideoPlayer: VideoPlayerActions {
    func playVideo(for url:URL, from target:UIViewController) {
        let player = AVPlayer(url: url)
        playerViewController.player = player
        player.play()
        target.present(playerViewController, animated: true)
    }
}
