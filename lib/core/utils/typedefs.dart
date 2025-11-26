import 'package:todo/core/core.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
typedef DataList = List<DataMap>;
