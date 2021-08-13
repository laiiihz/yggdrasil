import 'package:postgres/postgres.dart';
import 'package:redis/redis.dart';

import 'hive_util.dart';

class DB {
  static final _connection = RedisConnection();
  static late Command command;
  static late PostgreSQLConnection connection;
  static Future connect() async {
    command = await _connection.connect('localhost', 6379);
    connection = PostgreSQLConnection(
      'localhost',
      5432,
      'yggdrasil',
      username: 'laiiihz',
      password: 'ybtizPgkOi1tXzbXjq6AD2lP82LRFnYu',
    );
    await connection.open();
    if (HiveUtil.configBox.get('initDB') ?? true) {
      await HiveUtil.configBox.put('initDB', false);
      await connection.execute('''create table user_t
(
    uuid     varchar(36) not null
        constraint user_t_pk
            primary key,
    phone    varchar(13),
    nickname text,
    email    text,
    password text        not null,
    role     text        not null
);

alter table user_t
    owner to laiiihz;

create unique index user_t_uuid_uindex
    on user_t (uuid);

create unique index user_t_phone_uindex
    on user_t (phone);


''');
      await connection.execute('''create table apk_t
(
    uuid               text not null
        constraint apk_t_pk
            primary key,
    name               text,
    "versionCode"      text,
    "versionName"      text,
    "sdkVersion"       text,
    "targetSdkVersion" text,
    "usesPermission"   text[]
);

alter table apk_t
    owner to laiiihz;

create unique index apk_t_uuid_uindex
    on apk_t (uuid);

''');
    }
  }
}
