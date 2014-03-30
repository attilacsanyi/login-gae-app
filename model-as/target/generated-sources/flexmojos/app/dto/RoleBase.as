/**
 * Generated by Gas3 v2.1.0 (Granite Data Services).
 *
 * WARNING: DO NOT CHANGE THIS FILE. IT MAY BE OVERRIDDEN EACH TIME YOU USE
 * THE GENERATOR. CHANGE INSTEAD THE INHERITED CLASS (Role.as).
 */

package app.dto {

import flash.events.EventDispatcher;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;
import mx.events.PropertyChangeEvent;

[Bindable]
[Event(name="propertyChange",type="mx.events.PropertyChangeEvent")]
public class RoleBase extends EventDispatcher {

private var _description:String;
private var _key:String;
private var _name:String;
public function RoleBase(){

}


public function set description(value:String):void {
            if(_description != value){
              var oldValue:String = _description;
              _description = value;
              dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "description", oldValue, value));
            }
        }
public function get description():String {
            return _description;
        }

public function set key(value:String):void {
            if(_key != value){
              var oldValue:String = _key;
              _key = value;
              dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "key", oldValue, value));
            }
        }
public function get key():String {
            return _key;
        }

public function set name(value:String):void {
            if(_name != value){
              var oldValue:String = _name;
              _name = value;
              dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "name", oldValue, value));
            }
        }
public function get name():String {
            return _name;
        }
override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
super.addEventListener(type, listener, useCapture, priority, useWeakReference);

}



public function readExternal(input:IDataInput):void {
_description = input.readObject() as String;
_key = input.readObject() as String;
_name = input.readObject() as String;
}

public function writeExternal(output:IDataOutput):void {
output.writeObject(_description);
output.writeObject(_key);
output.writeObject(_name);
}
    }
}