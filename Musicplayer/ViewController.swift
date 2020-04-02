//
//  ViewController.swift
//  Musicplayer
//
//  Created by ChiuWanNuo on 01/04/2020.
//  Copyright © 2020 ChiuWanNuo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var songnameLabel: UILabel!
    @IBOutlet weak var singernameLabel: UILabel!
    @IBOutlet weak var songSlider: UISlider!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var playerButton: UIButton!
    
    let player = AVQueuePlayer()
    var playerItem:AVPlayerItem?
    var looper: AVPlayerLooper?
    
    var playIndex = 0
    
    var songArray = [album(albumImage: "timezones.jpg", songName: "Timezones", singerName: "Manila Grey"), album(albumImage: "silverskies.jpg", songName: "Silver Skies", singerName: "Manila Grey"), album(albumImage: "youthwater.jpg", songName: "Youth Water", singerName: "Manila Grey")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playSong()
        
    }
    
    @IBAction func playerButton(_ sender: UIButton) {
        player.replaceCurrentItem(with: playerItem)
        if player.rate == 0 {
            playerButton.setImage(UIImage(named: "pause.png"), for: .normal)
            player.play()
        } else {
            playerButton.setImage(UIImage(named: "play.png"), for: .normal)
            player.pause()
        }
        
    }
    
    @IBAction func AcBackButton(_ sender: UIButton) {
        playIndex = playIndex - 1
        playSong()
    }
    
    @IBAction func AcNextButton(_ sender: UIButton) {
        playIndex = playIndex + 1
        playSong()
    }
    
    @IBAction func timeObserver(_ sender: UISlider) {
        let seconds = Int64(songSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
        CurrentTime()
        updatePlayer()
        player.replaceCurrentItem(with: playerItem)
    }
    
    
    func playSong() {
        if playIndex < songArray.count {
            if playIndex < 0 {
                playIndex = songArray.count - 1
            }
            
            albumImage.image = UIImage(named: songArray[playIndex].albumImage)
            songnameLabel.text = songArray[playIndex].songName
            singernameLabel.text = songArray[playIndex].singerName

            let fileUrl = Bundle.main.url(forResource: songArray[playIndex].songName, withExtension: "mp4")
            playerItem = AVPlayerItem(url: fileUrl!)
            player.replaceCurrentItem(with: playerItem)
            looper = AVPlayerLooper(player: player, templateItem: playerItem!)
            
            songSlider.setValue(Float(0), animated: true)
            let targetTime:CMTime = CMTimeMake(value: Int64(0), timescale: 1)
            
            player.play()
            
            let duration : CMTime = playerItem!.asset.duration
            let seconds : Float64 = CMTimeGetSeconds(duration)
            songSlider.minimumValue = 0
            songSlider.maximumValue = Float(seconds)
            
        } else {
            playIndex = 0
        }
    }
    
    func CurrentTime() {
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main, using: { (CMTime) in
            if self.player.currentItem?.status == .readyToPlay {
                let currentTime = CMTimeGetSeconds(self.player.currentTime())
                self.songSlider.value = Float(currentTime)
                self.currentLabel.text = self.formatConversion(time: currentTime)
            }
        })
    }
    
    //計算顯示歌曲長度
    func updatePlayer() {
        guard let duration = playerItem?.asset.duration else {
            return
        }
        let seconds = CMTimeGetSeconds(duration)
        lengthLabel.text = formatConversion(time: seconds)
        songSlider.minimumValue = 0
        songSlider.maximumValue = Float(seconds)
        songSlider.isContinuous = true
    }
    
    func formatConversion(time: Float64) -> String {
        let songLength = Int(time)
        let minutes = Int(songLength / 60)
        let seconds = Int(songLength % 60)
        var time = ""
        if minutes < 10 {
            time = "0\(minutes):"
        } else {
            time = "\(minutes)"
        }
        if seconds < 10 {
            time += "0\(seconds)"
        } else {
            time += "\(seconds)"
        }
        return time
    }
    
    


}

