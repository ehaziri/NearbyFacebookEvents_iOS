//
//  DetailViewController.swift
//  NearbyEventsFacebook
//
//  Created by Xona on 4/12/18.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var eventImg: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventBackground: UIImageView!
    @IBOutlet weak var eventInfo: UITextView!
    @IBOutlet weak var eventPlace: UILabel!
    
    var selectedEvent:Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let eventBackgroundURL = URL.init(string: (selectedEvent?.profilePicture)!)
        if eventBackgroundURL != nil {
            eventBackground.af_setImage(withURL: eventBackgroundURL!)
        }
        
        let eventImgURL = URL.init(string: (selectedEvent?.coverPicture)!)
        if eventImgURL != nil {
            eventImg.af_setImage(withURL: eventImgURL!)
        }
        eventTitle.text = selectedEvent.name
        eventDate.text = "Kur: \(selectedEvent.date)"
        eventInfo.text = selectedEvent.description
        eventPlace.text = "Ku: Rruga \(selectedEvent.venue)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
