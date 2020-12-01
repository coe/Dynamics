import XCTest
import Dynamics

final class DynamicsTests: XCTestCase {
    private let data = """
    {
        "true_value": true,
        "false_value": false,
        "string_value": "red",
        "one_value": 1,
        "zero_value": 0,
        "minus_value": -1,
        "int_value": 123,
        "double_value": 3.14,
        "null_value": null,
        "array_list": [12, 23],
        "object_list": {
            "user_id": "A1234567",
            "user_name": "Yamada Taro"
        }
    }
    """.data(using: .utf8)!
    
    func testJson() throws {
        let json = try JSON(data: data)
        XCTAssertEqual(json.true_value?.boolValue, true)
        XCTAssertEqual(json.false_value?.boolValue, false)
        XCTAssertEqual(json.string_value?.stringValue, "red")
        XCTAssertEqual(json.one_value?.numberValue, 1)
        XCTAssertEqual(json.zero_value?.numberValue, 0)
        XCTAssertEqual(json.minus_value?.numberValue, -1)
        XCTAssertEqual(json.int_value?.numberValue, 123)
        XCTAssertEqual(json.double_value?.numberValue, 3.14)
        XCTAssertEqual(json.array_list?[0]?.numberValue, 12)
        XCTAssertEqual(json.object_list?.user_id?.stringValue, "A1234567")
        XCTAssertEqual(json.null_value?.nullValue, NSNull())
        XCTAssertNil(json.undefined_value)
    }
    
    func testJsonThrow() throws {
        XCTAssertThrowsError(try JSON(data: Data()))
    }
    
    func testJSONDataGenerator() {
        let generator = JSONDataGenerator()
        let jsonData =  generator(int_value: 120,
                                  string_value: "string",
                                  bool_value: true,
                                  array_value: [1,"2",true],
                                  dictionary_value: ["1":1,"2":"2"],
                                  null_value: nil)
        if let json = try? JSONSerialization.jsonObject(with: jsonData!, options: []) as? [String:Any] {
            print(json)
            XCTAssertEqual(json["int_value"] as? Int, 120)
            XCTAssertEqual(json["string_value"] as? String, "string")
            XCTAssertEqual(json["bool_value"] as? Bool, true)
            XCTAssertNil(json["null_value"])
            XCTAssertNil(json["undefined_value"])
        } else {
            XCTFail()
        }
    }
    
    func testJSONDataGeneratorWithDate()  {
        let generator = JSONDataGenerator()
        let jsonData =  generator(date: Date())
        XCTAssertNil(jsonData)
    }
    
    func testURLQueryItemsGenerator()  {
        let generator = URLQueryItemsGenerator()
        let queryItems =  generator(string_value: "string",
                                    null_value: nil)
        XCTAssertTrue(queryItems.contains(URLQueryItem(name: "string_value", value: "string")))
        XCTAssertTrue(queryItems.contains(URLQueryItem(name: "null_value", value: nil)))
        XCTAssertFalse(queryItems.contains(URLQueryItem(name: "undefined_value", value: nil)))
    }
    
    static var allTests = [
        ("testJson", testJson),
        ("testJsonThrow", testJsonThrow),
        ("testJSONDataGenerator", testJSONDataGenerator),
        ("testJSONDataGeneratorWithDate", testJSONDataGeneratorWithDate),
        ("testURLQueryItemsGenerator", testURLQueryItemsGenerator),
    ]
}
