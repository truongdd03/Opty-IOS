//
//  AddDegreeViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/30/21.
//

import UIKit

class AddDegreeViewController: PopUpViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var schoolInput: UITextField!
    @IBOutlet weak var DegreePicker: UIPickerView!
    @IBOutlet weak var majorInput: UITextField!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var StartDate: UIDatePicker!
    @IBOutlet weak var EndDate: UIDatePicker!
    
    let degreeTypes: [String] = ["Associate's Degree", "Bachelor's Degree", "Master's Degree", "Professional Degree", "Doctoral Degree"]
        
    override func viewDidLoad() {
        super.viewDidLoad()

        DegreePicker.delegate = self
        DegreePicker.dataSource = self

        setUp()
    }
    
    func setUp() {
        Utilities.styleFilledButton(AddButton)
        Utilities.styleHollowButton(CancelButton)
        Utilities.styleTextField(schoolInput)
        Utilities.styleTextField(majorInput)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func validateInputs() -> Bool {
        if (!schoolInput.hasText || !majorInput.hasText) {
            showError(message: "Please fill all fields")
            return false;
        }
        if (StartDate.date > EndDate.date) {
            showError(message: "End date is ealier than start date")
            return false;
        }
        return true;
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if (!validateInputs()) { return }
        let degree = degreeTypes[DegreePicker.selectedRow(inComponent: 0)] + " in " + majorInput.text!
        let startDate = Utilities.reformatDate(date: StartDate.date, format: "MM/yy")
        let endDate = Utilities.reformatDate(date: EndDate.date, format: "MM/yy")
        
        let tmp = Degree(school: schoolInput.text!, degree: degree, startDate: startDate, endDate: endDate)
        
        EducationViewController.degrees!.insert(tmp, at: 0)
        Writer.writeDegree(degree: tmp)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadDegree"), object: nil)
                
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return degreeTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    
        let label = (view as? UILabel) ?? UILabel()
        label.font = UIFont(name: "SanFranciscoText-Light", size: 17)
        label.textAlignment = .center
        label.text = degreeTypes[row]
        return label
    }

}
