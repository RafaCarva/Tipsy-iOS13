//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    /*
     Se essas vars não tiverem algum valor inicial, por ex:
     var finalMessage: String
     Vai dar um erro pois a classe vai exigir um Init()
     */
    
    var finalBillValue = 0.0
    var billValue = 0.0
    var finalMessage = ""
    var tipPercentage = 0.10
    var numberOfPeople = 2
    
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        setPctButtonDeselect()
        
        switch sender.titleLabel?.text {
        case "0%":
            zeroPctButton.isSelected = true
            tipPercentage = 0
        case "10%":
            tenPctButton.isSelected = true
            tipPercentage = 0.10
        case "20%":
            twentyPctButton.isSelected = true
            tipPercentage = 0.20
        default:
            print("Algum erro!")
        }
    }
    
    func setPctButtonDeselect(){
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        //Guarda o total de pessoas para fazer a conta depois
        numberOfPeople = Int(sender.value)
        print(sender.value)
        
        //Atualiza o valor do stepper na tela
        splitNumberLabel.text = String(numberOfPeople)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text! //O UILabel suporta uma string
        
        if (bill != ""){
            billValue = Double(bill)!
            finalBillValue = (billValue + (billValue * tipPercentage)) / Double(numberOfPeople)
            
            finalMessage = "Split between \(numberOfPeople) people, with \(tipPercentage * 100)% tip."
        }
        
        //Chama a próxima tela depois de executar a func prepare
        self.performSegue(withIdentifier: "goToResults", sender: self)

    }
    
    //Popula o ResultsViewController antes de acontecer a performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "goToResults"){
           
            let destinationVC = segue.destination as! ResultsViewController
            //seta o valor da conta
            destinationVC.total = String(finalBillValue)
            destinationVC.settings = finalMessage
            
        }
    }
    
    
    /*
     totalLabel: UILabel!
     @IBOutlet weak var settingsLabel: UILabel!
     
     */
    
}

