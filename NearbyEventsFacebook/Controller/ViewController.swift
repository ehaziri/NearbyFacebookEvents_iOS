//
//  ViewController.swift
//  NearbyEventsFacebook
//
//  Created by Xona on 4/12/18.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import AlamofireImage


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var sliderValueLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentSliderValue = 2000
    var events = [Event]()
    var event:Event!
    
    var locationManager:CLLocationManager!
    
    //let API_URL = "http://45.62.254.243:3000/events"
    let API_URL = "http://ios.appbit.es/uploads/iosdev/api/events"
    
    //let API_KEY = "EAACEdEose0cBAFekdaqfmlV7kZBTjSkbZCysgeJ5z6b3qeqCZBHRtse71Ttoa325jkWAbghQIFvZA7C3bcTCNbXa6wOJQb4j11I5qlzMdOnn9c9ILjZBrCSU0QB66nlZA389GjGc1WwKy4tAKVBC6DU890UZBnGzL5MZArwc3PCN6QF9dStG8ZAE6qf79S24Df8UZD"
    
    let API_KEY = "FBACCESSTOKEN"

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        // Do any additional setup after loading the view, typically from a nib.

        tableView.register(UINib.init(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "eventCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
        self.updateScreen()
    }
    
    func merrEventin(parameters:[String:String]){
        
        Alamofire.request(API_URL, method: .get, parameters: parameters).responseData { (fbData) in
            print("Ddddddddddddddddddddddddddddd \(parameters["distance"])")
            self.events.removeAll()
            if fbData.result.isSuccess{
                let fbJSON = JSON(fbData.result.value)
                print(fbJSON)
                for(_, value) in JSON(fbJSON["events"]){
                    let name = value["name"].stringValue
                    let profilePicture = value["venue"]["profilePicture"].stringValue
                    let date = value["startTime"].stringValue
                    let coverPicture = value["coverPicture"].stringValue
                    let description = value["description"].stringValue
                    let venue = value["place"]["location"]["street"].stringValue
                    
                    let event = Event(profilePicture: profilePicture, name: name, date: date, coverPicture: coverPicture, description: description, venue: venue)
                    
                    self.events.append(event)
                }
                
                self.tableView.reloadData()
                self.updateScreen()
            }
            else{
                print("Gabim ne marrje te rezultateve.")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Gabim gjate lokacionit")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        if location.horizontalAccuracy > 0{
            manager.stopUpdatingLocation()
            //let latitude = String(location.coordinate.latitude)
            //let longitude = String(location.coordinate.longitude)
            let distance = String(currentSliderValue)
            
/*
/*
/* Since there are problems with FB API, we are using the below static values for latitude and longitude - just for testing purposes */
 */
 */
            let latitude = "42.123"
            let longitude = "21.123"
        
            //TODO:
            //distanca duhet te modifikohet kur shfrytezuesi e leshon slider-in
            
            let params = ["lat":latitude, "lng": longitude, "distance": distance, "accessToken": API_KEY]
            
            merrEventin(parameters: params)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventCell
        let event = events[indexPath.row]
        
        let eventImgURL = URL.init(string: event.profilePicture)
        
        if eventImgURL != nil {
            cell.eventImg.af_setImage(withURL: eventImgURL!)
        }
        cell.eventTitle.text = event.name
        cell.eventDate.text = event.date
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        self.performSegue(withIdentifier: "showDetail", sender: event)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailController = segue.destination as! DetailViewController
            detailController.selectedEvent = sender as? Event
        }
    }

//slider changed and updated the label
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        currentSliderValue = Int(sender.value)
        locationManager.startUpdatingLocation()
        updateScreen()
    }
    
    func updateScreen(){
        sliderValueLbl.text = "Distanca: \(currentSliderValue) metra"
    }
    
}

