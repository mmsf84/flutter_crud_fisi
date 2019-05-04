class Profesor {
  int _id;
  String _name;
  String _lastname;
  int _nivel;
  
  Profesor(this._name, this._lastname, this._nivel);
  Profesor.withId(this._id, this._name, this._lastname, this._nivel);

  int get id => _id;
  String get name => _name;
  String get lastname => _lastname;
  int get nivel => _nivel;

  set name (String name) {    
      _name = name;
  }

  set lastname (String lastname) {
      _lastname = lastname;
  }

  set nivel (int nivel) {    
      _nivel = nivel;
  }
}
