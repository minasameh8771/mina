//
//  movieCellTableViewCell.swift
//  RegisterApp
//
//  Created by mina sameh on 3/18/20.
//  Copyright © 2020 minafcis16. All rights reserved.
//

import UIKit

class movieCellTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var Rating: UILabel!
    @IBOutlet weak var yearRealas: UILabel!
    @IBOutlet weak var genre: UILabel!
    
    func loadData(movie : MyMovie)
    {
        var genreStr = ""
        for item in movie.genre{
            genreStr += item + " "
        }
        genre.text = genreStr
        detailsLabel.text = "click for details"
        nameLabel.text = movie.title
        Rating.text = String(movie.rating)
        yearRealas.text = String(movie.releaseYear)
        photo.sd_setImage(with: URL(string: movie.image), completed: nil)
    }
    
}
