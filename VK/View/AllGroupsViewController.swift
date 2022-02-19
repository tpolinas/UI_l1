//
//  AllGroupsViewController.swift
//  VK
//
//  Created by Polina Tikhomirova on 21.12.2021.
//
import UIKit

final class AllGroupsViewController: UITableViewController {

    // All the groups
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

    @IBOutlet var searchBar: UISearchBar!
    
    // Checks if search is active or not
    var isSearching = false

    // This will hold the filtered array when searching
    var filteredData = [String]()

    // This will hold groups of the user
    var userGroups: [String] = []

    // This will hold section prefixes [a, b, c, etc]
    var groupSectionTitles = [String]()

    // This will hold mapping of prefixes to groups
    // [a: [art], b: [beauty, books], etc]
    var groupsDictionary = [String: [String]]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.delegate = self
        
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
    
    private func getGroups(in section: Int) -> [String]
    {
        // The current section should be got from groupSectionTitles
        let groupKey = groupSectionTitles[section]
        
        var groupsInSection: [String] = []
        
        // Get groups for current section
        if let groupValues = groupsDictionary[groupKey] {
            groupsInSection = groupValues
        }
        
        // Change groups in section if searching
        if isSearching {
            groupsInSection = filteredData
        }
        
        return groupsInSection
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
    {
        if isSearching {
            return filteredData.count
        } else {
            let groupsInSection = getGroups(in: section)
            return groupsInSection.count
        }
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupSectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return groupSectionTitles
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell
                = tableView.dequeueReusableCell(withIdentifier: "groupCell",
                                                for: indexPath) as? GroupCell
        else { return UITableViewCell() }
        
        let groupsInSection = getGroups(in: indexPath.section)
        
        cell.configure(
            photo: UIImage(systemName: "person.3.fill") ?? UIImage(),
            name: groupsInSection[indexPath.row])
        
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath)
    {
        let groupsInSection = getGroups(in: indexPath.section)
        let currentGroup = groupsInSection[indexPath.row]
        
        if userGroups.firstIndex(of: currentGroup) == nil {
            userGroups.append(currentGroup)
        }
        
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
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

extension AllGroupsViewController {
     
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         filteredData = groups.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
         isSearching = true
         tableView.reloadData()
     }
     
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         isSearching = false
         searchBar.text = ""
         tableView.reloadData()
     }
 }
