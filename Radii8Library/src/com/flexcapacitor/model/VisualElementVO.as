////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////




/**
 * Used for display in the Outline view
 * */
package com.flexcapacitor.model {
	
	import com.flexcapacitor.utils.InspectorUtils;
	
	import flash.display.DisplayObjectContainer;
	
	import mx.collections.ArrayCollection;

	public class VisualElementVO {

		public var id:String;
		public var name:String;
		public var type:String;
		public var superClass:String;
		public var element:Object;
		public var children:ArrayCollection;
		public var parent:DisplayObjectContainer;
		public var label:String;

		public function VisualElementVO() {

		}

		public static function unmarshall(element:*):VisualElementVO {
			var vo:VisualElementVO = new VisualElementVO();
			
			vo.id = 		InspectorUtils.getIdentifier(element);
			vo.name = 		InspectorUtils.getName(element);
			vo.type = 		InspectorUtils.getClassName(element);
			vo.superClass = InspectorUtils.getSuperClassName(element);
			vo.element = 	element;
			vo.label =		vo.type;
			
			// get vo.children manually

			return vo;
		}
	}
}