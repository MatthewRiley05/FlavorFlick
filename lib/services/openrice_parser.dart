import 'package:flavor_flick/services/bookmark_model.dart';
import 'package:html/parser.dart' as html;
import 'package:html/dom.dart';

List<BookmarkHtml> parseBookmarks(String rawHtml) {
  final doc = html.parse(rawHtml);

  return doc.querySelectorAll('div.poi').map(_bookmarkFromPoi).toList();
}

Element _firstOrEmpty(Element? parent, String sel) =>
    parent?.querySelector(sel) ?? Element.tag('span');

BookmarkHtml _bookmarkFromPoi(Element poi) {
  final info = poi.querySelector('.info')!;

  final street = _firstOrEmpty(
    info,
    '.content > div',
  ).text.replaceAll('\u00A0', ' ').trim();
  final district = _firstOrEmpty(info, '.content a.main_color2').text.trim();

  final address = district.isEmpty ? street : '$street, $district';

  final tags = info
      .querySelectorAll('.sprite-global-icon4 ~ .content a')
      .map((a) => a.text.trim())
      .toList();

  final price = _firstOrEmpty(
    info,
    '.sprite-global-icon6 ~ .content',
  ).text.trim();

  double rating = 0;
  final ratingDiv = poi.querySelector('.reviewScore > .FL.txt_bold.ML5');

  if (ratingDiv != null) {
    final txt = ratingDiv.text.replaceAll(RegExp(r'[^\d.]'), '').trim();
    rating = double.tryParse(txt) ?? 0;
  }

  String imageUrl = '';
  final imgStyle =
      poi.querySelector('.doorPhoto img')?.attributes['style'] ?? '';

  final match = RegExp(
    r'background-image:\s*url\(([^)]+)\)',
  ).firstMatch(imgStyle);

  if (match != null) {
    imageUrl = match.group(1)!;
    if (imageUrl.startsWith('//')) imageUrl = 'https:$imageUrl';
  }

  return BookmarkHtml(
    id: int.parse(poi.attributes['data-poiid']!),
    name: _firstOrEmpty(poi, '.title a').text.trim(),
    address: address,
    tags: tags,
    price: price,
    rating: rating,
    imageUrl: imageUrl,
  );
}
