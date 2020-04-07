//
//  movieDetailsViewController.swift
//  RegisterApp
//
//  Created by mina sameh on 3/18/20.
//  Copyright © 2020 minafcis16. All rights reserved.
//

import UIKit
import SDWebImage

class movieDetails: UIViewController {

    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var RyearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var movie : MyMovie!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadData()
    }
    
    func loadData() {
        
        var genreStr = ""
        for item in movie.genre{
            genreStr += item + " "
        }
        
        movieNameLabel.text = movie.title
        genreLabel.text = genreStr
        RyearLabel.text = String(movie.releaseYear)
        ratingLabel.text = String(movie.rating)
        photo.sd_setImage(with: URL(string: movie.image), completed: nil)
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
