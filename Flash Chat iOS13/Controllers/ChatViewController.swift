//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let chatHistory: [Messages] = [Messages(sender: "sajjad.xotech.com@gmail.com", body: "Hey fjgf dffsjddsdsdf f f df gsdkd f sdkfg dsgf gdfgd gd dsf s kf kkdfj    f df df gkdgfdgf dgf dgf dsfg d dsfg d fsdf f ddsfhgdds f") , Messages(sender: "arman.xotech.com@gmail.com", body: "Hello!!"), Messages(sender: "sajjad.xotech.com@gmail.com", body: "What's up ?")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        // tableView.delegate = self
        
        title = "⚡️FlashChat"
        navigationItem.hidesBackButton = true 
        
        tableView.register( UINib(nibName: K.cellNibName , bundle: nil ), forCellReuseIdentifier: K.cellIdentifier )
    

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}


extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier , for: indexPath ) as! MessageCell
        
        
        cell.messageLabel.text = chatHistory[indexPath.row].body
        
        return cell
    }
    
    
}

//extension ChatViewController : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//}
