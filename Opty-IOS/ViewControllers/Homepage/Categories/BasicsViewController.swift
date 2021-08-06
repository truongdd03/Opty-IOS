//
//  BasicsViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/30/21.
//

import UIKit
import Firebase

class BasicsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var AddressTextField: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var StateTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    
    @IBOutlet weak var CountryInput: UITextField!
    @IBOutlet weak var NationInput: UITextField!
    
    var countryPickerView = UIPickerView()
    var nationPickerView = UIPickerView()
    
    var countries: [String] = []
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    
    static var basicInfo: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = "Basics"
        setUp()
        
        CountryInput.inputView = countryPickerView
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        CountryInput.delegate = self
        
        NationInput.inputView = nationPickerView
        nationPickerView.delegate = self
        nationPickerView.dataSource = self
        NationInput.delegate = self

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let birth = DatePicker.date
        
        BasicsViewController.basicInfo = Info(name: nameTextField.text, birth: birth, nation: NationInput.text, address: AddressTextField.text!, city: CityTextField.text, state: StateTextField.text, country: CountryInput.text, phone: PhoneTextField.text)
        
        BasicsViewController.basicInfo!.uploadData()
    }
    
    func setUp() {    
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(AddressTextField)
        Utilities.styleTextField(CityTextField)
        Utilities.styleTextField(StateTextField)
        Utilities.styleTextField(PhoneTextField)
        Utilities.styleSimpleTextField(textField: CountryInput)
        Utilities.styleSimpleTextField(textField: NationInput)
        
        showFields()
        fetchCountries()

    }
    
    func showFields() {
        let info = BasicsViewController.basicInfo!
        nameTextField.text = info.name
        PhoneTextField.text = info.phone
        DatePicker.date = info.birth
        AddressTextField.text = info.address
        CityTextField.text = info.city
        StateTextField.text = info.state
        CountryInput.text = info.country
        NationInput.text = info.nation
    }
    
    func fetchCountries() {
        let file = "countries"
        if let textFile = Bundle.main.url(forResource: file, withExtension: "txt") {
            if let fileContents = try? String(contentsOf: textFile) {
                countries = fileContents.components(separatedBy: "\n")
            }
        }
    }
    
}

extension BasicsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == countryPickerView) {
            CountryInput.text = countries[row]
        } else {
            NationInput.text = countries[row]
        }
    }
}
