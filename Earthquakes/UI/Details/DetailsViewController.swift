import UIKit
import MapKit

final class DetailsViewController: BaseViewController<DetailsViewModel> {
    let mapView = MKMapView(frame: .zero)
    
    override func loadView() {
        view = mapView
    }
    
    override func configure() {
        let coordinate = CLLocationCoordinate2D(latitude: viewModel.earthquake.lat, longitude: viewModel.earthquake.lng)
        let annotation = Annotation(title: viewModel.earthquake.eqid, locationName: String(viewModel.earthquake.magnitude), discipline: nil, coordinate: coordinate)
        mapView.centerCoordinate = annotation.coordinate
        mapView.addAnnotation(annotation)
    }
}
