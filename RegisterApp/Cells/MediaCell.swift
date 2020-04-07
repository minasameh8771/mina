//
//  MediaCell.swift
//  RegisterApp
//
//  Created by mina sameh on 4/1/20.
//  Copyright © 2020 minafcis16. All rights reserved.
//

import UIKit
import SDWebImage

class MediaCell: UITableViewCell {
    

    @IBOutlet weak var photoOfContent: UIImageView!
    @IBOutlet weak var artistNameOrTrackName: UILabel!
    @IBOutlet weak var longDescrobOrArtistName: UILabel!
    
    
    func onClickImage () {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        photoOfContent.isUserInteractionEnabled = true
        photoOfContent.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        bouncingImage()
    }
    
    func bouncingImage(){
        photoOfContent.transform = CGAffineTransform(scaleX: 0.3, y: 0)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.photoOfContent.transform = .identity
        }, completion: nil)
    }
    
    func configureCell(media : Media){
        self.photoOfContent.sd_setImage(with: URL(string: media.artworkUrl100), completed: nil)

        switch media.getType() {
        case MediaType.music:
            guard let temp1 = media.trackName ,let temp2 = media.artistName else {return}
            artistNameOrTrackName.text = temp1
            longDescrobOrArtistName.text = temp2
            
        case MediaType.movie :
            artistNameOrTrackName.text = media.trackName
            longDescrobOrArtistName.text = media.longDescription
            
        case MediaType.tvShow :
            artistNameOrTrackName.text = media.artistName
            longDescrobOrArtistName.text = media.longDescription
            
        default:
            print("classify data error")
            return
        }
    }
    
    
}
