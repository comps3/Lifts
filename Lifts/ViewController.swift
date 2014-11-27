//
//  ViewController.swift
//  Lifts
//
//  Created by Brian Huynh on 8/12/14.
//  Copyright (c) 2014 Brian Huynh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var totalWeight: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    //@IBOutlet weak var weightSlider: UISlider!

    let weightList: [Double] = [1.25 ,2.5, 5, 10, 25, 35, 45]
    var barbellWeights = NSMutableArray()
    var plateTally = NSMutableArray()
    var poundsOrKilo: Bool = true
    var digitConverter = 0.0
    //var exerciseSwitch = 0
    //let dataSafe = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        totalWeight.textColor = UIColor.redColor()
        
        totalWeight.delegate = self
        tableView.rowHeight = 40
        
        // Removes table view lines
        tableView.separatorStyle = .None

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    func numberOfSections(tableView: UITableView!) -> Int
    {
        return 1
    }


    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return barbellWeights.count
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("barbellPlate") as BarbellPlate
        
        cell.plateCategory.text = "\(barbellWeights[indexPath.row])"
        cell.plateQty.text = "\(plateTally[indexPath.row])"
        
        cell.plateCategory.textColor = UIColor.redColor()
        cell.plateQty.textColor = UIColor.redColor()
        
        return cell
    }
    
    
    @IBAction func beginCalculate(sender:AnyObject)
    {
        let barbell = 45.0
        var barbellPlateSide: Double = 0.0

        var total_lift = Double((totalWeight.text as NSString).doubleValue)
        var running_total:Double = 0.0
        
        var temp_barbellWeight: Double = 0.0
        var temp_plateTally: Int = 0
        
        // Checks if the user's entered weight can be computed
        if total_lift % 1.25 != 0
        {
            var alert = UIAlertView(title: "Invalid Weight", message: "Please enter a weight divisble by 2.5", delegate: self, cancelButtonTitle:"Close")
            alert.show()
            return
        }
        
        // Total lift weight must be greater than 47.5 pounds due to avaliable weights
        if total_lift < 47.5
        {
            var alert = UIAlertView(title: "Invalid Weight", message: "Its impossible to lift less than the bar!", delegate: self, cancelButtonTitle:"Close")
            alert.show()
            return
            
        }
        
        barbellWeights.removeAllObjects()
        plateTally.removeAllObjects()
        totalWeight.resignFirstResponder()
        
        running_total = total_lift - barbell
        running_total /= 2
              
        while running_total != 0
        {
            for index in 0...weightList.count-1
            {
                
                // Checks if user's lift goal less than a larger plate
                if running_total < weightList[index]
                {
                    // Subtract the next smallest plate from the user's lift goal
                    running_total -= weightList[index-1]
                    
                    // Check if current barbell plate is still needed
                    if weightList[index-1] != temp_barbellWeight
                    {
                            // Initialize to one plate
                            temp_plateTally = 1
                        
                        // Add the plate to the array
                        barbellWeights.addObject(weightList[index-1])
                        
                        // If the user's lift goal goes to zero insert the plate tally
                        if running_total == 0
                        {
                            plateTally.addObject(temp_plateTally)
                            break
                        }
                        
                        // After substraction, if user's lift goal becomes less than current plate
                        // Insert the plate tally
                        if running_total < weightList[index-1]
                        {
                            plateTally.addObject(temp_plateTally)
                        }
                        
                        temp_barbellWeight = weightList[index-1]
                        
                    }
                    
                    // If the user's lift goal need the same plate
                    else
                    {
                        // Increment the plate count
                        temp_plateTally++
                        
                        // After substraction, if user's lift goal becomes less than current plate
                        // Insert the plate tally
                        if running_total < weightList[index-1]
                        {
                            plateTally.addObject(temp_plateTally)
                        }
                        
                        // If the running total goes to zero insert the plate tally
                        if running_total == 0
                        {
                            plateTally.addObject(temp_plateTally)
                            break
                        }
                        
                    }
                    
                    // Restart the search for the plate
                    break
                }
                 
                // Running total is greater than 45 pounds
                else if running_total >= weightList[index] && index == weightList.count-1
                {
                    running_total -= weightList[index]
                    
                    // Same plate is needed
                    if weightList[index] == temp_barbellWeight
                    {
                        temp_plateTally++
                        
                        // After substraction, if user's lift goal is less than current plate
                        // Insert the plate tally
                        if running_total < weightList[index]
                        {
                            plateTally.addObject(temp_plateTally)
                        }
                        
                    }
                    
                    // Check if current barbell plate is still needed
                    if weightList[index] != temp_barbellWeight
                    {
                        
                        temp_barbellWeight = weightList[index]
                        // Add to the plate list
                        barbellWeights.addObject(weightList[index])
                        
                        temp_plateTally = 1
                        
                        // Once running total has been reduced to a plate weight lower than 45 lbs
                        // Insert plate tally and enter the first if section
                        if running_total < weightList[index]
                        {
                            plateTally.addObject(temp_plateTally)
                        }
                    }
                    
                    // If the running total goes to zero insert the plate tally
                    if running_total == 0
                    {
                        plateTally.addObject(temp_plateTally)
                        break
                    }
                    
                    // Restart the search for the plate
                    break
                }
                
            }
            
        }
        
        reverseArrays()
        tableView.reloadData()
    }
    
    func reverseArrays()
    {
        var i = 0
        var j = barbellWeights.count - 1
        
        if barbellWeights.count == 0
        {
            return
        }
        
        while(i < j) {
            barbellWeights.exchangeObjectAtIndex(i, withObjectAtIndex: j)
            plateTally.exchangeObjectAtIndex(i, withObjectAtIndex: j)
            i++
            j--
        }
        
        
    }



}

