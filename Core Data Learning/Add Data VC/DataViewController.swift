//
//  DataViewController.swift
//  Core Data Learning
//
//  Created by AshutoshD on 26/03/20.
//  Copyright © 2020 ravindraB. All rights reserved.
//

import UIKit

class DataViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var txtName : UITextField!
    @IBOutlet var tblView : UITableView!
    let persistenceManager : PersistanceManager
    var usersData = [String]()
    var users = [User]()
    var indexpath = Int()
    
    init(persistenceManager : PersistanceManager) {
        self.persistenceManager = persistenceManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.delegate = self
        self.tblView.dataSource = self
        getUsers()
        tblView.register(UINib(nibName: "AllUserDataCell", bundle: nil), forCellReuseIdentifier: "AllUserDataCell")
    }


    func createUser() {
        let user = User(context: persistenceManager.context)
        if txtName.text != "" {
        user.name = txtName.text!
            persistenceManager.save()
            txtName.text = ""
        }else{
            print("Plese enter text first")
        }
    }
    
    
    @IBAction func addNameTapped (_ sender : UIButton){
        createUser()
        getUsers()
        tblView.reloadData()
    }


    func getUsers() {
//            guard let users = try! persistenceManager.context.fetch(User.fetchRequest()) as? [User] else{
//                return
//            }
            usersData.removeAll()
            let users  = persistenceManager.fetch(User.self)
            self.users = users
            print(usersData)
            users.forEach(
                {
                    print($0.name)
                    usersData.append($0.name)
            }
            )
        }
    
    func updateUsers(){
        
        let firstUser = users.first
        firstUser?.name  += "New Added Thing"
        persistenceManager.save()
        tblView.reloadData()
    }
    
    func deleteUser(){
        
//        let firstUser = users.remove(at: indexpath)
        persistenceManager.delete(user: users[indexpath])
        getUsers()
        tblView.reloadData()
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllUserDataCell", for: indexPath)
            as! AllUserDataCell
        cell.lblName.text = usersData[indexPath.row]
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            indexpath = indexPath.row
            deleteUser()
//            tblView.deleteRows(at: [indexPath], with: .fade)
//            tblView.reloadData()
        }
//        else if editingStyle == .insert {
//           updateUsers()
//        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let testObj = self.users[indexPath.row]
            testObj.setValue(firstTextField.text!, forKey: "name")
            self.persistenceManager.save()
            self.getUsers()
            self.tblView.reloadData()
            
            print("firstName \(firstTextField.text!)")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.text! = self.users[indexPath.row].name
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    

}
