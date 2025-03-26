import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static Widget icon(String name, {double size = 24, Color? color}) {
    return SvgPicture.asset(
      'assets/icons/$name.svg',
      width: size,
      height: size,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

// 사용 예제

// // import 'package:flutter/material.dart';
// import 'app_icons.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text("Flutter Icons")),
//         body: Center(
//           child: AppIcons.icon('home', size: 48, color: Colors.blue),
//         ),
//       ),
//     );
//   }
// }

  // Define each icon as a static constant
  static Widget academicCap({double size = 24, Color? color}) =>
      icon('Outline/academic-cap', size: size, color: color);

  static Widget adjustments({double size = 24, Color? color}) =>
      icon('Outline/adjustments', size: size, color: color);

  static Widget annotation({double size = 24, Color? color}) =>
      icon('Outline/annotation', size: size, color: color);

  static Widget archive({double size = 24, Color? color}) =>
      icon('Outline/archive', size: size, color: color);

  static Widget arrowCircleDown({double size = 24, Color? color}) =>
      icon('Outline/arrow-circle-down', size: size, color: color);

  static Widget arrowCircleLeft({double size = 24, Color? color}) =>
      icon('Outline/arrow-circle-left', size: size, color: color);

  static Widget arrowCircleRight({double size = 24, Color? color}) =>
      icon('Outline/arrow-circle-right', size: size, color: color);

  static Widget arrowCircleUp({double size = 24, Color? color}) =>
      icon('Outline/arrow-circle-up', size: size, color: color);

  static Widget arrowDown({double size = 24, Color? color}) =>
      icon('Outline/arrow-down', size: size, color: color);

  static Widget arrowLeft({double size = 24, Color? color}) =>
      icon('Outline/arrow-left', size: size, color: color);

  static Widget arrowNarrowDown({double size = 24, Color? color}) =>
      icon('Outline/arrow-narrow-down', size: size, color: color);

  static Widget arrowNarrowLeft({double size = 24, Color? color}) =>
      icon('Outline/arrow-narrow-left', size: size, color: color);

  static Widget arrowNarrowRight({double size = 24, Color? color}) =>
      icon('Outline/arrow-narrow-right', size: size, color: color);

  static Widget arrowNarrowUp({double size = 24, Color? color}) =>
      icon('Outline/arrow-narrow-up', size: size, color: color);

  static Widget arrowRight({double size = 24, Color? color}) =>
      icon('Outline/arrow-right', size: size, color: color);

  static Widget arrowUp({double size = 24, Color? color}) =>
      icon('Outline/arrow-up', size: size, color: color);

  static Widget arrowsExpand({double size = 24, Color? color}) =>
      icon('Outline/arrows-expand', size: size, color: color);

  static Widget atSymbol({double size = 24, Color? color}) =>
      icon('Outline/at-symbol', size: size, color: color);

  static Widget backspace({double size = 24, Color? color}) =>
      icon('Outline/backspace', size: size, color: color);

  static Widget badgeCheck({double size = 24, Color? color}) =>
      icon('Outline/badge-check', size: size, color: color);

  static Widget ban({double size = 24, Color? color}) =>
      icon('Outline/ban', size: size, color: color);

  static Widget beaker({double size = 24, Color? color}) =>
      icon('Outline/beaker', size: size, color: color);

  static Widget bell({double size = 24, Color? color}) =>
      icon('Outline/bell', size: size, color: color);

  static Widget bookOpen({double size = 24, Color? color}) =>
      icon('Outline/book-open', size: size, color: color);

  static Widget bookmarkAlt({double size = 24, Color? color}) =>
      icon('Outline/bookmark-alt', size: size, color: color);

  static Widget bookmark({double size = 24, Color? color}) =>
      icon('Outline/bookmark', size: size, color: color);

  static Widget briefcase({double size = 24, Color? color}) =>
      icon('Outline/briefcase', size: size, color: color);

  static Widget cake({double size = 24, Color? color}) =>
      icon('Outline/cake', size: size, color: color);

  static Widget calculator({double size = 24, Color? color}) =>
      icon('Outline/calculator', size: size, color: color);

  static Widget calendar({double size = 24, Color? color}) =>
      icon('Outline/calendar', size: size, color: color);

  static Widget camera({double size = 24, Color? color}) =>
      icon('Outline/camera', size: size, color: color);

  static Widget cash({double size = 24, Color? color}) =>
      icon('Outline/cash', size: size, color: color);

  static Widget chartBar({double size = 24, Color? color}) =>
      icon('Outline/chart-bar', size: size, color: color);

  static Widget chartPie({double size = 24, Color? color}) =>
      icon('Outline/chart-pie', size: size, color: color);

  static Widget chatAlt2({double size = 24, Color? color}) =>
      icon('Outline/chat-alt-2', size: size, color: color);

  static Widget chatAlt({double size = 24, Color? color}) =>
      icon('Outline/chat-alt', size: size, color: color);

  static Widget chat({double size = 24, Color? color}) =>
      icon('Outline/chat', size: size, color: color);

  static Widget checkCircle({double size = 24, Color? color}) =>
      icon('Outline/check-circle', size: size, color: color);

  static Widget check({double size = 24, Color? color}) =>
      icon('Outline/check', size: size, color: color);

  static Widget chevronDoubleDown({double size = 24, Color? color}) =>
      icon('Outline/chevron-double-down', size: size, color: color);

  static Widget chevronDoubleLeft({double size = 24, Color? color}) =>
      icon('Outline/chevron-double-left', size: size, color: color);

  static Widget chevronDoubleRight({double size = 24, Color? color}) =>
      icon('Outline/chevron-double-right', size: size, color: color);

  static Widget chevronDoubleUp({double size = 24, Color? color}) =>
      icon('Outline/chevron-double-up', size: size, color: color);

  static Widget chevronDown({double size = 24, Color? color}) =>
      icon('Outline/chevron-down', size: size, color: color);

  static Widget chevronLeft({double size = 24, Color? color}) =>
      icon('Outline/chevron-left', size: size, color: color);

  static Widget chevronRight({double size = 24, Color? color}) =>
      icon('Outline/chevron-right', size: size, color: color);

  static Widget chevronUp({double size = 24, Color? color}) =>
      icon('Outline/chevron-up', size: size, color: color);

  static Widget chip({double size = 24, Color? color}) =>
      icon('Outline/chip', size: size, color: color);

  static Widget clipboardCheck({double size = 24, Color? color}) =>
      icon('Outline/clipboard-check', size: size, color: color);

  static Widget clipboardCopy({double size = 24, Color? color}) =>
      icon('Outline/clipboard-copy', size: size, color: color);

  static Widget clipboardList({double size = 24, Color? color}) =>
      icon('Outline/clipboard-list', size: size, color: color);

  static Widget clipboard({double size = 24, Color? color}) =>
      icon('Outline/clipboard', size: size, color: color);

  static Widget clock({double size = 24, Color? color}) =>
      icon('Outline/clock', size: size, color: color);

  static Widget cloudDownload({double size = 24, Color? color}) =>
      icon('Outline/cloud-download', size: size, color: color);

  static Widget cloudUpload({double size = 24, Color? color}) =>
      icon('Outline/cloud-upload', size: size, color: color);

  static Widget cloud({double size = 24, Color? color}) =>
      icon('Outline/cloud', size: size, color: color);

  static Widget code({double size = 24, Color? color}) =>
      icon('Outline/code', size: size, color: color);

  static Widget cog({double size = 24, Color? color}) =>
      icon('Outline/cog', size: size, color: color);

  static Widget collection({double size = 24, Color? color}) =>
      icon('Outline/collection', size: size, color: color);

  static Widget colorSwatch({double size = 24, Color? color}) =>
      icon('Outline/color-swatch', size: size, color: color);

  static Widget creditCard({double size = 24, Color? color}) =>
      icon('Outline/credit-card', size: size, color: color);

  static Widget cubeTransparent({double size = 24, Color? color}) =>
      icon('Outline/cube-transparent', size: size, color: color);

  static Widget cube({double size = 24, Color? color}) =>
      icon('Outline/cube', size: size, color: color);

  static Widget currencyDollar({double size = 24, Color? color}) =>
      icon('Outline/currency-dollar', size: size, color: color);

  static Widget currencyEuro({double size = 24, Color? color}) =>
      icon('Outline/currency-euro', size: size, color: color);

  static Widget currencyPound({double size = 24, Color? color}) =>
      icon('Outline/currency-pound', size: size, color: color);

  static Widget currencyRupee({double size = 24, Color? color}) =>
      icon('Outline/currency-rupee', size: size, color: color);

  static Widget currencyYen({double size = 24, Color? color}) =>
      icon('Outline/currency-yen', size: size, color: color);

  static Widget cursorClick({double size = 24, Color? color}) =>
      icon('Outline/cursor-click', size: size, color: color);

  static Widget database({double size = 24, Color? color}) =>
      icon('Outline/database', size: size, color: color);

  static Widget desktopComputer({double size = 24, Color? color}) =>
      icon('Outline/desktop-computer', size: size, color: color);

  static Widget deviceMobile({double size = 24, Color? color}) =>
      icon('Outline/device-mobile', size: size, color: color);

  static Widget deviceTablet({double size = 24, Color? color}) =>
      icon('Outline/device-tablet', size: size, color: color);

  static Widget documentAdd({double size = 24, Color? color}) =>
      icon('Outline/document-add', size: size, color: color);

  static Widget documentDownload({double size = 24, Color? color}) =>
      icon('Outline/document-download', size: size, color: color);

  static Widget documentDuplicate({double size = 24, Color? color}) =>
      icon('Outline/document-duplicate', size: size, color: color);

  static Widget documentRemove({double size = 24, Color? color}) =>
      icon('Outline/document-remove', size: size, color: color);

  static Widget documentReport({double size = 24, Color? color}) =>
      icon('Outline/document-report', size: size, color: color);

  static Widget documentSearch({double size = 24, Color? color}) =>
      icon('Outline/document-search', size: size, color: color);

  static Widget documentText({double size = 24, Color? color}) =>
      icon('Outline/document-text', size: size, color: color);

  static Widget document({double size = 24, Color? color}) =>
      icon('Outline/document', size: size, color: color);

  static Widget dotsCircleHorizontal({double size = 24, Color? color}) =>
      icon('Outline/dots-circle-horizontal', size: size, color: color);

  static Widget dotsHorizontal({double size = 24, Color? color}) =>
      icon('Outline/dots-horizontal', size: size, color: color);

  static Widget dotsVertical({double size = 24, Color? color}) =>
      icon('Outline/dots-vertical', size: size, color: color);

  static Widget download({double size = 24, Color? color}) =>
      icon('Outline/download', size: size, color: color);

  static Widget duplicate({double size = 24, Color? color}) =>
      icon('Outline/duplicate', size: size, color: color);

  static Widget emojiHappy({double size = 24, Color? color}) =>
      icon('Outline/emoji-happy', size: size, color: color);

  static Widget emojiSad({double size = 24, Color? color}) =>
      icon('Outline/emoji-sad', size: size, color: color);

  static Widget exclamationCircle({double size = 24, Color? color}) =>
      icon('Outline/exclamation-circle', size: size, color: color);

  static Widget exclamation({double size = 24, Color? color}) =>
      icon('Outline/exclamation', size: size, color: color);

  static Widget externalLink({double size = 24, Color? color}) =>
      icon('Outline/external-link', size: size, color: color);

  static Widget eyeOff({double size = 24, Color? color}) =>
      icon('Outline/eye-off', size: size, color: color);

  static Widget eye({double size = 24, Color? color}) =>
      icon('Outline/eye', size: size, color: color);

  static Widget fastForward({double size = 24, Color? color}) =>
      icon('Outline/fast-forward', size: size, color: color);

  static Widget film({double size = 24, Color? color}) =>
      icon('Outline/film', size: size, color: color);

  static Widget filter({double size = 24, Color? color}) =>
      icon('Outline/filter', size: size, color: color);

  static Widget fingerPrint({double size = 24, Color? color}) =>
      icon('Outline/finger-print', size: size, color: color);

  static Widget fire({double size = 24, Color? color}) =>
      icon('Outline/fire', size: size, color: color);

  static Widget flag({double size = 24, Color? color}) =>
      icon('Outline/flag', size: size, color: color);

  static Widget folderAdd({double size = 24, Color? color}) =>
      icon('Outline/folder-add', size: size, color: color);

  static Widget folderDownload({double size = 24, Color? color}) =>
      icon('Outline/folder-download', size: size, color: color);

  static Widget folderOpen({double size = 24, Color? color}) =>
      icon('Outline/folder-open', size: size, color: color);

  static Widget folderRemove({double size = 24, Color? color}) =>
      icon('Outline/folder-remove', size: size, color: color);

  static Widget folder({double size = 24, Color? color}) =>
      icon('Outline/folder', size: size, color: color);

  static Widget gift({double size = 24, Color? color}) =>
      icon('Outline/gift', size: size, color: color);

  static Widget globeAlt({double size = 24, Color? color}) =>
      icon('Outline/globe-alt', size: size, color: color);

  static Widget globe({double size = 24, Color? color}) =>
      icon('Outline/globe', size: size, color: color);

  static Widget hand({double size = 24, Color? color}) =>
      icon('Outline/hand', size: size, color: color);

  static Widget hashtag({double size = 24, Color? color}) =>
      icon('Outline/hashtag', size: size, color: color);

  static Widget heart({double size = 24, Color? color}) =>
      icon('Outline/heart', size: size, color: color);

  static Widget home({double size = 24, Color? color}) =>
      icon('Outline/home', size: size, color: color);

  static Widget inboxIn({double size = 24, Color? color}) =>
      icon('Outline/inbox-in', size: size, color: color);

  static Widget inbox({double size = 24, Color? color}) =>
      icon('Outline/inbox', size: size, color: color);

  static Widget informationCircle({double size = 24, Color? color}) =>
      icon('Outline/information-circle', size: size, color: color);

  static Widget key({double size = 24, Color? color}) =>
      icon('Outline/key', size: size, color: color);

  static Widget library({double size = 24, Color? color}) =>
      icon('Outline/library', size: size, color: color);

  static Widget lightBulb({double size = 24, Color? color}) =>
      icon('Outline/light-bulb', size: size, color: color);

  static Widget lightningBolt({double size = 24, Color? color}) =>
      icon('Outline/lightning-bolt', size: size, color: color);

  static Widget link({double size = 24, Color? color}) =>
      icon('Outline/link', size: size, color: color);

  static Widget locationMarker({double size = 24, Color? color}) =>
      icon('Outline/location-marker', size: size, color: color);

  static Widget lockClosed({double size = 24, Color? color}) =>
      icon('Outline/lock-closed', size: size, color: color);

  static Widget lockOpen({double size = 24, Color? color}) =>
      icon('Outline/lock-open', size: size, color: color);

  static Widget login({double size = 24, Color? color}) =>
      icon('Outline/login', size: size, color: color);

  static Widget logout({double size = 24, Color? color}) =>
      icon('Outline/logout', size: size, color: color);

  static Widget mailOpen({double size = 24, Color? color}) =>
      icon('Outline/mail-open', size: size, color: color);

  static Widget mail({double size = 24, Color? color}) =>
      icon('Outline/mail', size: size, color: color);

  static Widget map({double size = 24, Color? color}) =>
      icon('Outline/map', size: size, color: color);

  static Widget menuAlt1({double size = 24, Color? color}) =>
      icon('Outline/menu-alt-1', size: size, color: color);

  static Widget menuAlt2({double size = 24, Color? color}) =>
      icon('Outline/menu-alt-2', size: size, color: color);

  static Widget menuAlt3({double size = 24, Color? color}) =>
      icon('Outline/menu-alt-3', size: size, color: color);

  static Widget menuAlt4({double size = 24, Color? color}) =>
      icon('Outline/menu-alt-4', size: size, color: color);

  static Widget menu({double size = 24, Color? color}) =>
      icon('Outline/menu', size: size, color: color);

  static Widget microphone({double size = 24, Color? color}) =>
      icon('Outline/microphone', size: size, color: color);

  static Widget minusCircle({double size = 24, Color? color}) =>
      icon('Outline/minus-circle', size: size, color: color);

  static Widget minus({double size = 24, Color? color}) =>
      icon('Outline/minus', size: size, color: color);

  static Widget moon({double size = 24, Color? color}) =>
      icon('Outline/moon', size: size, color: color);

  static Widget musicNote({double size = 24, Color? color}) =>
      icon('Outline/music-note', size: size, color: color);

  static Widget newspaper({double size = 24, Color? color}) =>
      icon('Outline/newspaper', size: size, color: color);

  static Widget officeBuilding({double size = 24, Color? color}) =>
      icon('Outline/office-building', size: size, color: color);

  static Widget paperAirplane({double size = 24, Color? color}) =>
      icon('Outline/paper-airplane', size: size, color: color);

  static Widget paperClip({double size = 24, Color? color}) =>
      icon('Outline/paper-clip', size: size, color: color);

  static Widget pause({double size = 24, Color? color}) =>
      icon('Outline/pause', size: size, color: color);

  static Widget pencilAlt({double size = 24, Color? color}) =>
      icon('Outline/pencil-alt', size: size, color: color);

  static Widget pencil({double size = 24, Color? color}) =>
      icon('Outline/pencil', size: size, color: color);

  static Widget phoneIncoming({double size = 24, Color? color}) =>
      icon('Outline/phone-incoming', size: size, color: color);

  static Widget phoneMissedCall({double size = 24, Color? color}) =>
      icon('Outline/phone-missed-call', size: size, color: color);

  static Widget phoneOutgoing({double size = 24, Color? color}) =>
      icon('Outline/phone-outgoing', size: size, color: color);

  static Widget phone({double size = 24, Color? color}) =>
      icon('Outline/phone', size: size, color: color);

  static Widget photograph({double size = 24, Color? color}) =>
      icon('Outline/photograph', size: size, color: color);

  static Widget play({double size = 24, Color? color}) =>
      icon('Outline/play', size: size, color: color);

  static Widget plusCircle({double size = 24, Color? color}) =>
      icon('Outline/plus-circle', size: size, color: color);

  static Widget plus({double size = 24, Color? color}) =>
      icon('Outline/plus', size: size, color: color);

  static Widget presentationChartBar({double size = 24, Color? color}) =>
      icon('Outline/presentation-chart-bar', size: size, color: color);

  static Widget presentationChartLine({double size = 24, Color? color}) =>
      icon('Outline/presentation-chart-line', size: size, color: color);

  static Widget printer({double size = 24, Color? color}) =>
      icon('Outline/printer', size: size, color: color);

  static Widget puzzle({double size = 24, Color? color}) =>
      icon('Outline/puzzle', size: size, color: color);

  static Widget qrcode({double size = 24, Color? color}) =>
      icon('Outline/qrcode', size: size, color: color);

  static Widget questionMarkCircle({double size = 24, Color? color}) =>
      icon('Outline/question-mark-circle', size: size, color: color);

  static Widget receiptRefund({double size = 24, Color? color}) =>
      icon('Outline/receipt-refund', size: size, color: color);

  static Widget receiptTax({double size = 24, Color? color}) =>
      icon('Outline/receipt-tax', size: size, color: color);

  static Widget refresh({double size = 24, Color? color}) =>
      icon('Outline/refresh', size: size, color: color);

  static Widget reply({double size = 24, Color? color}) =>
      icon('Outline/reply', size: size, color: color);

  static Widget rewind({double size = 24, Color? color}) =>
      icon('Outline/rewind', size: size, color: color);

  static Widget rss({double size = 24, Color? color}) =>
      icon('Outline/rss', size: size, color: color);

  static Widget saveAs({double size = 24, Color? color}) =>
      icon('Outline/save-as', size: size, color: color);

  static Widget save({double size = 24, Color? color}) =>
      icon('Outline/save', size: size, color: color);

  static Widget scale({double size = 24, Color? color}) =>
      icon('Outline/scale', size: size, color: color);

  static Widget scissors({double size = 24, Color? color}) =>
      icon('Outline/scissors', size: size, color: color);

  static Widget searchCircle({double size = 24, Color? color}) =>
      icon('Outline/search-circle', size: size, color: color);

  static Widget search({double size = 24, Color? color}) =>
      icon('Outline/search', size: size, color: color);

  static Widget selector({double size = 24, Color? color}) =>
      icon('Outline/selector', size: size, color: color);

  static Widget server({double size = 24, Color? color}) =>
      icon('Outline/server', size: size, color: color);

  static Widget share({double size = 24, Color? color}) =>
      icon('Outline/share', size: size, color: color);

  static Widget shieldCheck({double size = 24, Color? color}) =>
      icon('Outline/shield-check', size: size, color: color);

  static Widget shieldExclamation({double size = 24, Color? color}) =>
      icon('Outline/shield-exclamation', size: size, color: color);

  static Widget shoppingBag({double size = 24, Color? color}) =>
      icon('Outline/shopping-bag', size: size, color: color);

  static Widget shoppingCart({double size = 24, Color? color}) =>
      icon('Outline/shopping-cart', size: size, color: color);

  static Widget sortAscending({double size = 24, Color? color}) =>
      icon('Outline/sort-ascending', size: size, color: color);

  static Widget sortDescending({double size = 24, Color? color}) =>
      icon('Outline/sort-descending', size: size, color: color);

  static Widget sparkles({double size = 24, Color? color}) =>
      icon('Outline/sparkles', size: size, color: color);

  static Widget speakerphone({double size = 24, Color? color}) =>
      icon('Outline/speakerphone', size: size, color: color);

  static Widget star({double size = 24, Color? color}) =>
      icon('Outline/star', size: size, color: color);

  static Widget statusOffline({double size = 24, Color? color}) =>
      icon('Outline/status-offline', size: size, color: color);

  static Widget statusOnline({double size = 24, Color? color}) =>
      icon('Outline/status-online', size: size, color: color);

  static Widget stop({double size = 24, Color? color}) =>
      icon('Outline/stop', size: size, color: color);

  static Widget sun({double size = 24, Color? color}) =>
      icon('Outline/sun', size: size, color: color);

  static Widget support({double size = 24, Color? color}) =>
      icon('Outline/support', size: size, color: color);

  static Widget switchHorizontal({double size = 24, Color? color}) =>
      icon('Outline/switch-horizontal', size: size, color: color);

  static Widget switchVertical({double size = 24, Color? color}) =>
      icon('Outline/switch-vertical', size: size, color: color);

  static Widget table({double size = 24, Color? color}) =>
      icon('Outline/table', size: size, color: color);

  static Widget tag({double size = 24, Color? color}) =>
      icon('Outline/tag', size: size, color: color);

  static Widget template({double size = 24, Color? color}) =>
      icon('Outline/template', size: size, color: color);

  static Widget terminal({double size = 24, Color? color}) =>
      icon('Outline/terminal', size: size, color: color);

  static Widget thumbDown({double size = 24, Color? color}) =>
      icon('Outline/thumb-down', size: size, color: color);

  static Widget thumbUp({double size = 24, Color? color}) =>
      icon('Outline/thumb-up', size: size, color: color);

  static Widget ticket({double size = 24, Color? color}) =>
      icon('Outline/ticket', size: size, color: color);

  static Widget translate({double size = 24, Color? color}) =>
      icon('Outline/translate', size: size, color: color);

  static Widget trash({double size = 24, Color? color}) =>
      icon('Outline/trash', size: size, color: color);

  static Widget trendingDown({double size = 24, Color? color}) =>
      icon('Outline/trending-down', size: size, color: color);

  static Widget trendingUp({double size = 24, Color? color}) =>
      icon('Outline/trending-up', size: size, color: color);

  static Widget truck({double size = 24, Color? color}) =>
      icon('Outline/truck', size: size, color: color);

  static Widget upload({double size = 24, Color? color}) =>
      icon('Outline/upload', size: size, color: color);

  static Widget userAdd({double size = 24, Color? color}) =>
      icon('Outline/user-add', size: size, color: color);

  static Widget userCircle({double size = 24, Color? color}) =>
      icon('Outline/user-circle', size: size, color: color);

  static Widget userGroup({double size = 24, Color? color}) =>
      icon('Outline/user-group', size: size, color: color);

  static Widget userRemove({double size = 24, Color? color}) =>
      icon('Outline/user-remove', size: size, color: color);

  static Widget user({double size = 24, Color? color}) =>
      icon('Outline/user', size: size, color: color);

  static Widget users({double size = 24, Color? color}) =>
      icon('Outline/users', size: size, color: color);

  static Widget variable({double size = 24, Color? color}) =>
      icon('Outline/variable', size: size, color: color);

  static Widget videoCamera({double size = 24, Color? color}) =>
      icon('Outline/video-camera', size: size, color: color);

  static Widget viewBoards({double size = 24, Color? color}) =>
      icon('Outline/view-boards', size: size, color: color);

  static Widget viewGridAdd({double size = 24, Color? color}) =>
      icon('Outline/view-grid-add', size: size, color: color);

  static Widget viewGrid({double size = 24, Color? color}) =>
      icon('Outline/view-grid', size: size, color: color);

  static Widget viewList({double size = 24, Color? color}) =>
      icon('Outline/view-list', size: size, color: color);

  static Widget volumeOff({double size = 24, Color? color}) =>
      icon('Outline/volume-off', size: size, color: color);

  static Widget volumeUp({double size = 24, Color? color}) =>
      icon('Outline/volume-up', size: size, color: color);

  static Widget wifi({double size = 24, Color? color}) =>
      icon('Outline/wifi', size: size, color: color);

  static Widget xCircle({double size = 24, Color? color}) =>
      icon('Outline/x-circle', size: size, color: color);

  static Widget x({double size = 24, Color? color}) =>
      icon('Outline/x', size: size, color: color);

  static Widget zoomIn({double size = 24, Color? color}) =>
      icon('Outline/zoom-in', size: size, color: color);

  static Widget zoomOut({double size = 24, Color? color}) =>
      icon('Outline/zoom-out', size: size, color: color);
}
