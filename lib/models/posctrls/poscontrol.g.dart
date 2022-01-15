part of 'poscontrol.dart';

class PosControlAdapter extends TypeAdapter<PosControl> {
  @override
  int get typeId => 2;

  @override
  PosControl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return PosControl(
      posctrlkey: fields[0] as String,
      posctrlinfo: fields[1] as String,
      posctrldata: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PosControl obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.posctrlkey)
      ..writeByte(1)
      ..write(obj.posctrlinfo)
      ..writeByte(2)
      ..write(obj.posctrldata);
  }
}
