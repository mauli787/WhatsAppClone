//
//  ListViewController.swift
//  ChatAppUI
//
//  Created by Dnyaneshwar on 14/01/21.
//

import UIKit
class ListViewController: UIViewController {
    
    @IBOutlet var listTableView: UITableView!
    private var usersListVM: UserListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "List"
        self.listTableView.register(UINib(nibName: "ListTableCell", bundle: nil), forCellReuseIdentifier: ListTableCell.identifier)
        APIManager().getArticles { (userlist) in
            self.usersListVM = UserListViewModel(users: userlist!)
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
    }
}
extension ListViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersListVM.numberOfRowsInSection(section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell  = self.listTableView.dequeueReusableCell(withIdentifier: ListTableCell.identifier, for: indexPath) as? ListTableCell else { return UITableViewCell() }
        let listVM = self.usersListVM.userAtIndex(indexPath.row)
        cell.setupCell(user: listVM)
        return cell
    }    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = self.storyboard?.instantiateViewController(identifier: "ChatViewController") as! ChatViewController
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
}

