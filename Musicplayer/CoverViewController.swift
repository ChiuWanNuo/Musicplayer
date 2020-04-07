//
//  CoverViewController.swift
//  Musicplayer
//
//  Created by ChiuWanNuo on 04/04/2020.
//  Copyright © 2020 ChiuWanNuo. All rights reserved.
//

import UIKit

class CoverViewController: UIViewController, UITableViewDataSource {
    
     var songArray = [album(albumImage: "timezones.jpg", songName: "Timezones", singerName: "Manila Grey", song: "MANILAGREY-Timezones"), album(albumImage: "silverskies.jpg", songName: "Silver Skies", singerName: "Manila Grey", song: "MANILAGREY-SilverSkies"), album(albumImage: "youthwater.jpg", songName: "Youth Water", singerName: "Manila Grey", song: "MANILAGREY-YouthWater")]
    
    var index = 0
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var playmusicButton: UIButton!
    @IBOutlet weak var listTableView: UITableView!    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! TableViewCell
        
        let list = songArray[indexPath.row]
        
        cell.listImage.image = UIImage(named: list.albumImage)
        cell.listsingerLabel.text = list.singerName
        cell.listsongnameLabel.text = list.songName
        
        return cell
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coverImage.image = UIImage(named: "cover")

        // Do any additional setup after loading the view.
    }
    
   

    @IBSegueAction func playMusic(_ coder: NSCoder) -> ViewController? {
        let controller = ViewController(coder: coder)
        return controller
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
