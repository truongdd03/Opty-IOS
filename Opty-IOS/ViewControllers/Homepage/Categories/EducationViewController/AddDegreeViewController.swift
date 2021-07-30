//
//  AddDegreeViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/30/21.
//

import UIKit

class AddDegreeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

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

        Utilities.styleFilledButton(AddButton)
        Utilities.styleHollowButton(CancelButton)
        Utilities.styleTextField(schoolInput)
        Utilities.styleTextField(majorInput)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
    }
    
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
