package com.wsd.xml
{
	class XMLParser
	{
		static public function xml2Object(baseNode:XML):Object {
		        var xmlObject:Object = new Object;
				/*
		        // attributes
		        var attribs:Object;
		        for (var attribName:String in baseNode.attributes) {
		                if (attribs == null)
		                        attribs = new Object;

		                attribs[attribName] = parseXMLValue(baseNode.attributes[attribName]);
		        }
		        if (attribs != null)
		                xmlObject["_attrib"] = attribs;

		        // children
		        for (var childNode:XMLNode = baseNode.firstChild; childNode != null; childNode = childNode.nextSibling) {
		                // if its a text node, store it and skip element parsing
		                if (childNode.nodeType == 3) {
		                        xmlObject["_text"] = parseXMLValue(childNode.nodeValue);
		                        continue;
		                }

		                // only care about elements from here on
		                if (childNode.nodeType != 1)
		                        continue;

		                // parse child element
		                var childObject:Object = xml2Object(childNode);

		                // no child exists with node's name yet
		                if (xmlObject[childNode.nodeName] == null)
		                        xmlObject[childNode.nodeName] = childObject;
		                else {
		                        // child with same name already exists, lets convert it to an array or push on the back if it already is one
		                        if (!(xmlObject[childNode.nodeName] instanceof Array)) {
		                                var existingObject:Object = xmlObject[childNode.nodeName];
		                                xmlObject[childNode.nodeName] = new Array();
		                                xmlObject[childNode.nodeName].push(existingObject);
		                        }
		                        xmlObject[childNode.nodeName].push(childObject);
		                }
		        }
				*/
				
				if (xml.hasSimpleContent()) {
					return parseXMLValue(xml)
				}
				
				for (var i in baseNode) {
					xmlObject[String(i.localName())] = xml2Object(baseNode[String(i.localName())])
				}
				
		        return xmlObject;
		}

		static public function parseXMLValue(value:String):Object {
		        if (parseFloat(value).toString() == value)
		                return parseFloat(value);
		        else if (value == "false")
		                return false;
		        else if (value == "true")
		                return true;
		        return value;
		}
	}
}