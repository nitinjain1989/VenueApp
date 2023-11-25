//
//  VenueViewController.swift
//  VanueApp
//
//  Created by Nitin Jain on 25/11/23.
//

import UIKit

final class VenueViewController: UIViewController {

    private var viewModel: VenueViewModelType
    
    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.estimatedRowHeight = 60
        tableview.rowHeight = UITableView.automaticDimension
        tableview.dataSource = self
        tableview.register(VenueTableViewCell.self, forCellReuseIdentifier: "VenueTableViewCell")
        return tableview
    }()
    
    init(viewModel: VenueViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTableView()
        self.viewModel.getVenues()
        
    }
    
    func addTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
}

extension VenueViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueTableViewCell", for: indexPath) as! VenueTableViewCell
        let venue = viewModel.venues[indexPath.item]
        cell.setDataOnCell(model: venue)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height){
            self.viewModel.getVenues()
        }
    }
}

extension VenueViewController: VenueViewModelDelegate {
    
    func updateList() {
        self.tableView.reloadData()
    }
}
