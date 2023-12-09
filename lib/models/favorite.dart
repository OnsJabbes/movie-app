class Favorite {
  String? _id;
  String? _eventId;
  String? _userId;

  Favorite(this._id, this._eventId, this._userId);

  Favorite.map(Map<String, dynamic> data) {
    this._id = data['id'];
    this._eventId = data['eventId'];
    this._userId = data['userId'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['eventId'] = _eventId;
    map['userId'] = _userId;
    return map;
  }
}
