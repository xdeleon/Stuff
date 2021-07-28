//
//  ListViewController.swift
//  ADT
//
//  Created by Xavier De Leon on 7/28/21.
//

import UIKit

final class ShowCell: UITableViewCell {
    var showViewModel: Result! {
        didSet {
            textLabel?.text = showViewModel.name
        }
    }
}

final class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    var showViewModels = [Result]()
    var selectedRow = 0
    let detailSegueID = "detailSegueID"

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: Tableview

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCellID", for: indexPath) as! ShowCell

        cell.showViewModel = showViewModels[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: detailSegueID, sender: nil)
    }

    // MARK: Custom Functions

    fileprivate func loadData() {
        NetworkService.shared.fetchShows { (data, error) in
            if let error = error {
                self.showAlert(withTitle: "Error", message: "Unable to fetch shows: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            self.showViewModels = data.results

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueID {
            let vc = segue.destination as! DetailViewController
            vc.showViewModel = showViewModels[selectedRow]
        }
    }
}
