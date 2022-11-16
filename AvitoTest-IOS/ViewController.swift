//
//  ViewController.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 16.11.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    let cellID = "cellTypeIdentifier"
    var employees = [Employee]()
    private lazy var table: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTable()
    }
    
    // MARK: - Actions
    private func registerTable() {
        
        table.register(TableViewCell.self, forCellReuseIdentifier: cellID)
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = table.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = table.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = table.widthAnchor.constraint(equalToConstant: view.bounds.width)
        let heightConstraint = table.heightAnchor.constraint(equalToConstant: view.bounds.height)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        self.table.reloadData()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCell
        cell.fillDataForEmployee(employee: employees[indexPath.row])

        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

