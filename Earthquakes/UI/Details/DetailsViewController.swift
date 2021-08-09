import UIKit
import MapKit

final class DetailsViewController: BaseViewController<DetailsViewModel, MKMapView> {

    override func configure() {
        let coordinate = CLLocationCoordinate2D(latitude: viewModel.earthquake.lat, longitude: viewModel.earthquake.lng)
        let annotation = Annotation(title: viewModel.earthquake.eqid, locationName: String(viewModel.earthquake.magnitude), discipline: nil, coordinate: coordinate)
        contentView.centerCoordinate = annotation.coordinate
        contentView.addAnnotation(annotation)
    }
}
