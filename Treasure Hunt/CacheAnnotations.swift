//
//  MarkerAnnotationsGoHere.swift
//  Treasure Hunt
//
//  Created by A.M. Student on 12/17/19.
//  Copyright © 2019 A.M. Student. All rights reserved.
//

import UIKit
import MapKit

enum CacheType {
    case tulsaTech
    case publicParks
    case publicMuseums
}
 
class CacheAnnotation:NSObject,MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: CacheType
    init(_ latitude:CLLocationDegrees,_ longitude:CLLocationDegrees,title:String,subtitle:String,type:CacheType){
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.title = title
        self.subtitle = subtitle
        self.type = type
    }
}
 
 
class CacheAnnotations: NSObject {
    var caches:[CacheAnnotation]
     
     override init(){
          //build an array of pizza loactions literally
           caches = [CacheAnnotation(36.033846,-95.981797, title: "Riverside Cache", subtitle: "36.1370970,-96.0965250", type: .tulsaTech)]
           caches += [CacheAnnotation(36.210999,-95.976343, title: "Peoria Cache", subtitle: "36.210999,-95.976343", type: .tulsaTech)]
           caches += [CacheAnnotation(36.003395,-95.833936, title: "Broken Arrow Cache", subtitle: "36.003395,-95.833936", type: .tulsaTech)]
           caches += [CacheAnnotation(36.137097,-96.096525, title: "Sand Spring Cache", subtitle: "36.137097,-96.096525", type: .tulsaTech)]
           caches += [CacheAnnotation(36.113433,-95.886927, title: "Lemley Memorial Cache", subtitle: "36.113433,-95.886927", type: .tulsaTech)]
           caches += [CacheAnnotation(36.122296,-95.985425, title: "Gathering Place Cache", subtitle: "36.122296,-95.985425", type: .publicParks)]
           caches += [CacheAnnotation(36.160408,-96.005639, title: "Owen Park Cache", subtitle: "36.160408,-96.005639", type: .publicParks)]
           caches += [CacheAnnotation(36.174719,-96.020289, title: "Gilcrease Museum Cache", subtitle: "36.174719,-96.020289", type: .publicMuseums)]
           caches += [CacheAnnotation(36.016921,-95.983280, title: "Dog Park Cache", subtitle: "36.016921,-95.983280", type: .publicParks)]
}
}
