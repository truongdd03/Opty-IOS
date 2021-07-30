//
//  BasicsViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/30/21.
//

import UIKit

class BasicsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var AddressTextField: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var StateTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var GithubTextField: UITextField!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    
    @IBOutlet weak var NationLabel: UILabel!
    @IBOutlet weak var CountryLabel: UILabel!
    @IBOutlet weak var PickerViewButton: UIButton!
    
    var countries: [String] = ["Vietnam", "USA", "UK", "South Korea"]
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCountries()
        
        title = "Basics"
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(AddressTextField)
        Utilities.styleTextField(CityTextField)
        Utilities.styleTextField(StateTextField)
        Utilities.styleTextField(PhoneTextField)
        Utilities.styleTextField(GithubTextField)
        Utilities.styleFilledButton(SaveButton)
        Utilities.styleHollowButton(CancelButton)
    }
    
    func fetchCountries() {
        let file = "countries"
        if let textFile = Bundle.main.url(forResource: file, withExtension: "txt") {
            if let fileContents = try? String(contentsOf: textFile) {
                //countries = split(fileContents) { $0 == "\n" }
                countries = fileContents.components(separatedBy: "\n")
            }
        }
    }
    
    @IBAction func ChooseNationButtonTapped(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select country", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = PickerViewButton
        alert.popoverPresentationController?.sourceRect = PickerViewButton.bounds

        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            let button = sender as! UIButton
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            if (button.tag == 0) {
                self.NationLabel.text = self.countries[self.selectedRow]
            } else {
                self.CountryLabel.text = self.countries[self.selectedRow]
            }

        }))
        
        self.present(alert, animated: true)

    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = Array(countries)[row]
        label.sizeToFit()
        return label
    }
    
}
