//
//  MyFriendsViewController.swift
//  VK
//
//  Created by Polina Tikhomirova on 19.12.2021.
//

import UIKit

final class MyFriendsViewController: UITableViewController {
    var friends = [String]() {
        didSet {
            //
        }
    }
    
    
    @IBAction func addFriend(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "addFriend",
            let allFriendsController = segue.source as? FriendsSearchViewController,
            let friendIndexPath = allFriendsController.tableView.indexPathForSelectedRow,
            !self.friends.contains(allFriendsController.friends[friendIndexPath.row])
        else { return }
        self.friends.append(allFriendsController.friends[friendIndexPath.row])
        tableView.reloadData()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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

        cell.configure(
            photo: UIImage(named: "\(indexPath.row)") ?? UIImage(),
            name: currentFriend)

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

