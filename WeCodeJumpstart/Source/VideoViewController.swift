//
//  VideoViewController.swift
//  WeCodeJumpstart
//
//  Created by Jereme Claussen on 1/4/19.
//  Copyright © 2019 WeCode. All rights reserved.
//

import AVKit
import UIKit

class VideoViewController: AVPlayerViewController {

    // MARK: Properties

    override var prefersStatusBarHidden: Bool { return UIDevice.current.orientation.isLandscape }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configurePlayer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        player?.play()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        player?.pause()
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)

        let isLandscape = newCollection.verticalSizeClass == .compact

        coordinator.animate(
            alongsideTransition: { context in
                self.navigationController?.navigationBar.isHidden = isLandscape
                self.tabBarController?.tabBar.isHidden = isLandscape
            },
            completion: nil
        )
    }

    // MARK: Configuration

    private func configureView() {
        title = "Video"
    }

    private func configurePlayer() {
        if let url = Bundle.main.url(forResource: "just do it", withExtension: "mp4") {
            let player = AVPlayer(url: url)
            self.player = player
        }
    }
}

