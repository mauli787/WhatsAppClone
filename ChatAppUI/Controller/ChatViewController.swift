//
//  ViewController.swift
//  ChatAppUI
//
//  Created by Dnyaneshwar on 13/01/21.
//

import UIKit




class ChatViewController: UIViewController {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var chatCollView: UICollectionView!
    @IBOutlet var inputViewContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet var chatTF: UITextField!
    
    private(set) var chatsArray: [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Dnyaneshwar"
        self.assignDelegates()
        self.manageInputEventsForTheSubViews()
        
        let button:UIButton = UIButton()
        button.backgroundColor = UIColor.black
        button.setTitle("Button", for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func manageInputEventsForTheSubViews() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangeNotfHandler(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangeNotfHandler(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardFrameChangeNotfHandler(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            inputViewContainerBottomConstraint.constant = isKeyboardShowing ? keyboardFrame.height : 0
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                
                if isKeyboardShowing {
                    let lastItem = self.chatsArray.count - 1
                    let indexPath = IndexPath(item: lastItem, section: 0)
                    self.chatCollView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            })
        }
    }
    private func assignDelegates() {
        
        self.chatCollView.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
        self.chatCollView.dataSource = self
        self.chatCollView.delegate = self
        
        self.chatTF.delegate = self
    }
    @IBAction func onSendChat(_ sender: UIButton?) {
        
        guard let chatText = chatTF.text, chatText.count >= 1 else { return }
        chatTF.text = ""
        let chat = Chat.init(user_name: "Dnyanesh", user_image_url: "https://www.google.com/imgres?imgurl=https%3A%2F%2Fqph.fs.quoracdn.net%2Fmain-thumb-106852274-200-lofosrlnldookcqftegkgashilhvkoyg.jpeg&imgrefurl=https%3A%2F%2Fwww.quora.com%2Fprofile%2FDnyaneshwar-Shinde-4&tbnid=dKxF9654AR2fPM&vet=12ahUKEwi-gNyrxJnuAhUJcisKHQKpA54QMygregUIARDqAQ..i&docid=UMBiAn8Bk_zfPM&w=200&h=200&itg=1&q=dnyaneshwar%20shinde&ved=2ahUKEwi-gNyrxJnuAhUJcisKHQKpA54QMygregUIARDqAQ",text: chatText)
        
        self.chatsArray.append(chat)
        self.chatCollView.reloadData()
        
        let lastItem = self.chatsArray.count - 1
        let indexPath = IndexPath(item: lastItem, section: 0)
        self.chatCollView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
}

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let txt = textField.text, txt.count >= 1 {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        onSendChat(nil)
    }
}

extension ChatViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return chatsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = chatCollView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as? ChatCell {
            let chat = chatsArray[indexPath.item]
            cell.messageTextView.text = chat.text
            cell.nameLabel.text = chat.user_name
            cell.profileImageURL = URL.init(string: chat.user_image_url)!
            
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            var estimatedFrame = NSString(string: chat.text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
            estimatedFrame.size.height += 18
            
            let nameSize = NSString(string: chat.user_name).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)], context: nil)
            
            let maxValue = max(estimatedFrame.width, nameSize.width)
            estimatedFrame.size.width = maxValue
            
            let isEvenNum : Int = Int(chat.text) ?? 0

            if isEvenNum % 2 != 0 {
                
                cell.nameLabel.textAlignment = .left
                cell.profileImageView.frame = CGRect(x: 8, y: estimatedFrame.height - 8, width: 30, height: 30)
                cell.nameLabel.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: 18)
                cell.messageTextView.frame = CGRect(x: 48 + 8, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: 48 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 12, height: estimatedFrame.height + 20 + 6)
                cell.bubbleImageView.image = ChatCell.grayBubbleImage
                cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
                cell.messageTextView.textColor = UIColor.black
            } else {
                
                cell.nameLabel.textAlignment = .right
                cell.profileImageView.frame = CGRect(x: self.chatCollView.bounds.width - 38, y: estimatedFrame.height - 8, width: 30, height: 30)
                cell.nameLabel.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30 - 12, y: 0, width: estimatedFrame.width + 16, height: 18)
                cell.messageTextView.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: collectionView.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 30, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                cell.bubbleImageView.image = ChatCell.blueBubbleImage
                cell.bubbleImageView.tintColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
                cell.messageTextView.textColor = UIColor.white
            }
            
            return cell
        }
        
        return ChatCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let chat = chatsArray[indexPath.item]
        if let chatCell = cell as? ChatCell {
            chatCell.profileImageURL = URL.init(string: chat.user_image_url)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let chat = chatsArray[indexPath.item]
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        var estimatedFrame = NSString(string: chat.text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        estimatedFrame.size.height += 18
        
        return CGSize(width: chatCollView.frame.width, height: estimatedFrame.height + 20)
    }
    
}


enum Parity {
    case even, odd

    init<T>(_ integer: T) where T : BinaryInteger {
        self = integer.isMultiple(of: 2) ? .even : .odd
    }
}
extension BinaryInteger {
    var parity: Parity { Parity(self) }
}
 
