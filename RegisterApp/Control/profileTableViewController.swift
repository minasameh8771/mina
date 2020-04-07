//
//  profileTableViewController.swift
//  RegisterApp
//
//  Created by mina sameh on 3/22/20.
//  Copyright © 2020 minafcis16. All rights reserved.
//

import UIKit

class profileTableViewController: UITableViewController {

    let firstLabel = ["Username" , "Email" , "Gender" , "Address"]
    var secondLabel : [String] = []
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DecodingAndGetData()
        registerCell()
    }
    
    private func registerCell() {
        let cell = UINib(nibName: "profileTableViewCell",
                         bundle: nil)
        self.tableView.register(cell,
                                forCellReuseIdentifier: "customCell")
    }
    
    func DecodingAndGetData () {
        if let jsonString = defaults.string(forKey: "user") {
            
            if let jsonData = jsonString.data(using: .utf8)
            {
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jsonData)
                    secondLabel.append(user.name)
                    secondLabel.append(user.email)
                    secondLabel.append(user.gender)
                    secondLabel.append("Not Now :)")
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 4 {
            let cell = Bundle.main.loadNibNamed("profileBTNTableViewCell", owner: self, options: nil)?.first as! profileBTNTableViewCell
            
            cell.logOutBTN.addTarget(self, action: #selector(self.goToSignInScreen(_ :)), for: UIControl.Event.touchUpInside)
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? profileTableViewCell else {
            print("fail")
            return UITableViewCell()
        }
        
        cell.firstLabel.text = firstLabel[indexPath.row]
        cell.secondLabel.text = secondLabel[indexPath.row]
        
        return cell
    }
    
    @objc func goToSignInScreen(_ sender : UIButton) {
        let signInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignIn")
        UserDefaults.standard.set("false", forKey : "IsLogin")
        self.present(signInVC, animated: true, completion: nil)
    }
    
   

    // MARK: - Table view data source


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
