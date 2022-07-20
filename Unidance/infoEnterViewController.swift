//
//  infoEnterViewController.swift
//  Unidance
//
//  Created by Daniel Basman on 3/26/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

var curr = ""
var loaded: Bool = false
class infoEnterViewController:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    @IBAction func removeKeyboard(_ sender: Any) {
        if (infoEnterViewController.keyboardDidShowNotification.rawValue == "UIKeyboardDidShowNotification") {
            print("SHOWN")
            view.endEditing(true)
        }
        
    }
    
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var foot: String = ""
    var inch: String = ""
    
    var height = ""
    var wing = ""
    
    var lastPerson = false
    var ref:DatabaseReference! = Database.database().reference()
   
    @IBAction func uploadInformation(_ sender: Any) {
        let sessionNumber = scanBarcodeViewController.sessionNumber
        let name = nameLabel.text ?? ""
        loadingView.isHidden = false
        loadingView.startAnimating()
        
        self.ref.child("sessions").observeSingleEvent(of: .value, with: { (snapshot) in
            for user in snapshot.children.allObjects as! [DataSnapshot] {
                let dict = user.value as? [String : AnyObject] ?? [:]
                //print(dict)
                //print(user)
                
                let userName: String = self.nameLabel.text!.prefix(1) + self.lastNameLabel.text!
                
                curr = userName
                if !user.childSnapshot(forPath: String(scanBarcodeViewController.sessionNumber)).exists() {
                    
                    if user.childSnapshot(forPath: curr).exists() {
                        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("height").setValue(self.heightLabel.text)
                        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("wing").setValue(self.wingspanLabel.text)
                        
                    } else {
                        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("firstName").setValue(self.nameLabel.text)
                        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("lastName").setValue(self.lastNameLabel.text)
                        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("height").setValue(self.heightLabel.text)
                        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("wing").setValue(self.wingspanLabel.text)

                    }
                } else {
                    print("FAILED HERE NUMBER ALREADY EXISTS")
                }
            }
//            SensorData.startButton.isUserInteractionEnabled = true
            
            loaded = true
            self.proceedButton.isHidden = false
            self.loadingView.isHidden = true
            if (self.lastPerson) {
                self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child("sessionFilled").setValue(curr)
            } else {
                print("Session filling up.....")
                //self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child("sessionFilled").setValue("0")
            }
            
            print("Completed Upload")
        }
        )
//        while (!loaded) {
//            print("WAITING")
//        }
        if (loaded) {
            print("LOADED")
        }
        
    }
    
   
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var wingspanLabel: UITextField!
    @IBOutlet weak var heightLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    
    @IBAction func lastPersonToggle(_ sender: Any) {
        if !lastPerson {
            lastPerson = true
            
        } else {
            lastPerson = false
//            self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child("sessionFilled").setValue(0)
        }
        
        
//        self.ref.child("users").child("dbasman").child("firstName").setValue("Daniel")
//        self.ref.child("users").child("dbasman").child("lastName").setValue("Basman")
//        self.ref.child("users").child("dbasman").child("height").setValue(heightLabel.text)
//        self.ref.child("users").child("dbasman").child("wing").setValue(wingspanLabel.text)

        
    }
    
    let picker = UIPickerView()
    let wingPick = UIPickerView()
    
    let data = [["3'","4'", "5'", "6'", "7'"], ["0''", "1''", "2''", "3''", "4''", "5''", "6''", "7''", "8''", "9''", "10''", "11''"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heightLabel.inputView = picker
        wingspanLabel.inputView = wingPick
        
        wingPick.delegate = self
        wingPick.dataSource = self
        
        picker.delegate = self
        picker.dataSource = self
        
        proceedButton.isHidden = true
        loadingView.isHidden = true
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data[component].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var ret = self.data[component][row]
        return ret
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        foot =  data[0][pickerView.selectedRow(inComponent: 0)]
        inch = data[1][pickerView.selectedRow(inComponent: 1)]
        if (pickerView.isEqual(picker)) {
            heightLabel.text = foot + " " + inch
            height = foot + "+" + inch
        } else {
            wingspanLabel.text = foot + " " + inch
            wing = foot + "+" + inch
        }
        
       

    }
    
    
    
    
}
