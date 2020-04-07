//
//  MediaFinder.swift
//  RegisterApp
//
//  Created by mina sameh on 3/31/20.
//  Copyright © 2020 minafcis16. All rights reserved.
//

import UIKit
import Foundation
import AVKit
import SQLite



class MediaFinder: UIViewController {

    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var media = [Media]()
    var selectedSegmebtIndex = -1
    var term = ""
    var entity = MediaType.music.rawValue
    let baseURL = "https://itunes.apple.com/search"
    let cellIdentifier = "MediaCell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        loadCatchData()

        // Do any additional setup after loading the view.
    }
    
    func loadCatchData(){
        let mediaTemp = SqliteManager.LoadDB()
        if mediaTemp.count > 0 {
            self.media = mediaTemp
            self.tableView.reloadData()
        }
    }
    
    @IBAction func segmentSelectAction(_ sender: Any) {
        selectedSegmebtIndex = segmentControll.selectedSegmentIndex
        switch selectedSegmebtIndex {
        case 0:
            entity = MediaType.music.rawValue
        case 1 :
            entity = MediaType.movie.rawValue
        case 2 :
            entity = MediaType.tvShow.rawValue
        default:
            entity = MediaType.music.rawValue
        }

    }
    
    
    @IBAction func loadMediaDataBTN(_ sender: Any) {
        term = artistNameTextField.text!
        let parm = ["term" : term , "entity" : entity]
        ApiManager.loadMedia(self.baseURL, parm, completion: { (error, media) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let mediaArr = media {
                SqliteManager.ClearDB()
                if mediaArr.count > 0 {
                    self.media = mediaArr
                    SqliteManager.InsertToDB(media: mediaArr)
                    self.tableView.reloadData()
                }
                
            }
            
        })
    }

}

extension MediaFinder: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.media.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MediaCell else {return UITableViewCell()}
        
        cell.configureCell(media: self.media[indexPath.row])
        cell.onClickImage()
        
        return cell

    }
    
  /*  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99
    } */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        playVideo(index: index)
        
    }
    
    func playVideo(index : Int){
        
        let videoUrl = URL(string: media[index].previewUrl)
        guard let videoURL =  videoUrl else {return}
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true, completion: {
            player.play()
        })
        
    }
    
    
    
    
}
