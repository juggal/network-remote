import 'package:network_remote/utils/base_url.dart';
import 'package:web_socket_channel/io.dart';

class Connection {
  static IOWebSocketChannel channel;
  static get getChannel {
    return channel;
  }

  static set setChannel(String port) {
    if (Connection.channel == null) {
      Connection.channel = IOWebSocketChannel.connect(
        BaseUrl.getSocketUri((port)),
      );
      Connection.channel.stream.listen(
        null,
        onDone: () => print("closed"),
      );
    }
  }
}
