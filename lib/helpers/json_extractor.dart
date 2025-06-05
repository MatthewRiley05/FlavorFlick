import 'dart:convert';

Map<String, dynamic> extractNextData(String html) {
  final match = RegExp(
    r'__NEXT_DATA__"\s*type="application/json">\s*(\{.+?\})\s*</script>',
    dotAll: true,
  ).firstMatch(html);
  if (match == null) throw Exception('__NEXT_DATA__ not found');
  return jsonDecode(match.group(1)!);
}
