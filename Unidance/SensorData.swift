//
//  SensorData.swift
//  Unidance
//
//  Created by Daniel Basman on 3/22/22.
//

import Foundation
import UIKit
import CoreMotion
import Firebase
import FirebaseDatabase

var leaderName = ""

class SensorData:UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBAction func senseData(_ sender: Any) {
        curSense?.toggle()
        print(curSense?.description ?? "Couldn't get")
        if (curSense!) {
            startButton.setTitle("Stop", for: .normal)
            startButton.titleLabel?.font = UIFont.init(name: "Futura", size: 39.0)
            startButton.setNeedsDisplay()
            startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        } else {
            
            startButton.setTitle("Start", for: .normal)
            startButton.titleLabel?.font = UIFont.init(name: "Futura", size: 39.0)
            startButton.setNeedsDisplay()
            startButton.titleLabel?.adjustsFontSizeToFitWidth = true
            
            let leader = self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child("sessionFilled")
            
            
            leader.observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot.value)
                if (snapshot.value as! String == curr) {
                    self.ref.child("sessions_awaiting_results").child(String(scanBarcodeViewController.sessionNumber)).setValue(scanBarcodeViewController.sessionNumber)
                    leaderName = snapshot.value as! String
                    print("ADDED SUCCESFULLY")
                    print(leaderName)
                } else {
                    print("SIMPLE MEMBER, NO TESTING SUBMISSION PERMISSIONS")
                    leaderName = snapshot.value as! String
                    print(leaderName)
                    print("VS")
                    print(curr)
                }
                    
            }) { (err) in
                        print("Failed to fetch following listings:", err)
            }
        }

        motionManager()
      
    }

    @IBAction func nextPage(_ sender: Any) {
        curSense?.toggle()
        print(curSense?.description ?? "false")
        motionManager()
        //var val = self.ref.child("sessions_awaiting_results").child(String(scanBarcodeViewController.sessionNumber))
       
        print("--------")
        
        
        
//        if (val.database.reference().child(scanBarcodeViewController.sessionNumber) == nil) {
            
            
//        } else {
//            print(val)
//            print("COULD NOT ADD TO AWAITING TESTING SESSIONS")
//        }
        
//        self.ref.child("users").child("dbasman").setValue(["firstName": "Danny"])]
        
        
    }
    @IBAction func unwind(_ sender: Any) {
        print("pressed")
//        performSegue(withIdentifier: "unwindToInfo", sender: self)
    }
    
    @IBOutlet weak var backButton: UIButton!
    
    let motion = CMMotionManager()
    var curSense : Bool? = false
    static var vals: [[Double]] = [[]]
    static var gyroVals: [[Double]] = [[]]
    
    var ref:DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 50
//        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = UIFont.init(name: "Futura-Medium", size: 48.0)
        
        startButton.setNeedsDisplay()
        
        //var tempCheck = checkBool()
        
        
       
//        startButton.isUserInteractionEnabled = false
//        startAccelerometers()
        //motionManager()
        // Do any additional setup after loading the view.
        
    }
    
//    func checkBool() {
//
//
//        var valLoaded:Bool = true {
//            didSet { //called when item changes
//                print("changed")
//            }
//            willSet {
//                print("about to change")
//                print(loaded)
//            }
//        }
//        while (!loaded) {
//            print("waiting")
//            if (loaded) {
//                startRecLabel.isHidden = false
//                loadingAnim.isHidden = true
//            }
//        }
//    }
    
    func motionManager() {
        var accelerometerData:CMAccelerometerData?
        var gyroData:CMGyroData?
        var accelCount: Int = 0
        var gyroCount: Int = 0
        
        let xArr: [Double] = []
        let yArr: [Double] = []
        let zArr: [Double] = []
        var time: Array<Double> = Array(repeating: 0, count: 4)
        SensorData.vals.append(xArr)
        SensorData.vals.append(yArr)
        SensorData.vals.append(zArr)
        SensorData.vals.append(time)
        
        let xGy: [Double] = []
        let yGy: [Double] = []
        let zGy: [Double] = []
        SensorData.gyroVals.append(xGy)
        SensorData.gyroVals.append(yGy)
        SensorData.gyroVals.append(zGy)
        SensorData.gyroVals.append(time)
        
        
        
        if self.curSense! {
            
//            if self.curSense! {
                if motion.isAccelerometerAvailable {
                    motion.accelerometerUpdateInterval = 1/100  //1/100 for 100 times a second
                    motion.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
        //                print(data)
                        if !self.curSense! {
                            return
                        }
                        let timeInterval = NSDate().timeIntervalSince1970
                        
//                        let date = Date()
//                        let cal = Calendar.current
//                        let hour = Double(cal.component(.hour, from: date))
//                        let min = Double(cal.component(.minute, from: date))
//                        let sec = Double(cal.component(.second, from: date))
//                        let nano = Double(cal.component(.nanosecond, from: date))
//                        time[0] = hour
//                        time[1] = min
//                        time[2] = sec
//                        time[3] = nano
//
                        
                        
                        
                        accelerometerData = data
                        accelCount += 1
                        
                       
                        
                        
                        
                      //  print("ACCELEROMETER DATA: ")
                        let xSpeed = (accelerometerData?.acceleration.x ?? 0) * 9.80665
                        let ySpeed = (accelerometerData?.acceleration.y ?? 0) * 9.80665
                        let zSpeed = (accelerometerData?.acceleration.z ?? 0) * 9.80665
                        
                      //  var directionString = self.calcDirection(x: xSpeed, y: ySpeed, z: zSpeed)
                       // xArr.append(xSpeed)
                        SensorData.vals[0].append(xSpeed)
                       // yArr.append(ySpeed)
                        SensorData.vals[1].append(ySpeed)
                        //zArr.append(zSpeed)
                        SensorData.vals[2].append(zSpeed)
                        SensorData.vals[3].append(timeInterval)
//                        print(xArr)
//                        print(yArr)
//                        print(zArr)
                        
                       // print("======")
                        //print(directionString)
                        
                    }
                }
            
                if motion.isGyroAvailable {
                    motion.gyroUpdateInterval = 1/100
                    motion.startGyroUpdates(to: OperationQueue.main) {(data, error) in
                        
                        if !self.curSense! {
                            return
                        }
                        
                        let timeInterval = NSDate().timeIntervalSince1970
                        
                        gyroData = data
                        gyroCount += 1
                        
                        
                        
//                        print("GYRO DATA: ")
                        let x = gyroData?.rotationRate.x
                        let y = gyroData?.rotationRate.y
                        let z = gyroData?.rotationRate.z
                        
                        SensorData.gyroVals[0].append(x!)
                        SensorData.gyroVals[1].append(y!)
                        SensorData.gyroVals[2].append(z!)
                        SensorData.gyroVals[3].append(timeInterval)
                        
                       
        //                print("-------" + String(gyroCount) + "-------")
                    }
                }
        }
//        SensorData.vals.append(xArr)
//        SensorData.vals.append(yArr)
//        SensorData.vals.append(zArr)
//        print("X: ")
//        print(SensorData.vals[0])
//        print(" Y: ")
//        print(SensorData.vals[1])
//        print(" Z: ")
//        print(SensorData.vals[2])
//
//        print(gyroData?.rotationRate.x)
        
        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("data").child("accelerometer").child("x").setValue(SensorData.vals[0])
        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("data").child("accelerometer").child("y").setValue(SensorData.vals[1])
        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("data").child("accelerometer").child("z").setValue(SensorData.vals[2])
        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("data").child("accelerometer").child("time").setValue(SensorData.vals[3])
        
        
        
        
        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("data").child("gyro").child("x").setValue(SensorData.gyroVals[0])
        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("data").child("gyro").child("y").setValue(SensorData.gyroVals[1])
        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("data").child("gyro").child("z").setValue(SensorData.gyroVals[2])
        self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(curr).child("data").child("gyro").child("time").setValue(SensorData.vals[3])
//        }
        
        
        
        
    }

    
//    func startAccelerometers() {
//       // Make sure the accelerometer hardware is available.
//       if self.motion.isAccelerometerAvailable {
//          self.motion.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
//          self.motion.startAccelerometerUpdates()
//
//          // Configure a timer to fetch the data.
//           var timer = Timer(fire: Date(), interval: (1.0/60.0),
//                repeats: true, block: { (timer) in
//             // Get the accelerometer data.
//             if let data = self.motion.accelerometerData {
//                let x = data.acceleration.x
//                let y = data.acceleration.y
//                let z = data.acceleration.z
//                print("X: " + String(x) + " Y: " + String(y) + " Z: " + String(z))
//                // Use the accelerometer data in your app.
//             }
//          })
//
//          // Add the timer to the current run loop.
//           RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
//       }
//    }
}
