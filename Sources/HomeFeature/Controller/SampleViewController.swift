//
//  SampleViewController.swift
//  
//
//  Created by Muzammil Peer on 27/01/2022.
//
#if !os(macOS)
import UIKit
#endif

import APIClient
//https://www.swiftbysundell.com/tips/handling-view-controllers-that-have-custom-initializers/

class SampleViewController: UIViewController {
    
    @available(*, unavailable, renamed: "init(homeService:coder:)")
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    private let homeService: HomeServiceProtocol

    init(homeService: HomeServiceProtocol) {
        self.homeService = homeService
        super.init(nibName: nil, bundle: nil)
    }
    
    init(homeService: HomeServiceProtocol,viaXIB:Bool) {
        self.homeService = homeService
        let bundle = Bundle.module
        super.init(nibName: "SampleViewController", bundle: bundle)
    }
    
//        required convenience init?(coder: NSCoder) {
//            self.init(contactList: .shared)
//        }

//    private let productLoader: ProductLoader
//
//    @IBSegueAction func showCurrentOffers(
//            _ coder: NSCoder
//        ) -> ProductOffersViewController? {
//            ProductOffersViewController(
//                productLoader: productLoader,
//                coder: coder
//            )
//        }
//    private func showDetails(for product: Product) {
//            guard let viewController = storyboard?.instantiateViewController(
//                identifier: "ProductDetails",
//                creator: { coder in
//                    ProductDetailsViewController(product: product, coder: coder)
//                }
//            ) else {
//                fatalError("Failed to create Product Details VC")
//            }
//
//            show(viewController, sender: self)
//        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.test_endToEndTestServerGETFruits()
    }

//    private func ephemeralClient(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
//        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
////        trackForMemoryLeaks(client, file: file, line: line)
//        return client
//    }

    func test_endToEndTestServerGETFruits() {
//        let service = HomeService.init(httpClient: ephemeralClient(), baseURL: URL.init(string: "https://api.themoviedb.org/3/")!)
        self.homeService.getMoviePopularList { resultObjects in
            switch resultObjects {
            case let .success(fruits)?:
                print("how many objects %d",fruits.first?.originalTitle)
            case let .failure(error)?:
                print("failed:\(error)")

            default:
                print("failed")
            }
        }
    }

}

//extension UIViewController {
//    /// Eventhough we already set the file owner in the xib file, where we are setting the file owner again because sending nil will set existing file owner to nil.
//    @discardableResult
//    func fromNib<T : UIViewController>() -> T? {
//        guard let contentView = Bundle(for: type(of: self))
//            .loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
//                return nil
//        }
//        return contentView
//    }
//}
