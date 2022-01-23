//
//  MyFriendsViewController.swift
//  VK
//
//  Created by Polina Tikhomirova on 19.12.2021.
//

import UIKit

final class MyFriendsViewController: UITableViewController {
    var friends = [UserModel]() {
        didSet {
            //
        }
    }
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {

                if sender.state == UIGestureRecognizer.State.began {
                    let touchPoint = sender.location(in: tableView)
                    if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                        // your code here, get the row for the indexPath or do whatever you want
                        print("Long press Pressed:)")
                        let friendCell = FriendCell()
                        friendCell.animateMe()
                        
                    }
                }
            }
    
    @IBAction func addFriend(segue: UIStoryboardSegue) {
        guard segue.identifier == "addFriend",
            let allFriendsViewController = segue.source as? FriendsSearchViewController
        else { return }
        
        friends = allFriendsViewController.userFriends.sorted {
            $0.userSurname < $1.userSurname
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(MyFriendsViewController.longPress(sender:)))
                tableView.addGestureRecognizer(longPress)
        
        tableView.register(UINib(
            nibName: "FriendCell",
            bundle: nil),
                           forCellReuseIdentifier: "friendCell")
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendCell
        else { return UITableViewCell() }
        
        let currentFriend = friends[indexPath.row]
        
        cell.configure(photo: currentFriend.userPhoto ?? UIImage(), name: currentFriend.userFirstName, surname: currentFriend.userSurname)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(
            at: indexPath,
            animated: true)}
        performSegue(
            withIdentifier: "showProfile",
            sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addFriend",
           let allFriendsViewController = segue.destination as? FriendsSearchViewController {
            allFriendsViewController.userFriends = friends
        }
    }
}




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


