part of 'hive_tableusages.dart';

class TableUsageAdapter extends TypeAdapter<TableUsage> {
  @override
  int get typeId => 1;

  @override
  TableUsage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return TableUsage(
      tablekey: fields[0] as String,
      tableinfo: fields[1] as String,
      tabledata: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TableUsage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tablekey)
      ..writeByte(1)
      ..write(obj.tableinfo)
      ..writeByte(2)
      ..write(obj.tabledata);
  }
}
