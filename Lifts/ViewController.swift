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

    let weightList: [Double] = [2.5, 5, 10, 25, 35, 45]
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
        
        // Declaration for adding a done button to keyboard
        var numberPadDoneButton = NumberPadDoneBtn(frame: CGRectMake(0, 0, 1, 1))
        self.totalWeight.inputAccessoryView = numberPadDoneButton
        
        totalWeight.delegate = self
        
        /*
        if exerciseSwitch == 0 {
            if dataSafe.doubleForKey("benchTotal") != 0.000000
            {
                totalWeight.text = String(format:"%f", dataSafe.doubleForKey("benchTotal"))
            }
        }
            
        else if exerciseSwitch == 1 {
            
            if dataSafe.doubleForKey("deadTotal") != 0.000000
            {
                totalWeight.text = String(format:"%f", dataSafe.doubleForKey("deadTotal"))
            }
        }
        else if exerciseSwitch == 2 {
            
            if dataSafe.doubleForKey("swatTotal") != 0.000000
            {
                totalWeight.text = String(format:"%f", dataSafe.doubleForKey("swatTotal"))
            }
        }
        else if exerciseSwitch == 3 {
         
            
            if dataSafe.doubleForKey("overheadTotal") != 0.000000
            {
                totalWeight.text = String(format:"%f", dataSafe.doubleForKey("overheadTotal"))
            }
        }
        else if exerciseSwitch == 4 {
            
            if dataSafe.doubleForKey("rowsTotal") != 0.000000
            {
                totalWeight.text = String(format:"%f", dataSafe.doubleForKey("rowsTotal"))
            }
        }
       */
        
        tableView.rowHeight = 40
        // Removes table view lines
        tableView.separatorStyle = .None
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    Future: Save a person's weight lifting data
    
    @IBAction func indexChange(sender: AnyObject)
    {
        switch segmentedControl.selectedSegmentIndex
        {
            case 0:
                    exerciseSwitch = 0
                    tableView.reloadData()
            
            case 1:
                    exerciseSwitch = 1
                    tableView.reloadData()
            
            case 2:
                    exerciseSwitch = 2
                    tableView.reloadData();
            
            case 3:
                    exerciseSwitch = 3
                    tableView.reloadData();
            
            case 4:
                    exerciseSwitch = 4
                    tableView.reloadData();
            
            default: print("What backup plans!")
            
        }
        
    }
    */

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
        
        /*
        var tempArray: NSArray = []
        var temp2Array:NSArray = []
        
      
        if exerciseSwitch == 0 {
            if dataSafe.arrayForKey("benchTally") != nil && dataSafe.arrayForKey("benchWeights") != nil
            {
                tempArray = dataSafe.arrayForKey("benchTally")!
                temp2Array = dataSafe.arrayForKey("benchWeights")!
            }
        }
            
        else if exerciseSwitch == 1 {
            
            if dataSafe.arrayForKey("deadTally") != nil && dataSafe.arrayForKey("deadWeights") != nil
            {
                tempArray = dataSafe.arrayForKey("deadTally")!
                temp2Array = dataSafe.arrayForKey("deadWeights")!
                
            }
            
        }
        else if exerciseSwitch == 2 {
            
            if dataSafe.arrayForKey("swatTally") != nil && dataSafe.arrayForKey("swatWeights") != nil
            {
                tempArray = dataSafe.arrayForKey("swatTally")!
                temp2Array = dataSafe.arrayForKey("swatWeights")!
                
            }
        }
        else if exerciseSwitch == 3 {
            
            if dataSafe.arrayForKey("overheadTally") != nil && dataSafe.arrayForKey("overheadWeights") != nil
            {
                tempArray = dataSafe.arrayForKey("overheadTally")!
                temp2Array = dataSafe.arrayForKey("overheadWeights")!
                
            }
        }
        else if exerciseSwitch == 4 {
            
            if dataSafe.arrayForKey("rowsTally") != nil && dataSafe.arrayForKey("rowsWeights") != nil
            {
                tempArray = dataSafe.arrayForKey("rowsTally")!
                temp2Array = dataSafe.arrayForKey("rowsWeights")!
            }
        }
        */
        
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
        
        // Can't find keyplane that supports type 4 for keyboard iPhone-Portrait-NumberPad; using 3876877096_Portrait_iPhone-Simple-Pad_Default
    

        var total_lift = Double((totalWeight.text as NSString).doubleValue)
        var running_total:Double = 0.0
        
        var temp_barbellWeight: Double = 0.0
        var temp_plateTally: Int = 0
        
        // Checks for weight limits that can not be computed
        if total_lift % 2.5 != 0
        {
            var alert = UIAlertView(title: "Invalid Weight", message: "Please enter a weight divisble by 2.5", delegate: self, cancelButtonTitle:"Close")
            alert.show()
            return
        }
        
        // Need to lift at least 50 pounds
        if total_lift < 50
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
        
        /*
        if exerciseSwitch == 0 {
            dataSafe.setDouble(total_lift, forKey: "benchTotal")
            dataSafe.synchronize()
        }
        
        else if exerciseSwitch == 1 {
            dataSafe.setDouble(total_lift, forKey: "deadTotal")
            dataSafe.synchronize()
        }
        else if exerciseSwitch == 2 {
            dataSafe.setDouble(total_lift, forKey: "swatTotal")
            dataSafe.synchronize()
        }
        else if exerciseSwitch == 3 {
            dataSafe.setDouble(total_lift, forKey: "overheadTotal")
            dataSafe.synchronize()
        }
        else if exerciseSwitch == 4 {
            dataSafe.setDouble(total_lift, forKey: "rowsTotal")
            dataSafe.synchronize()
        }
        */
        
        while running_total != 0
        {
            for index in 0...5
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
                else if running_total >= weightList[index] && index == 5
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
        
        /*
        if exerciseSwitch == 0 {
            dataSafe.setObject(plateTally, forKey: "benchTally")
            dataSafe.setObject(weightList, forKey: "benchWeights")
            dataSafe.synchronize()
        }
            
        else if exerciseSwitch == 1 {
            dataSafe.setObject(plateTally, forKey: "deadTally")
            dataSafe.setObject(weightList, forKey: "deadWeights")
            dataSafe.synchronize()
        }
        else if exerciseSwitch == 2 {
            dataSafe.setObject(plateTally, forKey: "swatTally")
            dataSafe.setObject(weightList, forKey: "swatWeights")
            dataSafe.synchronize()
        }
        else if exerciseSwitch == 3 {
            dataSafe.setObject(plateTally, forKey: "overheadTally")
            dataSafe.setObject(weightList, forKey: "overheadWeights")
            dataSafe.synchronize()
        }
        else if exerciseSwitch == 4 {
            dataSafe.setObject(plateTally, forKey: "rowsTally")
            dataSafe.setObject(weightList, forKey: "rowsWeights")
            dataSafe.synchronize()
        }
        */
        
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

