import UIKit
import MapKit

final class DetailsView: UIView {
    
    init() {
        super.init(frame: .zero)
        buildUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func buildUI() {
        [cityLabel, regionLabel, magnitudeLabel, mapView, severityLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Layout.spacing),
            cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.offset),
            regionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: Layout.spacing),
            regionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.offset),
            magnitudeLabel.topAnchor.constraint(equalTo: cityLabel.topAnchor),
            magnitudeLabel.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: Layout.spacing),
            magnitudeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.offset),
            mapView.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: Layout.offset),
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.offset),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.offset),
            mapView.heightAnchor.constraint(equalTo: mapView.widthAnchor),
            severityLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: Layout.offset),
            severityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.offset),
            severityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.spacing),
        ])
    }
    
    let cityLabel = UILabel()
    let regionLabel = UILabel()
    let magnitudeLabel = UILabel()
    let mapView = MKMapView(frame: .zero)
    let severityLabel = UILabel()
}
