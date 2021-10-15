import UIKit
import MapKit

final class DetailsViewController: BaseViewController<DetailsViewModel, DetailsView> {

    override func configure() {
        super.configure()
        
        contentView.magnitudeLabel.text = String(viewModel.earthquake.properties.mag)
        contentView.magnitudeLabel.textColor = viewModel.earthquake.properties.mag >= 7.0 ? UIColor.systemRed.withAlphaComponent(0.7) : UIColor.label
        contentView.cityLabel.text = viewModel.earthquake.properties.place
        contentView.regionLabel.text = viewModel.earthquake.properties.region ?? "Unknown"
        contentView.severityLabel.text = viewModel.earthquake.properties.mag >= 7.0 ? "This is severe Earthquake" : ""
        
        let coordinate = CLLocationCoordinate2D(latitude: viewModel.earthquake.geometry.coordinates[1], longitude: viewModel.earthquake.geometry.coordinates[0])
        let annotation = Annotation(title: viewModel.earthquake.id, locationName: String(viewModel.earthquake.properties.mag), discipline: nil, coordinate: coordinate)
        contentView.mapView.centerCoordinate = annotation.coordinate
        contentView.mapView.addAnnotation(annotation)
        contentView.mapView.isZoomEnabled = true
        contentView.mapView.isScrollEnabled = false
    }
}
