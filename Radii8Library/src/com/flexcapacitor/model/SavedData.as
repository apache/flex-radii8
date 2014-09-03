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

package com.flexcapacitor.model {
	
	
	/**
	 * Class used to store projects, documents and resources
	 * */
	[RemoteClass(alias="SavedData")]
	public class SavedData implements ISavedData {
		
		public function SavedData() {
			modified = created = new Date().time;
		}
		
		
		private var _version:uint = 1;

		public function get version():uint {
			return _version;
		}

		public function set version(value:uint):void {
			_version = value;
		}
		
		public var saveCount:int;
		
		
		public var created:uint;
		public var modified:uint;
		private var _modifiedValue:uint;

		public function get modifiedValue():uint {
			return _modifiedValue;
		}

		public function set modifiedValue(value:uint):void {
			_modifiedValue = value;
		}

		
		public var workspaces:Array = [];
		
		public var projects:Array = [];
		
		public var documents:Array = [];
		
		public var resources:Array = [];
		
		
		
		public function unmarshall(data:Object):void {
			
			
			
		}
	}
}