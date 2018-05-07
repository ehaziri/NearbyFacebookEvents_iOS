//
//  EventCell.swift
//  NearbyEventsFacebook
//
//  Created by Xona on 4/12/18.
//

import UIKit
import AlamofireImage

class EventCell: UITableViewCell {
    @IBOutlet weak var eventImg: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    var event: Event?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
     
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
