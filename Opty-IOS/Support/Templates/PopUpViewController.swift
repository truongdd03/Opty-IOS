//
//  PopUpViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/31/21.
//

import UIKit

class PopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showError(message: String) {
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }

    func fetchTags() -> [String] {
        var tags = [String]()
        let file = "tags"
        if let textFile = Bundle.main.url(forResource: file, withExtension: "txt") {
            if let fileContents = try? String(contentsOf: textFile) {
                tags = fileContents.components(separatedBy: "\n")
            }
        }
        tags.removeLast()
        tags.sort()
        return tags
    }
    
    func addTagTo(array: [String], tag: String) -> [String] {
        var arr = array
        if (arr.count == 0) {
            arr.append(tag)
            return arr
        }
        
        for i in 0..<arr.count-1 {
            if (tag > arr[i] && tag < arr[i+1]) {
                arr.insert(tag, at: i+1)
                return arr
            }
        }
        arr.insert(tag, at: 0)
        return arr
    }
}
