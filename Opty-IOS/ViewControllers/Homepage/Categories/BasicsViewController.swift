//
//  BasicsViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/30/21.
//

import UIKit

class BasicsViewController: MyViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var AddressTextField: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var StateTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    @IBOutlet weak var SaveButton: UIButton!
    
    @IBOutlet weak var NationLabel: UILabel!
    @IBOutlet weak var CountryLabel: UILabel!
    @IBOutlet weak var PickerViewButton: UIButton!
    
    var countries: [String] = []
    let screenWidth = UIScreen.main.bounds.width - 10
    let screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    
    static var basicInfo = Info(name: "", birth: Date(), nation: "", address: "", city: "", state: "", country: "", phone: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCountries()
        
        title = "Basics"
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(AddressTextField)
        Utilities.styleTextField(CityTextField)
        Utilities.styleTextField(StateTextField)
        Utilities.styleTextField(PhoneTextField)
        Utilities.styleFilledButton(SaveButton)
        
        showFields()
    }
    
    func showFields() {
        let info = BasicsViewController.basicInfo
        nameTextField.text = info.name
        PhoneTextField.text = info.phone
        DatePicker.date = info.birth
        AddressTextField.text = info.address
        CityTextField.text = info.city
        StateTextField.text = info.state
        CountryLabel.text = info.country
        NationLabel.text = info.nation
    }
    
    func fetchCountries() {
        let file = "countries"
        if let textFile = Bundle.main.url(forResource: file, withExtension: "txt") {
            if let fileContents = try? String(contentsOf: textFile) {
                countries = fileContents.components(separatedBy: "\n")
            }
        }
    }
    
    func alert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
        }))
        present(ac, animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let birth = DatePicker.date
        
        BasicsViewController.basicInfo = Info(name: nameTextField.text, birth: birth, nation: NationLabel.text, address: AddressTextField.text!, city: CityTextField.text, state: StateTextField.text, country: CountryLabel.text, phone: PhoneTextField.text)
        
        alert(title: "Saved", message: "")
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
