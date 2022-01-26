//
//  MyGroupsViewController.swift
//  VK
//
//  Created by Polina Tikhomirova on 19.12.2021.
//

import UIKit

final class MyGroupsViewController: UITableViewController {
    var groups = [String]() {
        didSet {
            //
        }
    }
    
    
@IBAction func addGroup(segue: UIStoryboardSegue) {
    guard segue.identifier == "addGroup",
        let allGroupsViewController = segue.source as? AllGroupsViewController
    else { return }
    groups = allGroupsViewController.userGroups
    tableView.reloadData()
}
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {

                if sender.state == UIGestureRecognizer.State.began {
                    let touchPoint = sender.location(in: tableView)
                    if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                        print("Long press Pressed:)")
                        let groupCell = GroupCell()
                        groupCell.animateMe()
                        
                    }
                }
            }

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(
            nibName: "GroupCell",
            bundle: nil),
                           forCellReuseIdentifier: "groupCell")
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(MyGroupsViewController.longPress(sender:)))
                tableView.addGestureRecognizer(longPress)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell
        else { return UITableViewCell() }
        
        let currentGroup = groups[indexPath.row]

        cell.configure(
            photo: UIImage(systemName: "person.3.fill") ?? UIImage(),
            name: currentGroup)

        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(
                at: [indexPath],
                with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGroup",
           let allGroupsViewController = segue.destination as? AllGroupsViewController {
            allGroupsViewController.userGroups = groups
        }
    }
}
