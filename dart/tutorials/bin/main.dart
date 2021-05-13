Future<String> createOrderMessage() async {
  var order = await fetchUserOrder();
  return 'Your order: $order';
}

Future<String> fetchUserOrder() => Future.delayed(
      Duration(seconds: 1),
      () => 'Hello world',
    );

Future<void> main() async {
  print('before calling');
  var msg = await createOrderMessage();
  print('after calling');
  print(msg);
}
