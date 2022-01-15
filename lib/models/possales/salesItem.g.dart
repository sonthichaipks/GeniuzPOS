part of 'salesitem.dart';

class SalesItemAdapter extends TypeAdapter<SalesItem> {
  @override
  int get typeId => 0;

  @override
  SalesItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return SalesItem(
      saleskey: fields[0] as String,
      salesinfo: fields[1] as String,
      salesdata: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SalesItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.saleskey)
      ..writeByte(1)
      ..write(obj.salesinfo)
      ..writeByte(2)
      ..write(obj.salesdata);
  }
}
