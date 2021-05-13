Future<void> main() async {
  var s = makeNums(10);
  var v = await sum(s);
  print('Sum: $v');
}

Future<int> sum(Stream<int> nums) async {
  var v = 0;
  await for (var i in nums) {
    v += i;
  }

  // await nums.forEach((i) {
  //   v += i;
  // });
  return v;
}

Stream<int> makeNums(int n) {
  var l = List<int>.generate(n, (index) => index);
  return Stream.fromIterable(l);
}
