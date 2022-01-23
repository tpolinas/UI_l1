//
//  FriendsSearchViewController.swift
//  VK
//
//  Created by Polina Tikhomirova on 21.12.2021.
//

import UIKit

final class FriendsSearchViewController: UITableViewController {

    var friends = [
        UserModel(userFirstName: "Polina",
                  userSurname: "James",
                  userPhoto: UIImage(named: "2"),
                  userAge: 20),
        UserModel(userFirstName: "Ivan",
                  userSurname: "Gomez",
                  userPhoto: UIImage(named: "3"),
                  userAge: 20),
        UserModel(userFirstName: "Pavel",
                  userSurname: "Harvey",
                  userPhoto: UIImage(named: "5"),
                  userAge: 20),
        UserModel(userFirstName: "Maria",
                  userSurname: "Fernando",
                  userPhoto: UIImage(named: "6"),
                  userAge: 20),
        UserModel(userFirstName: "Nick",
                  userSurname: "Cage",
                  userPhoto: UIImage(named: "7"),
                  userAge: 20),
        UserModel(userFirstName: "Shawn",
                  userSurname: "Frank",
                  userPhoto: UIImage(named: "9"),
                  userAge: 20)
    ]
    
    var userFriends: [UserModel] = []
    var friendSectionTitles = [String]()
    var friendsDictionary = [String: [UserModel]]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(
            nibName: "FriendCell",
            bundle: nil),
                           forCellReuseIdentifier: "friendCell")
        
        for friend in friends {
            let friendKey = String(friend.userSurname.prefix(1))
            
            if var friendValues = friendsDictionary[friendKey] {
                friendValues.append(friend)
                friendsDictionary[friendKey] = friendValues
            } else {
                friendsDictionary[friendKey] = [friend]
            }
        }

        friendSectionTitles = [String](friendsDictionary.keys)
        friendSectionTitles = friendSectionTitles.sorted(by: { $0 < $1 })
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        friendSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friendKey = friendSectionTitles[section]
        if let friendValues = friendsDictionary[friendKey] {
            return friendValues.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        friendSectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        friendSectionTitles
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendCell
        else { return UITableViewCell() }
        
        var currentFriend = friends[indexPath.row]
        
        let friendKey = friendSectionTitles[indexPath.section]
        if let friendValues = friendsDictionary[friendKey] {
            currentFriend = friendValues[indexPath.row]
        }
        
        cell.configure(photo: currentFriend.userPhoto ?? UIImage(), name: currentFriend.userFirstName, surname: currentFriend.userSurname)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        let friendKey = friendSectionTitles[indexPath.section]
        var currentFriend = friends[indexPath.row]
        if let friendValues = friendsDictionary[friendKey] {
            currentFriend = friendValues[indexPath.row]
        }
        
        if userFriends.firstIndex(of: currentFriend) == nil {
            userFriends.append(currentFriend)
        }
        
        self.performSegue(withIdentifier: "addFriend", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "addFriend",
               let myFriendsViewController = segue.destination as? MyFriendsViewController {
                myFriendsViewController.friends = userFriends
        }
    }
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
