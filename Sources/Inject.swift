//
//  File.swift
//  
//
//  Created by Muzammil Peer on 01/02/2022.
//
@propertyWrapper
public struct Inject<Component>{
    
    public     var component: Component
    
    public init(){
        self.component = Resolver.shared.resolve(Component.self)
    }
    
    public var wrappedValue:Component{
        get { return component}
        mutating set { component = newValue }
    }
    
}
