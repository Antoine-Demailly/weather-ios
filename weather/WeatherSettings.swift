//
//  WeatherSettings.swift
//  weather
//
//  Created by Antoine Demailly on 22/11/2016.
//  Copyright © 2016 SUPInternet_2017. All rights reserved.
//

import Foundation
import UIKit

class WeatherSettings: UIViewController {
    var isUpdate: Bool = false

    var geoLocationSwitchInitial: Bool = false
    @IBOutlet weak var tableView: WeatherSettingsTableView!
    var cityTextFieldInitial: String = ""
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var geoLocationSwitch: UISwitch!

    // action on savebutton
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        if isUpdate {
            if !geoLocationSwitch.isOn && (cityTextField.text?.characters.count)! <= 0 {
                self.invalidSettings()
            }
        }
    }
    
    // action on geolocation switch
    @IBAction func geoLocationChanged(_ sender: UISwitch) {
        self.activeSaveButton()

        if geoLocationSwitch.isOn {
            UIView.animate(withDuration: 0.3, animations: {
                self.cityTextField.backgroundColor = UIColor.lightGray
            })
    
            cityTextField.isEnabled = false
            cityTextField.text = ""
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.cityTextField.backgroundColor = UIColor.white
            })

            cityTextField.isEnabled = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isUpdate = false
        
        let colors = GradientColors()
        self.view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer.frame = self.view.frame
        self.view.layer.insertSublayer(backgroundLayer, at: 0)
        
        self.saveButton.tintColor = UIColor.clear
        
        self.cityTextFieldInitial = self.cityTextField.text ?? ""

        if geoLocationSwitch.isOn {
            self.geoLocationSwitchInitial = true
            self.cityTextField.backgroundColor = UIColor.lightGray
            cityTextField.isEnabled = false
        }
    }
    
    func activeSaveButton() {
        if self.isUpdate == false {
            self.isUpdate = true
            UIView.animate(withDuration: 0.3, animations: {
                self.saveButton.tintColor = UIColor.white
            })
        }
    }
    
    func invalidSettings() {
        let alertController = UIAlertController(title: "Mauvais paramètres", message: "Merci d'activer la géolocalisation ou d'entrer un nom de ville correct", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("OK")
        }
 
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension WeatherSettings: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.geoLocationSwitch.setOn(false, animated: true)
        self.cityTextField.isEnabled = true
        self.cityTextField.text = "Paris"

        UIView.animate(withDuration: 0.3, animations: {
            self.cityTextField.backgroundColor = UIColor.white
        })
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? WeatherSettingsCell {
            if indexPath.row == 0 {
                cell.historyLabel.text = "Paris"
            }
            
            if indexPath.row == 1 {
                cell.historyLabel.text = "Clermont"
            }
        }
    }
}

extension WeatherSettings: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36.0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: WeatherSettingsCell.identifier, for: indexPath)
    }
}


