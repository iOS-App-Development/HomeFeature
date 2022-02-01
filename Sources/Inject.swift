//
//  File.swift
//  
//
//  Created by Muzammil Peer on 01/02/2022.
//
@propertyWrapper
struct Inject<Component>{
    
    var component: Component
    
    init(){
        self.component = Resolver.shared.resolve(Component.self)
    }
    
    public var wrappedValue:Component{
        get { return component}
        mutating set { component = newValue }
    }
    
}
