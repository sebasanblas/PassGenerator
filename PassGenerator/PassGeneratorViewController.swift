//
//  ViewController.swift
//  PassGenerator
//
//  Created by Sebastian San Blas on 20/06/2021.
//

import UIKit

class PassGeneratorViewController: UIViewController {

    // Switchs
    @IBOutlet var lowercaseSwitch: UISwitch!
    @IBOutlet var uppercaseSwitch: UISwitch!
    @IBOutlet var numberSwitch: UISwitch!
    @IBOutlet var punctuationSwitch: UISwitch!
    @IBOutlet var symbolsSwitch: UISwitch!
    // Slider
    @IBOutlet var lengthSlider: UISlider!
    @IBOutlet var lengthValueSlider: UILabel!
    
    // Buttons
    @IBAction func regenerateButton(_ sender: Any) {
        passwordLabel.text = generatePassword()
    }
    @IBAction func copyButton(_ sender: Any) {
        UIPasteboard.general.string = passwordLabel.text
        showCopyButton()
    }
    // Label
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var statusCopyButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lowercaseSwitch.isOn = true
        uppercaseSwitch.isOn = true
        numberSwitch.isOn = false
        punctuationSwitch.isOn = false
        symbolsSwitch.isOn = false
        
        lengthSlider.value = 16
        lengthValueSlider.text = String(Int(lengthSlider.value))
        
        passwordLabel.text = generatePassword()
        
        statusCopyButton.isHidden = true
    }
    
    @IBAction func lowercaseChanged(_ sender: Any) {
        passwordLabel.text = generatePassword()
    }
    @IBAction func uppercaseChanged(_ sender: Any) {
        passwordLabel.text = generatePassword()
    }
    @IBAction func numberChanged(_ sender: Any) {
        passwordLabel.text = generatePassword()
    }
    @IBAction func punctuationChanged(_ sender: Any) {
        passwordLabel.text = generatePassword()
    }
    @IBAction func symbolsChanged(_ sender: Any) {
        passwordLabel.text = generatePassword()
    }
    @IBAction func sliderChanged(_ sender: Any) {
        lengthValueSlider.text = String(Int(lengthSlider.value))
        passwordLabel.text = generatePassword()
    }

    func generatePassword() -> String {
        var password: String
        password = PasswordGenerator.sharedInstance.generatePassword(includeLower: lowercaseSwitch.isOn,
                                                                             includeUpper: uppercaseSwitch.isOn,
                                                                             includeNumbers: numberSwitch.isOn,
                                                                             includePunctuation: punctuationSwitch.isOn,
                                                                             includeSymbols: symbolsSwitch.isOn,
                                                                             length: Int(lengthSlider.value))
        if password.isEmpty == true {
            let alert = UIAlertController(title: "I can't allow it!", message: "You must select at least one option!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK, I got it", style: .default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
        return password
    }
    
    func showCopyButton() {
        statusCopyButton.isHidden = false
        UIView.animate(withDuration: 1, delay: 0.25, options: UIView.AnimationOptions.transitionFlipFromTop, animations: {
            self.statusCopyButton.alpha = 0
        }, completion: { finished in
            self.statusCopyButton.isHidden = true
            self.statusCopyButton.alpha = 1
        })
    }
}

