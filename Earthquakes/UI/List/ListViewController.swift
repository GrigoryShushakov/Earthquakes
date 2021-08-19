import UIKit
import Combine
import CombineCocoa

final class ListViewController: BaseViewController<ListViewModel, ListView> {
    var router: ListRouter?
    private var cancellables = Set<AnyCancellable>()
    
    private typealias DataSource = UITableViewDiffableDataSource<ListViewModel.Section, Earthquake>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<ListViewModel.Section, Earthquake>
    private var dataSource: DataSource!
    
    override func configure() {
        super.configure()
        
        setupTableView()
        configureDataSource()
        setupBindings()
    }
    
    private func setupBindings() {
        
        viewModel.$earthquakes
            .dropFirst()
            .sink { [weak self] quakes in
                self?.updateUI(quakes)
            }
            .store(in: &cancellables)
        
        viewModel.$state
            .sink { [weak self] state in
                switch state {
                case .loading: self?.contentView.spinner.startAnimating()
                case .finished: self?.contentView.spinner.stopAnimating()
                case .error(let error):
                    self?.contentView.spinner.stopAnimating()
                    self?.showError(error)
                }
                self?.contentView.refreshControl.endRefreshing()
            }
            .store(in: &cancellables)
        
        contentView.refreshControl.isRefreshingPublisher
            .sink { [weak self] isRefreshing in
                if isRefreshing { self?.viewModel.loadList() }
            }
            .store(in: &cancellables)
        
        contentView.tableView.didSelectRowPublisher
            .sink { [weak self] indexPath in
                guard let quake = self?.viewModel.earthquakes[indexPath.row] else { return }
                self?.router?.quakeDetails(quake)
            }
            .store(in: &cancellables)
    }
    
    private func setupTableView() {
        contentView.tableView.register(EarthquakeTableViewCell.self, forCellReuseIdentifier: EarthquakeTableViewCell.identifier)
    }
    
    private func updateUI(_ value: [Earthquake]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.quakes])
        snapshot.appendItems(value)
        dataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: contentView.tableView, cellProvider: { tableView, indexPath, earthquake in
            let cell = tableView.dequeueReusableCell(withIdentifier: EarthquakeTableViewCell.identifier, for: indexPath) as? EarthquakeTableViewCell
            earthquake.fetchCityAndRegion { city, region, error in
                cell?.cityLabel.text = city ?? "Unknown"
                cell?.regionLabel.text = region ?? "Unknown"
            }
            cell?.imgView.image = UIImage(named: "MapPlaceholder")
            cell?.magnitudeLabel.text = String(earthquake.magnitude)
            cell?.magnitudeLabel.textColor = earthquake.magnitude >= 7.0 ? UIColor.systemRed.withAlphaComponent(0.7) : UIColor.label
            return cell
        })
    }
    
    private func showError(_ error: Swift.Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
