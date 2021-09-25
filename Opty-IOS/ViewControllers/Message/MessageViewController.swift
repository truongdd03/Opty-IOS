//
//  MessageViewController.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/29/21.
//

import UIKit

class MessageViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Message"
        print("Enter")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
        print("YEAH")
        cell.name = "Dinh Dong Truong"
        cell.text = "You: Hi! How are you?"
        cell.date = "Thu"
        return cell
    }

}
