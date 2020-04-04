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
    
    var songArray = [album(albumImage: "timezones.jpg", songName: "Timezones", singerName: "Manila Grey", song: "MANILAGREY-Timezones"), album(albumImage: "silverskies.jpg", songName: "Silver Skies", singerName: "Manila Grey", song: "MANILAGREY-SilverSkies"), album(albumImage: "youthwater.jpg", songName: "Youth Water", singerName: "Manila Grey", song: "MANILAGREY-YouthWater")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playSong()
        currentTime()
        updatePlayer()
        
    }
    //play and pause
    @IBAction func playerButton(_ sender: UIButton) {
        
        if player.rate == 0 {
            playerButton.setImage(UIImage(named: "pause.png"), for: .normal)
            player.play()
        } else {
            playerButton.setImage(UIImage(named: "play.png"), for: .normal)
            player.pause()
        }
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        playIndex = playIndex - 1
        playSong()
        updatePlayer()
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        playIndex = playIndex + 1
        playSong()
        updatePlayer()
    }
    //reset slider
    @IBAction func timeObserver(_ sender: UISlider) {
        let seconds = Int64(songSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
        currentTime()
        updatePlayer()
        
    }
    
    
    func playSong() {
        if playIndex < songArray.count {
            if playIndex < 0 {
                playIndex = songArray.count - 1
            }
            
            albumImage.image = UIImage(named: songArray[playIndex].albumImage)
            songnameLabel.text = songArray[playIndex].songName
            singernameLabel.text = songArray[playIndex].singerName
            //download file, get location on the moblie app
            let fileUrl = Bundle.main.url(forResource: songArray[playIndex].song, withExtension: "mp4")
            //bulid play item
            playerItem = AVPlayerItem(url: fileUrl!)
            //remove current play item in case replay same song
            player.removeAllItems()
            //play current item
            player.replaceCurrentItem(with: playerItem)
            //looper = AVPlayerLooper(player: player, templateItem: playerItem!)
            
            player.play()
            
            
            //set button image when playing on beginning
            playerButton.setImage(UIImage(named: "pause.png"), for: .normal)
            
        } else {
            playIndex = 0
        }
    }
    
    func currentTime() {
        //run per sec
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main, using: { (CMTime) in
            if self.player.currentItem?.status == .readyToPlay {
                let currentTime = CMTimeGetSeconds(self.player.currentTime())
                self.songSlider.value = Float(currentTime)
                self.currentLabel.text = self.formatConversion(time: currentTime)
                self.lengthLabel.text = "-\(self.formatConversion(time: Float64(self.songSlider.maximumValue - self.songSlider.value)))"
                
            }
        })
    }
    
    //update slider time value
    func updatePlayer() {
        guard let duration = playerItem?.asset.duration else {
            return
        }
        let seconds = CMTimeGetSeconds(duration)
        // show playing song total time on Label
        lengthLabel.text = formatConversion(time: seconds)
        songSlider.minimumValue = 0
        songSlider.maximumValue = Float(seconds)
        
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

