import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_buffers.dart';

class Mqtt {
  String server;//服务器地址;
  int port;//=端口号;
  String clientIdentifier;//=客户端标识;
  String subTopic;// = 需要订阅的topic;
  String publishTopic;//= 发送消息的topic;
  MqttQos qos = MqttQos.atLeastOnce;
  MqttClient mqttClient;
  static Mqtt _instance;

  Mqtt._(String server,int port,String clientIdentifier) {
    this.server=server;
    this.port=port;
    this.clientIdentifier=clientIdentifier;
    mqttClient = MqttServerClient.withPort(server, clientIdentifier,port);
    mqttClient.logging(on: false);///是否开启日志
    mqttClient.keepAlivePeriod = 20;///设置超时时间
   // mqttClient.instantiationCorrect=true;
    ///连接成功回调
    mqttClient.onConnected = _onConnected;

    ///连接断开回调
    mqttClient.onDisconnected = _onDisconnected();

    ///订阅成功回调
    mqttClient.onSubscribed = _onSubscribed;

    ///订阅失败回调
    mqttClient.onSubscribeFail = _onSubscribeFail;

  }

  static Mqtt getInstance(String server,int port,String clientIdentifier) {
    if (_instance == null) {
      _instance = Mqtt._(server,port,clientIdentifier);
    }
    return _instance;
  }
  ///连接
  connect() async{
    try {
      await mqttClient.connect(); ///开始连接
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      mqttClient.disconnect();
    }
    ///检查连接结果
    if (mqttClient.connectionStatus.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      print('EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${mqttClient.connectionStatus}');
      mqttClient.disconnect();
    }
    _log("connecting");
  }
  ///断开连接
  disconnect() {
    mqttClient.disconnect();
    _log("disconnect");
  }

  ///发布消息
  publishMessage(String msg,String topic) {
    ///int数组
    Uint8Buffer uint8buffer = Uint8Buffer();
    ///字符串转成int数组 (dart中没有byte) 类似于java的String.getBytes?
    var codeUnits = msg.codeUnits;
    print(codeUnits);
    //uint8buffer.add()
    uint8buffer.addAll(codeUnits);
    //print(uint8buffer);
    //final builder = MqttClientPayloadBuilder();
    //builder.addString(msg);
    //mqttClient.publishMessage(topic, qos, builder.payload);
    mqttClient.publishMessage(topic, qos, uint8buffer);
    print("publishMessage:"+msg);
  }
  subscribe(String topic){
    mqttClient.subscribe(topic, this.qos);
  }
  ///消息监听
  _onData(List<MqttReceivedMessage<MqttMessage>> data) {
    Uint8Buffer uint8buffer = Uint8Buffer();
    var messageStream = MqttByteBuffer(uint8buffer);
    data.forEach((MqttReceivedMessage<MqttMessage> m) {
      final MqttPublishMessage recMess = m.payload;

      final String pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      ///将数据写入到messageStream数组中
      m.payload.writeTo(messageStream);

    });
  }

  _onConnected() {
    _log("_onConnected");
    ///连接成功的时候订阅消息
   // mqttClient.subscribe(subTopic, qos);
  }

  _onDisconnected() {
    _log("_onDisconnect");
  }

  _onSubscribed(String topic) {
    _log("_onSubscribed");
    ///在订阅成功的时候注册消息监听
    mqttClient.updates.listen(_onData);
  }

  _onSubscribeFail(String topic) {
    _log("_onSubscribeFail");
  }


  _log(String msg) {
    print("MQTT-->$msg");
  }
}
