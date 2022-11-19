//
//  ViewController.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 16.11.2022.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties

    let network = NetworkManager(memoryCapacity: Constants.memoryCapacity, diskCapacity: Constants.diskCapacity, diskPath: Constants.diskPath)
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
        network.getData(dataURL: URL(string: Constants.urlString)!)

    }

    // MARK: - Actions
    private func registerTable() {

        table.register(TableViewCell.self, forCellReuseIdentifier: Constants.cellID)
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
