import UIKit
import MapKit

final class DetailsViewController: BaseViewController<DetailsViewModel, DetailsView> {

    override func configure() {
        super.configure()
        
        contentView.magnitudeLabel.text = String(viewModel.earthquake.magnitude)
        contentView.magnitudeLabel.textColor = viewModel.earthquake.magnitude >= 7.0 ? UIColor.systemRed.withAlphaComponent(0.7) : UIColor.label
        contentView.cityLabel.text = viewModel.earthquake.city ?? "Unknown"
        contentView.regionLabel.text = viewModel.earthquake.region ?? "Unknown"
        contentView.severityLabel.text = viewModel.earthquake.magnitude >= 7.0 ? "This is severe Earthquake" : ""
        
        let coordinate = CLLocationCoordinate2D(latitude: viewModel.earthquake.lat, longitude: viewModel.earthquake.lng)
        let annotation = Annotation(title: viewModel.earthquake.eqid, locationName: String(viewModel.earthquake.magnitude), discipline: nil, coordinate: coordinate)
        contentView.mapView.centerCoordinate = annotation.coordinate
        contentView.mapView.addAnnotation(annotation)
        contentView.mapView.isZoomEnabled = true
        contentView.mapView.isScrollEnabled = false
    }
}
