class Course {
  int _id;
  String _name;
  String _description;
  int _semester;
  int _credits;

  Course(this._name, this._semester, this._credits, [this._description]);
  Course.withId(this._id, this._name, this._semester, this._credits, [this._description]);

  int get id => _id;
  String get name => _name;
  String get description => _description;
  int get semester => _semester;
  int get credits => _credits;

  set semester (int semester) {    
      _semester = semester;
  }

  set name (String name) {    
      _name = name;
  }

  set description (String description) {
      _description = description;
  }
}
