//
//  CalcVC.swift
//  Calculator With Memory Functions
//
//  Created by Roman on 1/23/16.
//  Copyright © 2016 Roman Puzey. All rights reserved.
//

import UIKit

class CalcVC: UIViewController
{
    // reference -> % √ ÷ × − +

    @IBOutlet weak var display: UILabel!
    var displayValue: Double
    {
        get
        {
            return Double(display.text!)!
        }
        set
        {
            display.text = "\(newValue)"
        }
    }

    var userIsTypingNumber = false
    var numberOne : Double = 0
    var numberTwo : Double = 0
    var currentOperator = ""
    let defaults = NSUserDefaults.standardUserDefaults()
    var savedNumber : Double = 0
    var memoryType = ""
    var tax : Double = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func digitTapped(sender: UIButton)
    {
        let digit = sender.currentTitle

        if userIsTypingNumber == false
        {
            display.text = ""
            display.text = digit
            userIsTypingNumber = true
        }
        else if userIsTypingNumber == true
        {
            display.text = display.text! + digit!
        }
    }

    @IBAction func operatorTapped(sender: UIButton)
    {
        // reference -> % √ ÷ × − +

        userIsTypingNumber = false
        currentOperator = sender.currentTitle!

        if numberOne == 0 && numberTwo == 0
        {
            switch currentOperator
            {
                case "÷":
                currentOperator = "/"
                numberOne = displayValue
                case "×":
                currentOperator = "*"
                numberOne = displayValue
                case "−":
                currentOperator = "-"
                numberOne = displayValue
                case "+":
                currentOperator = "+"
                numberOne = displayValue
            default:
                break
            }
        }
        else if numberOne != 0 && numberTwo == 0
        {
            switch currentOperator
            {
            case "÷":
                currentOperator = "/"
                numberTwo = displayValue
                displayValue = numberOne / numberTwo
                numberOne = displayValue
                numberTwo = 0
            case "×":
                currentOperator = "*"
                numberTwo = displayValue
                displayValue = numberOne * numberTwo
                numberOne = displayValue
                numberTwo = 0
            case "−":
                currentOperator = "-"
                numberTwo = displayValue
                displayValue = numberOne - numberTwo
                numberOne = displayValue
                numberTwo = 0
            case "+":
                currentOperator = "+"
                numberTwo = displayValue
                displayValue = numberOne + numberTwo
                numberOne = displayValue
                numberTwo = 0
            default:
                break
            }
        }
    }

    @IBAction func sqrtTapped(sender: AnyObject)
    {
        displayValue = sqrt(displayValue)
    }

    @IBAction func perkTapped(sender: AnyObject)
    {
        numberTwo = displayValue

        if currentOperator == "+" || currentOperator == "-"
        {
            displayValue = (numberTwo / 100) * 1
        }
        else if currentOperator == "/" || currentOperator == "*"
        {
            displayValue = (numberTwo / 100)
        }
    }

    @IBAction func equalTapped(sender: AnyObject)
    {
        userIsTypingNumber = false
        numberTwo = displayValue

        if currentOperator == "/"
        {
            displayValue = numberOne / numberTwo
        }
        else if currentOperator == "*"
        {
            displayValue = numberOne * numberTwo
        }
        else if currentOperator == "-"
        {
            displayValue = numberOne - numberTwo
        }
        else if currentOperator == "+"
        {
            displayValue = numberOne + numberTwo
        }

        numberOne = displayValue
    }

    @IBAction func minus10perc(sender: AnyObject)
    {
        userIsTypingNumber = false
        displayValue = displayValue * (90/100)
    }

    @IBAction func plusTax(sender: AnyObject)
    {
        userIsTypingNumber = false

        tax = defaults.doubleForKey("taxrate")
        displayValue = (displayValue + (displayValue * (tax / 100)))
    }

    @IBAction func memoryTapped(sender: UIButton)
    {
        memoryType = sender.currentTitle!

        switch memoryType
        {
            case "M+":
                savedNumber = savedNumber + displayValue
                defaults.setDouble(savedNumber, forKey: "saved")
            case "M-":
                savedNumber = savedNumber - displayValue
                defaults.setDouble(savedNumber, forKey: "saved")
            case "MR":
                displayValue = defaults.doubleForKey("saved")
            case "MC":
                defaults.removeObjectForKey("saved")
                display.text = "0"
            case "CA":
                defaults.removeObjectForKey("saved")
                clearTapped(self)
        default:
            break
        }
    }

    @IBAction func clearTapped(sender: AnyObject)
    {
        currentOperator = ""
        numberOne = 0
        numberTwo = 0
        displayValue = 0
        display.text = "0"
        userIsTypingNumber = false
    }

}
