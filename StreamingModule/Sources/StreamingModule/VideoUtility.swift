//
//  File.swift
//  
//
//  Created by Saif on 07/07/22.
//

import Foundation
import UIKit

protocol VideoUtilityAction {
    func playVideo(for url:URL, target:UIViewController)
}

public class VideoUtility {
    private init() { }
    public static let shared = VideoUtility()
}

extension VideoUtility: VideoUtilityAction {
    public func playVideo(for url:URL, target:UIViewController) {
        VideoPlayer().playVideo(for: url, from: target)
    }
}
