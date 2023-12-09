class EventDetail {
  late String id; // Adding 'late' to indicate that it will be initialized later
  late String _description;
  late String _date;
  late String _startTime;
  late String _endTime;
  late String _speaker;
  late String _isFavorite;

  EventDetail(
    this.id,
    this._description,
    this._date,
    this._startTime,
    this._endTime,
    this._speaker,
    this._isFavorite,
  );

  String get description => _description;
  String get date => _date;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get speaker => _speaker;
  String get isFavorite => _isFavorite;

  EventDetail.fromMap(dynamic obj) {
    id = obj['id'] ?? ""; // Add a default value in case it's null
    _description = obj['description'] ?? "";
    _date = obj['date'] ?? "";
    _startTime = obj['start_time'] ?? "";
    _endTime = obj['end_time'] ?? "";
    _speaker = obj['speaker'] ?? "";
    _isFavorite = obj['is_favourite'] ?? "";
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id.isNotEmpty) {
      map['id'] = id;
    }
    map['description'] = _description;
    map['date'] = _date;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['speaker'] = _speaker;
    map['is_favourite'] = _isFavorite;
    return map;
  }
}
