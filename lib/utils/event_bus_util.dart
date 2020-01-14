//Created by 1vPy on 2019/10/24.
import 'package:event_bus/event_bus.dart';

class EventBusUtil {

  EventBus eventBus;

  static EventBusUtil instance = EventBusUtil.internal();

  EventBusUtil.internal(){
    eventBus = EventBus();
  }
}