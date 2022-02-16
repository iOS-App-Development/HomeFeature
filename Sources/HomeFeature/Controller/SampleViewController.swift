//
//  SampleViewController.swift
//  
//
//  Created by Muzammil Peer on 27/01/2022.
//
#if !os(macOS)
import UIKit
#endif
import SharedModule
//https://www.swiftbysundell.com/tips/handling-view-controllers-that-have-custom-initializers/

class SampleViewController: UIViewController {
    @available(*, unavailable, renamed: "init(homeService:coder:)")
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    private let homeService: HomeServiceProtocol
    private let serviceIdentifer = HomeServiceProtocol.self
    
    init(homeService: HomeServiceProtocol) {
        self.homeService = homeService
        let bundle = Bundle.module
        super.init(nibName: "SampleViewController", bundle: bundle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callPopularMoviesAPI()
    }
}

extension SampleViewController
{
    
    func callPopularMoviesAPI() {
        self.homeService.getMoviePopularList { resultObjects in
            switch resultObjects {
            case let .success(fruits)?:
                print("first movie title = %@",fruits.first?.originalTitle ?? "")
            case let .failure(error)?:
                print("failed:\(error)")

            default:
                print("failed")
            }
        }
    }

}
