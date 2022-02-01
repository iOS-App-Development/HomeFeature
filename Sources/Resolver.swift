//
//  File.swift
//  
//
//  Created by Muzammil Peer on 01/02/2022.
//
public class Resolver{
  
    public   static let shared = Resolver()
    public var factoryDict: [String: () -> Component] = [:]
    
    public func add(type: Component.Type, _ factory: @escaping () -> Component) {
        factoryDict[String(describing: type.self)] = factory
    }

    public func resolve<Component>(_ type: Component.Type) -> Component {
        let component: Component = factoryDict[String(describing:Component.self)]?() as! Component
        return component
    }
}
