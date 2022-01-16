//
//  AllGroupsViewController.swift
//  VK
//
//  Created by Polina Tikhomirova on 21.12.2021.
//
import UIKit

final class AllGroupsViewController: UITableViewController {

    var groups = [
        "cats",
        "birds",
        "dogs",
        "books",
        "music",
        "movies",
        "art",
        "science",
        "tech",
        "beauty",
    ]
    
    var userGroups: [String] = []
    var groupSectionTitles = [String]()
    var groupsDictionary = [String: [String]]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(
            nibName: "GroupCell",
            bundle: nil),
                           forCellReuseIdentifier: "groupCell")
        
        for group in groups {
            let groupKey = String(group.prefix(1))
            if var groupValues = groupsDictionary[groupKey] {
                groupValues.append(group)
                groupsDictionary[groupKey] = groupValues
            } else {
                groupsDictionary[groupKey] = [group]
            }
        }
        
        
        groupSectionTitles = [String](groupsDictionary.keys)
        groupSectionTitles = groupSectionTitles.sorted(by: { $0 < $1 })
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let groupKey = groupSectionTitles[section]
        if let groupValues = groupsDictionary[groupKey] {
            return groupValues.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupSectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return groupSectionTitles
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell
        else { return UITableViewCell() }
        
        var currentGroup = groups[indexPath.row]
        
        let groupKey = groupSectionTitles[indexPath.section]
        if let groupValues = groupsDictionary[groupKey] {
            currentGroup = groupValues[indexPath.row]
        }
        
        cell.configure(
            photo: UIImage(systemName: "person.3.fill") ?? UIImage(),
            name: currentGroup)

        return cell
    }

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        let groupKey = groupSectionTitles[indexPath.section]
        var currentGroup = ""
        if let groupValues = groupsDictionary[groupKey] {
            currentGroup = groupValues[indexPath.row]
        }
        
        if userGroups.firstIndex(of: currentGroup) == nil {
            userGroups.append(currentGroup)
        }
        
        self.performSegue(withIdentifier: "addGroup", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "addGroup",
               let myGroupsViewController = segue.destination as? MyGroupsViewController {
                myGroupsViewController.groups = userGroups
        }
    }
}
