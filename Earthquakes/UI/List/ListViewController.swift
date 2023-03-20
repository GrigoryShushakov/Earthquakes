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
        viewModel.loadList()
    }
    
    private func setupBindings() {
        
        viewModel.$state
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.contentView.spinner.startAnimating()
                case .finished(let earthquakes):
                    self?.endRefreshing()
                    self?.updateUI(earthquakes)
                case .error(let error):
                    self?.endRefreshing()
                    self?.showError(error)
                }
            }
            .store(in: &cancellables)
        
        contentView.refreshControl.isRefreshingPublisher
            .sink { [weak self] isRefreshing in
                if isRefreshing { self?.viewModel.loadList() }
            }
            .store(in: &cancellables)
        
        contentView.tableView.didSelectRowPublisher
            .sink { [weak self] indexPath in
                guard case .finished(let earthquakes) = self?.viewModel.state else { return }
                self?.router?.quakeDetails(earthquakes[indexPath.row])
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
            cell?.cityLabel.text = earthquake.properties.place
            cell?.regionLabel.text = self.timestampFormatter.string(from: Date(timeIntervalSince1970: earthquake.properties.time/1000.0))
            cell?.imgView.image = UIImage(named: "MapPlaceholder")
            cell?.magnitudeLabel.text = String(earthquake.properties.mag)
            cell?.magnitudeLabel.textColor = earthquake.properties.mag >= 7.0 ? UIColor.systemRed.withAlphaComponent(0.7) : UIColor.label
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
    
    private let timestampFormatter: DateFormatter = {
        let timestampFormatter = DateFormatter()

        timestampFormatter.dateStyle = .medium
        timestampFormatter.timeStyle = .medium

        return timestampFormatter
    }()
    
    private func endRefreshing() {
        self.contentView.spinner.stopAnimating()
        self.contentView.refreshControl.endRefreshing()
    }
}
