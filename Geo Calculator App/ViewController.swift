//
//  ViewController.swift
//  Geo Calculator App
//
//  Created by Edric Lin on 5/17/18.
//  Created by Dimitri Haring on 5/17/18.
//
//  Copyright © 2018 GVSU. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, SettingsViewControllerDelegate {
    
    @IBOutlet weak var p1LatField: DecimalMinusTextField!
    @IBOutlet weak var p2LatField: DecimalMinusTextField!
    @IBOutlet weak var p1LongField: DecimalMinusTextField!
    @IBOutlet weak var p2LongField: DecimalMinusTextField!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    var distanceUnits: String = "Kilometers"
    var bearingUnits: String = "Degrees"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background color to BACKGORUND_COLOR
        self.view.backgroundColor = BACKGROUND_COLOR
        
        // dismiss keyboard when tapping outside oftext fields
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

/*    // protocol from settings view
    func applyDistanceUnitsSelection(distanceUnits: String) {
        self.distanceUnits = distanceUnits
        calculateButton.sendActions(for: .touchUpInside)
    }
    
    // protocol from settings view
    func applyBearingUnitsSelection(bearingUnits: String) {
        self.bearingUnits = bearingUnits
        calculateButton.sendActions(for: .touchUpInside)
    } */
    
    // protocol from settings view
    func settingsChanged(distanceUnits: String, bearingUnits: String) {
        self.distanceUnits = distanceUnits
        self.bearingUnits = bearingUnits
        calculateButton.sendActions(for: .touchUpInside)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let navVC = segue.destination as? UINavigationController {
            if let settingsVC = navVC.viewControllers.first as? SettingsViewController {
                settingsVC.delegate = self
                settingsVC.distanceUnits = self.distanceUnits
                settingsVC.bearingUnits = self.bearingUnits
            }
        }

    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        // dismiss keyboard when button pressed
        self.dismissKeyboard()
        
        // used to check for valid points
        var pointsOk: Bool = false
        
        // if optionals not nil
        if let p1Lat = self.p1LatField.text, let p1Long = self.p1LongField.text, let p2Lat = self.p2LatField.text, let p2Long = self.p2LongField.text {
            
            // if text fields not empty strings
            if p1Lat != "", p1Long != "", p2Lat != "", p2Long != "" {
                
                // all points valid
                pointsOk = true
            }
        }
        
        // if all points valid
        if pointsOk {
            
            // create CLLocation (points) from latitudes and longitudes
            let p1: CLLocation = CLLocation(latitude: Double(self.p1LatField.text!)!, longitude: Double(self.p1LongField.text!)!)
            let p2: CLLocation = CLLocation(latitude: Double(self.p2LatField.text!)!, longitude: Double(self.p2LongField.text!)!)
            
            // calculate distance between p1 and p2 in km. round to 2 decimal places
            var distance: Double = p1.distance(from: p2) / 1000
            distance = (distance * 100).rounded() / 100
            
            // convert distance to miles if distance units is miles
            if distanceUnits == "Miles" {
                distance = (distance * 0.621371 * 100).rounded() / 100
            }
            
            // set distance label
            self.distanceLabel.text = "Distance: \(distance) " + distanceUnits
            
            // calculate and set bearing between p1 and p2 in decimal degrees
            var bearing: Double = p1.bearingToPoint(point: p2)
            bearing = (bearing * 100).rounded() / 100
            
            // convert degrees to mils if bearing units is mils
            if bearingUnits == "Mils" {
                bearing = (bearing * 17.777777777778 * 100).rounded() / 100
            }
            
            // set bearing label
            self.bearingLabel.text = "Bearing: \(bearing) " + bearingUnits
            
        } else {
            self.distanceLabel.text = "Distance:"
            self.bearingLabel.text = "Bearing:"            
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        // dismiss keyboard when button pressed
        self.dismissKeyboard()
        
        p1LatField.text = ""
        p2LatField.text = ""
        p1LongField.text = ""
        p2LongField.text = ""
        
        distanceLabel.text = "Distance:"
        bearingLabel.text = "Bearing:"
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
    }
}

