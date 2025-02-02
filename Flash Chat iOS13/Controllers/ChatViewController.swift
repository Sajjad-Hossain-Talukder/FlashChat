//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var db = Firestore.firestore()
    var chatHistory: [Messages] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "⚡️FlashChat"
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        // tableView.delegate = self
        tableView.register( UINib(nibName: K.cellNibName , bundle: nil ), forCellReuseIdentifier: K.cellIdentifier )
        
        loadMessages();
        
    }
    
    func loadMessages() {
        
        /*
         db.collection(K.FStore.collectionName).getDocuments() { (querySnapshot, err) in
         getDocumnets is used for reading Documents from fireStore but it doesn't response to update.
         */
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField)
            .addSnapshotListener() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    
                    self.chatHistory = []
                    
                    if let snapDocs =  querySnapshot?.documents {
                        
                        for docs in snapDocs {
                            //print(docs.documentID)
                            let data = docs.data()
                            if let sender = data[K.FStore.senderField] as? String ,  let body = data[K.FStore.bodyField] as? String {
                                self.chatHistory.append(Messages(sender: sender, body: body))
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let index = IndexPath(row: self.chatHistory.count - 1 , section: 0 )
                                    self.tableView.scrollToRow(at: index , at: .top , animated: true )
                                }
                            
                            }
                        }
                        
                        
                    }
                    
                    
                }
            }
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        
        if let messageBody = messageTextfield.text , let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField : messageBody,
                K.FStore.dateField : Date().timeIntervalSince1970
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
            
            
        }
        
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
        
        if chatHistory[indexPath.row].sender == Auth.auth().currentUser?.email {
            
            cell.leftMessageAvatar.isHidden = false
            cell.rightMessageAvatar.isHidden = true
            cell.messageView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named:  K.BrandColors.purple )
            
            
        } else {
            
            cell.leftMessageAvatar.isHidden = true
            cell.rightMessageAvatar.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: K.BrandColors.lighBlue)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.blue )
            
        }
        
        return cell
    }
    
    
}

//extension ChatViewController : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//}
