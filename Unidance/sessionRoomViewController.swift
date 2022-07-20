//
//  sessionRoomViewController.swift
//  Unidance
//
//  Created by Daniel Basman on 3/26/22.
//

import Foundation
import UIKit
import Charts
import Firebase
import FirebaseDatabase

class sessionRoomViewController:UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    let goals = [1.0, 10.0, 26.0, 39.0, 55.0, 76.0, 89.0, 100.0]
    let funcRes = SensorData.vals
    @IBOutlet weak var lineChart: LineChartView!
    var leaderUser: Bool = false
    var ref:DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //print(funcRes)
        
        var vari: [NSNumber] = []
        
        var leader = leaderName
        print(leader)
        getLeaderVal(lead: leader)
//        print(dub)
        
        
        
        //print(self.ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child("results").child("bchrrrr").value(forKey: "bchrrrr") as! String)
        //makeChart(dataPoints: funcRes[0], values: funcRes[0])
        
    }

    func getLeaderVal (lead: String) {
        
        ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child("results").child(curr).getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            print("Error Occured")
            return;
          }
            //print(snapshot.value)
//            if (snapshot.value is Int) {
            self.scoreLabel.text =  String(describing: snapshot.value as! NSNumber)
            
//            }
//                else {
//                //self.leaderUser = true
//                let str = String(snapshot.value as? String ?? "Leader")
//                self.scoreLabel.text = str
//            }
            
//            print(str)
            self.scoreLabel.sizeToFit()
            print("Made it through")
        });
        
        
        var dub: [Double] = []
        ref.child("sessions").child(String(scanBarcodeViewController.sessionNumber)).child(lead).child("data").child("accelerometer").child("x").getData(completion: { error, snapshot in
                guard error == nil else {
                    print("FAILED HERE WHEN RETRIEVING LEADER DATA")
                    return;
                }
            //print(snapshot.value)
            print("=========")
            let dict: [NSNumber] = ((snapshot.value as! [NSArray]) as! [NSNumber])
//
            for i in stride(from: 1, through: dict.count - 1, by: 1){
                //print(dict[i])
                dub.append(dict[i].doubleValue)
            }

//          ;p print(dub)
           self.makeChart(dataPoints: dub, secondPoint: self.funcRes[0], values: dub)
        });
        //return dub
        
    }
                                                                                    
    func makeChart(dataPoints: [Double], secondPoint: [Double], values: [Double]) {
        var dataEntriesFirst: [ChartDataEntry] = []
        var dataEntriesSecond: [ChartDataEntry] = []
        let data = LineChartData()
        print(leaderUser)
        if (!leaderUser) {
            print("NO LEADER IN GROUP")
            for i in stride(from: 1, through: values.count - 1, by: 4) {
                let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
               dataEntriesFirst.append(dataEntry)
            }
            
            let lineChartDataSet = LineChartDataSet(entries: dataEntriesFirst, label: "Leader Data")
            lineChartDataSet.setCircleColor(UIColor.blue)
            lineChartDataSet.colors = [UIColor.blue]
            lineChartDataSet.circleHoleRadius = 0
            lineChartDataSet.circleRadius = 3
            data.addDataSet(lineChartDataSet)
        }
        
        for i in stride(from: 1, through: secondPoint.count - 1, by: 4) {
            let dataEntry = ChartDataEntry(x: Double(i), y: secondPoint[i])
          dataEntriesSecond.append(dataEntry)
        }
        
        let lineData = LineChartDataSet(entries: dataEntriesSecond, label: "Your Data")
        lineData.setCircleColor(UIColor.red)
        lineData.colors = [UIColor.red]
        lineData.circleHoleRadius = 0
        lineData.circleRadius = 3
        
        data.addDataSet(lineData)
        lineChart.chartDescription?.text = "This is a chart showing one's acceleration over time"
        
        
        
//        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChart.data = data
    }
    
    
    
}
