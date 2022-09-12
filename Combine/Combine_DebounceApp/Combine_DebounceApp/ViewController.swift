//
//  ViewController.swift
//  Combine_DebounceApp
//
//  Created by Noah Park on 2022/09/12.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var debouncedLabel: UILabel!
    
    private lazy var searchController: UISearchController = {
       let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .black
        searchController.searchBar.searchTextField.accessibilityIdentifier = "searchTextField"
        return searchController
    }()
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.searchController = searchController
        searchController.isActive = true
        searchController.searchBar.searchTextField
            .debounceSearchPublisher
            .sink { [weak self] recievedValue in
                self?.debouncedLabel.text = recievedValue
            }
            .store(in: &subscriptions)
    }
}

extension UISearchTextField {
    var debounceSearchPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UISearchTextField }
            .map { $0.text ?? "" }
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .filter{ $0.count > 0 }
            .eraseToAnyPublisher()
    }
}

