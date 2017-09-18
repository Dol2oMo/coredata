//
//  ViewController.swift
//  CoreDataSwift
//
//  Created by MC-MG57035 on 9/11/2560 BE.
//  Copyright © 2560 Dol2oMo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let data = DataStore()
        data.AddUserforData(username: "testoo", userid: 3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func click(_ sender: Any) {
        
        let con = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            let array = try con.fetch(User.fetchRequest())
            let data:[User] = array as! [User]
            
            
            for  username in data{
                let myname = username.user_name
                let myid = username.user_id
                print("\(String(describing: myname))" + "\(myid)")
            }
        }
        catch{
            
        }
        
//        let data = DataStore()
//        let user:[User]? = data.selectfechUserdata(User_id: 1)
//        for  username in user!{
//            let myname = username.user_name
//            let myid = username.user_id
//            print("\(String(describing: myname))" + "\(myid)")
//        }

        
    }
    @IBAction func deletes(_ sender: Any) {
        
        let data = DataStore()
        data.DeleteUserdata()
        
    }
    
    @IBAction func inserts(_ sender: Any) {
        
        let data = DataStore()
        data.AddUserforData(username: "testoo", userid: 3)
    }
    
}

