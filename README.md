# Dynamics

Dynamics provides a dynamically generator and dynamically access.

## Generator

### URLQueryItemsGenerator

```swift
import UIKit
import Dynamics

var components = URLComponents()
components.scheme = "https"
components.host = "httpbin.org"
components.path = "/get"
let urlQueryItemsGenerator = URLQueryItemsGenerator()
components.queryItems = urlQueryItemsGenerator(i:"1",s:"text",b:"true")
print(components.url!) // https://httpbin.org/get?i=1&s=text&b=true
```

### JSONDataGenerator

```swift
import UIKit
import Dynamics

var components = URLComponents()
components.scheme = "https"
components.host = "httpbin.org"
components.path = "/post"
var request = URLRequest(url: components.url!)
request.httpMethod = "POST"
request.addValue("application/json", forHTTPHeaderField: "Content-Type")
let jsonDataGenerator = JSONDataGenerator()
/*
 POST /post
 Content-Type: application/json
 Host: httpbin.org

 {
   "i": 1,
   "s": "text",
   "b": true
 }
 */
request.httpBody = jsonDataGenerator(i:1,s:"text",b:true)

```
