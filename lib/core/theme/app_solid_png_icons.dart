import 'package:flutter/material.dart';

class AppSolidPngIcons {
  static Widget icon(String name, {double size = 24, Color? color}) {
    try {
      return Image.asset(
        'assets/icons/Solid/png/$name.png',
        width: size,
        height: size,
        color: color,
      );
    } catch (e) {
      return Icon(Icons.error, size: size, color: color);
    }
  }

  static Widget academicCap({double size = 24, Color? color}) =>
      icon('academic-cap', size: size, color: color);

  static Widget adjustments({double size = 24, Color? color}) =>
      icon('adjustments', size: size, color: color);

  static Widget annotation({double size = 24, Color? color}) =>
      icon('annotation', size: size, color: color);

  static Widget archive({double size = 24, Color? color}) =>
      icon('archive', size: size, color: color);

  static Widget arrowCircleDown({double size = 24, Color? color}) =>
      icon('arrow-circle-down', size: size, color: color);

  static Widget arrowCircleLeft({double size = 24, Color? color}) =>
      icon('arrow-circle-left', size: size, color: color);

  static Widget arrowCircleRight({double size = 24, Color? color}) =>
      icon('arrow-circle-right', size: size, color: color);

  static Widget arrowCircleUp({double size = 24, Color? color}) =>
      icon('arrow-circle-up', size: size, color: color);

  static Widget arrowDown({double size = 24, Color? color}) =>
      icon('arrow-down', size: size, color: color);

  static Widget arrowLeft({double size = 24, Color? color}) =>
      icon('arrow-left', size: size, color: color);

  static Widget arrowNarrowDown({double size = 24, Color? color}) =>
      icon('arrow-narrow-down', size: size, color: color);

  static Widget arrowNarrowLeft({double size = 24, Color? color}) =>
      icon('arrow-narrow-left', size: size, color: color);

  static Widget arrowNarrowRight({double size = 24, Color? color}) =>
      icon('arrow-narrow-right', size: size, color: color);

  static Widget arrowNarrowUp({double size = 24, Color? color}) =>
      icon('arrow-narrow-up', size: size, color: color);

  static Widget arrowRight({double size = 24, Color? color}) =>
      icon('arrow-right', size: size, color: color);

  static Widget arrowUp({double size = 24, Color? color}) =>
      icon('arrow-up', size: size, color: color);

  static Widget arrowsExpand({double size = 24, Color? color}) =>
      icon('arrows-expand', size: size, color: color);

  static Widget atSymbol({double size = 24, Color? color}) =>
      icon('at-symbol', size: size, color: color);

  static Widget backspace({double size = 24, Color? color}) =>
      icon('backspace', size: size, color: color);

  static Widget badgeCheck({double size = 24, Color? color}) =>
      icon('badge-check', size: size, color: color);

  static Widget ban({double size = 24, Color? color}) =>
      icon('ban', size: size, color: color);

  static Widget beaker({double size = 24, Color? color}) =>
      icon('beaker', size: size, color: color);

  static Widget bell({double size = 24, Color? color}) =>
      icon('bell', size: size, color: color);

  static Widget bookOpen({double size = 24, Color? color}) =>
      icon('book-open', size: size, color: color);

  static Widget bookmarkAlt({double size = 24, Color? color}) =>
      icon('bookmark-alt', size: size, color: color);

  static Widget bookmark({double size = 24, Color? color}) =>
      icon('bookmark', size: size, color: color);

  static Widget briefcase({double size = 24, Color? color}) =>
      icon('briefcase', size: size, color: color);

  static Widget cake({double size = 24, Color? color}) =>
      icon('cake', size: size, color: color);

  static Widget calendar({double size = 24, Color? color}) =>
      icon('calendar', size: size, color: color);

  static Widget camera({double size = 24, Color? color}) =>
      icon('camera', size: size, color: color);

  static Widget cash({double size = 24, Color? color}) =>
      icon('cash', size: size, color: color);

  static Widget chartBar({double size = 24, Color? color}) =>
      icon('chart-bar', size: size, color: color);

  static Widget chartPie({double size = 24, Color? color}) =>
      icon('chart-pie', size: size, color: color);

  static Widget chartSquareBar({double size = 24, Color? color}) =>
      icon('chart-square-bar', size: size, color: color);

  static Widget chatAlt({double size = 24, Color? color}) =>
      icon('chat-alt', size: size, color: color);

  static Widget chatAlt2({double size = 24, Color? color}) =>
      icon('chat-alt-2', size: size, color: color);

  static Widget chat({double size = 24, Color? color}) =>
      icon('chat', size: size, color: color);

  static Widget checkCircle({double size = 24, Color? color}) =>
      icon('check-circle', size: size, color: color);

  static Widget check({double size = 24, Color? color}) =>
      icon('check', size: size, color: color);

  static Widget chevronDoubleDown({double size = 24, Color? color}) =>
      icon('chevron-double-down', size: size, color: color);

  static Widget chevronDoubleLeft({double size = 24, Color? color}) =>
      icon('chevron-double-left', size: size, color: color);

  static Widget chevronDoubleRight({double size = 24, Color? color}) =>
      icon('chevron-double-right', size: size, color: color);

  static Widget chevronDoubleUp({double size = 24, Color? color}) =>
      icon('chevron-double-up', size: size, color: color);

  static Widget chevronDown({double size = 24, Color? color}) =>
      icon('chevron-down', size: size, color: color);

  static Widget chevronLeft({double size = 24, Color? color}) =>
      icon('chevron-left', size: size, color: color);

  static Widget chevronRight({double size = 24, Color? color}) =>
      icon('chevron-right', size: size, color: color);

  static Widget chevronUp({double size = 24, Color? color}) =>
      icon('chevron-up', size: size, color: color);

  static Widget chip({double size = 24, Color? color}) =>
      icon('chip', size: size, color: color);

  static Widget circle({double size = 24, Color? color}) =>
      icon('circle', size: size, color: color);

  static Widget clipboardCheck({double size = 24, Color? color}) =>
      icon('clipboard-check', size: size, color: color);

  static Widget clipboardCopy({double size = 24, Color? color}) =>
      icon('clipboard-copy', size: size, color: color);

  static Widget clipboardList({double size = 24, Color? color}) =>
      icon('clipboard-list', size: size, color: color);

  static Widget clipboard({double size = 24, Color? color}) =>
      icon('clipboard', size: size, color: color);

  static Widget clock({double size = 24, Color? color}) =>
      icon('clock', size: size, color: color);

  static Widget cloudDownload({double size = 24, Color? color}) =>
      icon('cloud-download', size: size, color: color);

  static Widget cloudUpload({double size = 24, Color? color}) =>
      icon('cloud-upload', size: size, color: color);

  static Widget cloud({double size = 24, Color? color}) =>
      icon('cloud', size: size, color: color);

  static Widget code({double size = 24, Color? color}) =>
      icon('code', size: size, color: color);

  static Widget cog({double size = 24, Color? color}) =>
      icon('cog', size: size, color: color);

  static Widget collection({double size = 24, Color? color}) =>
      icon('collection', size: size, color: color);

  static Widget colorSwatch({double size = 24, Color? color}) =>
      icon('color-swatch', size: size, color: color);

  static Widget creditCard({double size = 24, Color? color}) =>
      icon('credit-card', size: size, color: color);

  static Widget cubeTransparent({double size = 24, Color? color}) =>
      icon('cube-transparent', size: size, color: color);

  static Widget cube({double size = 24, Color? color}) =>
      icon('cube', size: size, color: color);

  static Widget currencyBangladeshi({double size = 24, Color? color}) =>
      icon('currency-bangladeshi', size: size, color: color);

  static Widget currencyDollar({double size = 24, Color? color}) =>
      icon('currency-dollar', size: size, color: color);

  static Widget currencyEuro({double size = 24, Color? color}) =>
      icon('currency-euro', size: size, color: color);

  static Widget currencyPound({double size = 24, Color? color}) =>
      icon('currency-pound', size: size, color: color);

  static Widget currencyRupee({double size = 24, Color? color}) =>
      icon('currency-rupee', size: size, color: color);

  static Widget currencyYen({double size = 24, Color? color}) =>
      icon('currency-yen', size: size, color: color);

  static Widget cursorClick({double size = 24, Color? color}) =>
      icon('cursor-click', size: size, color: color);

  static Widget database({double size = 24, Color? color}) =>
      icon('database', size: size, color: color);

  static Widget desktopComputer({double size = 24, Color? color}) =>
      icon('desktop-computer', size: size, color: color);

  static Widget deviceMobile({double size = 24, Color? color}) =>
      icon('device-mobile', size: size, color: color);

  static Widget deviceTablet({double size = 24, Color? color}) =>
      icon('device-tablet', size: size, color: color);

  static Widget documentAdd({double size = 24, Color? color}) =>
      icon('document-add', size: size, color: color);

  static Widget documentDownload({double size = 24, Color? color}) =>
      icon('document-download', size: size, color: color);

  static Widget documentDuplicate({double size = 24, Color? color}) =>
      icon('document-duplicate', size: size, color: color);

  static Widget documentRemove({double size = 24, Color? color}) =>
      icon('document-remove', size: size, color: color);

  static Widget documentReport({double size = 24, Color? color}) =>
      icon('document-report', size: size, color: color);

  static Widget documentSearch({double size = 24, Color? color}) =>
      icon('document-search', size: size, color: color);

  static Widget documentText({double size = 24, Color? color}) =>
      icon('document-text', size: size, color: color);

  static Widget document({double size = 24, Color? color}) =>
      icon('document', size: size, color: color);

  static Widget dotsCircleHorizontal({double size = 24, Color? color}) =>
      icon('dots-circle-horizontal', size: size, color: color);

  static Widget dotsHorizontal({double size = 24, Color? color}) =>
      icon('dots-horizontal', size: size, color: color);

  static Widget dotsVertical({double size = 24, Color? color}) =>
      icon('dots-vertical', size: size, color: color);

  static Widget download({double size = 24, Color? color}) =>
      icon('download', size: size, color: color);

  static Widget duplicate({double size = 24, Color? color}) =>
      icon('duplicate', size: size, color: color);

  static Widget emojiHappy({double size = 24, Color? color}) =>
      icon('emoji-happy', size: size, color: color);

  static Widget emojiSad({double size = 24, Color? color}) =>
      icon('emoji-sad', size: size, color: color);

  static Widget exclamationCircle({double size = 24, Color? color}) =>
      icon('exclamation-circle', size: size, color: color);

  static Widget exclamation({double size = 24, Color? color}) =>
      icon('exclamation', size: size, color: color);

  static Widget externalLink({double size = 24, Color? color}) =>
      icon('external-link', size: size, color: color);

  static Widget eyeOff({double size = 24, Color? color}) =>
      icon('eye-off', size: size, color: color);

  static Widget eye({double size = 24, Color? color}) =>
      icon('eye', size: size, color: color);

  static Widget fastForward({double size = 24, Color? color}) =>
      icon('fast-forward', size: size, color: color);

  static Widget film({double size = 24, Color? color}) =>
      icon('film', size: size, color: color);

  static Widget filter({double size = 24, Color? color}) =>
      icon('filter', size: size, color: color);

  static Widget fingerPrint({double size = 24, Color? color}) =>
      icon('finger-print', size: size, color: color);

  static Widget fire({double size = 24, Color? color}) =>
      icon('fire', size: size, color: color);

  static Widget flag({double size = 24, Color? color}) =>
      icon('flag', size: size, color: color);

  static Widget folderAdd({double size = 24, Color? color}) =>
      icon('folder-add', size: size, color: color);

  static Widget folderDownload({double size = 24, Color? color}) =>
      icon('folder-download', size: size, color: color);

  static Widget folderOpen({double size = 24, Color? color}) =>
      icon('folder-open', size: size, color: color);

  static Widget folderRemove({double size = 24, Color? color}) =>
      icon('folder-remove', size: size, color: color);

  static Widget folder({double size = 24, Color? color}) =>
      icon('folder', size: size, color: color);

  static Widget gift({double size = 24, Color? color}) =>
      icon('gift', size: size, color: color);

  static Widget globeAlt({double size = 24, Color? color}) =>
      icon('globe-alt', size: size, color: color);

  static Widget globe({double size = 24, Color? color}) =>
      icon('globe', size: size, color: color);

  static Widget hand({double size = 24, Color? color}) =>
      icon('hand', size: size, color: color);

  static Widget hashtag({double size = 24, Color? color}) =>
      icon('hashtag', size: size, color: color);

  static Widget heart({double size = 24, Color? color}) =>
      icon('heart', size: size, color: color);

  static Widget home({double size = 24, Color? color}) =>
      icon('home', size: size, color: color);

  static Widget identification({double size = 24, Color? color}) =>
      icon('identification', size: size, color: color);

  static Widget inboxIn({double size = 24, Color? color}) =>
      icon('inbox-in', size: size, color: color);

  static Widget inbox({double size = 24, Color? color}) =>
      icon('inbox', size: size, color: color);

  static Widget informationCircle({double size = 24, Color? color}) =>
      icon('information-circle', size: size, color: color);

  static Widget key({double size = 24, Color? color}) =>
      icon('key', size: size, color: color);

  static Widget library({double size = 24, Color? color}) =>
      icon('library', size: size, color: color);

  static Widget lightBulb({double size = 24, Color? color}) =>
      icon('light-bulb', size: size, color: color);

  static Widget lightningBolt({double size = 24, Color? color}) =>
      icon('lightning-bolt', size: size, color: color);

  static Widget link({double size = 24, Color? color}) =>
      icon('link', size: size, color: color);

  static Widget locationMarker({double size = 24, Color? color}) =>
      icon('location-marker', size: size, color: color);

  static Widget lockClosed({double size = 24, Color? color}) =>
      icon('lock-closed', size: size, color: color);

  static Widget lockOpen({double size = 24, Color? color}) =>
      icon('lock-open', size: size, color: color);

  static Widget login({double size = 24, Color? color}) =>
      icon('login', size: size, color: color);

  static Widget logout({double size = 24, Color? color}) =>
      icon('logout', size: size, color: color);

  static Widget mailOpen({double size = 24, Color? color}) =>
      icon('mail-open', size: size, color: color);

  static Widget mail({double size = 24, Color? color}) =>
      icon('mail', size: size, color: color);

  static Widget map({double size = 24, Color? color}) =>
      icon('map', size: size, color: color);

  static Widget menuAlt1({double size = 24, Color? color}) =>
      icon('menu-alt-1', size: size, color: color);

  static Widget menuAlt2({double size = 24, Color? color}) =>
      icon('menu-alt-2', size: size, color: color);

  static Widget menuAlt3({double size = 24, Color? color}) =>
      icon('menu-alt-3', size: size, color: color);

  static Widget menuAlt4({double size = 24, Color? color}) =>
      icon('menu-alt-4', size: size, color: color);

  static Widget menu({double size = 24, Color? color}) =>
      icon('menu', size: size, color: color);

  static Widget microphone({double size = 24, Color? color}) =>
      icon('microphone', size: size, color: color);

  static Widget minusCircle({double size = 24, Color? color}) =>
      icon('minus-circle', size: size, color: color);

  static Widget minusSm({double size = 24, Color? color}) =>
      icon('minus-sm', size: size, color: color);

  static Widget minus({double size = 24, Color? color}) =>
      icon('minus', size: size, color: color);

  static Widget moon({double size = 24, Color? color}) =>
      icon('moon', size: size, color: color);

  static Widget musicNote({double size = 24, Color? color}) =>
      icon('music-note', size: size, color: color);

  static Widget newspaper({double size = 24, Color? color}) =>
      icon('newspaper', size: size, color: color);

  static Widget officeBuilding({double size = 24, Color? color}) =>
      icon('office-building', size: size, color: color);

  static Widget paperAirplane({double size = 24, Color? color}) =>
      icon('paper-airplane', size: size, color: color);

  static Widget paperClip({double size = 24, Color? color}) =>
      icon('paper-clip', size: size, color: color);

  static Widget pause({double size = 24, Color? color}) =>
      icon('pause', size: size, color: color);

  static Widget pencilAlt({double size = 24, Color? color}) =>
      icon('pencil-alt', size: size, color: color);

  static Widget pencil({double size = 24, Color? color}) =>
      icon('pencil', size: size, color: color);

  static Widget phoneIncoming({double size = 24, Color? color}) =>
      icon('phone-incoming', size: size, color: color);

  static Widget phoneMissedCall({double size = 24, Color? color}) =>
      icon('phone-missed-call', size: size, color: color);

  static Widget phoneOutgoing({double size = 24, Color? color}) =>
      icon('phone-outgoing', size: size, color: color);

  static Widget phone({double size = 24, Color? color}) =>
      icon('phone', size: size, color: color);

  static Widget photograph({double size = 24, Color? color}) =>
      icon('photograph', size: size, color: color);

  static Widget play({double size = 24, Color? color}) =>
      icon('play', size: size, color: color);

  static Widget plusCircle({double size = 24, Color? color}) =>
      icon('plus-circle', size: size, color: color);

  static Widget plusSm({double size = 24, Color? color}) =>
      icon('plus-sm', size: size, color: color);

  static Widget plus({double size = 24, Color? color}) =>
      icon('plus', size: size, color: color);

  static Widget presentationChartBar({double size = 24, Color? color}) =>
      icon('presentation-chart-bar', size: size, color: color);

  static Widget presentationChartLine({double size = 24, Color? color}) =>
      icon('presentation-chart-line', size: size, color: color);

  static Widget printer({double size = 24, Color? color}) =>
      icon('printer', size: size, color: color);

  static Widget puzzle({double size = 24, Color? color}) =>
      icon('puzzle', size: size, color: color);

  static Widget profile({double size = 24, Color? color}) =>
      icon('profile', size: size, color: color);

  static Widget qrcode({double size = 24, Color? color}) =>
      icon('qrcode', size: size, color: color);

  static Widget questionMarkCircle({double size = 24, Color? color}) =>
      icon('question-mark-circle', size: size, color: color);

  static Widget receiptRefund({double size = 24, Color? color}) =>
      icon('receipt-refund', size: size, color: color);

  static Widget receiptTax({double size = 24, Color? color}) =>
      icon('receipt-tax', size: size, color: color);

  static Widget refresh({double size = 24, Color? color}) =>
      icon('refresh', size: size, color: color);

  static Widget reply({double size = 24, Color? color}) =>
      icon('reply', size: size, color: color);

  static Widget rewind({double size = 24, Color? color}) =>
      icon('rewind', size: size, color: color);

  static Widget rss({double size = 24, Color? color}) =>
      icon('rss', size: size, color: color);

  static Widget saveAs({double size = 24, Color? color}) =>
      icon('save-as', size: size, color: color);

  static Widget save({double size = 24, Color? color}) =>
      icon('save', size: size, color: color);

  static Widget scale({double size = 24, Color? color}) =>
      icon('scale', size: size, color: color);

  static Widget scissors({double size = 24, Color? color}) =>
      icon('scissors', size: size, color: color);

  static Widget searchCircle({double size = 24, Color? color}) =>
      icon('search-circle', size: size, color: color);

  static Widget search({double size = 24, Color? color}) =>
      icon('search', size: size, color: color);

  static Widget selector({double size = 24, Color? color}) =>
      icon('selector', size: size, color: color);

  static Widget server({double size = 24, Color? color}) =>
      icon('server', size: size, color: color);

  static Widget share({double size = 24, Color? color}) =>
      icon('share', size: size, color: color);

  static Widget shieldCheck({double size = 24, Color? color}) =>
      icon('shield-check', size: size, color: color);

  static Widget shieldExclamation({double size = 24, Color? color}) =>
      icon('shield-exclamation', size: size, color: color);

  static Widget shoppingBag({double size = 24, Color? color}) =>
      icon('shopping-bag', size: size, color: color);

  static Widget shoppingCart({double size = 24, Color? color}) =>
      icon('shopping-cart', size: size, color: color);

  static Widget sortAscending({double size = 24, Color? color}) =>
      icon('sort-ascending', size: size, color: color);

  static Widget sortDescending({double size = 24, Color? color}) =>
      icon('sort-descending', size: size, color: color);

  static Widget sparkles({double size = 24, Color? color}) =>
      icon('sparkles', size: size, color: color);

  static Widget speakerphone({double size = 24, Color? color}) =>
      icon('speakerphone', size: size, color: color);

  static Widget star({double size = 24, Color? color}) =>
      icon('star', size: size, color: color);

  static Widget statusOffline({double size = 24, Color? color}) =>
      icon('status-offline', size: size, color: color);

  static Widget statusOnline({double size = 24, Color? color}) =>
      icon('status-online', size: size, color: color);

  static Widget stop({double size = 24, Color? color}) =>
      icon('stop', size: size, color: color);

  static Widget sun({double size = 24, Color? color}) =>
      icon('sun', size: size, color: color);

  static Widget support({double size = 24, Color? color}) =>
      icon('support', size: size, color: color);

  static Widget switchHorizontal({double size = 24, Color? color}) =>
      icon('switch-horizontal', size: size, color: color);

  static Widget switchVertical({double size = 24, Color? color}) =>
      icon('switch-vertical', size: size, color: color);

  static Widget table({double size = 24, Color? color}) =>
      icon('table', size: size, color: color);

  static Widget tag({double size = 24, Color? color}) =>
      icon('tag', size: size, color: color);

  static Widget template({double size = 24, Color? color}) =>
      icon('template', size: size, color: color);

  static Widget terminal({double size = 24, Color? color}) =>
      icon('terminal', size: size, color: color);

  static Widget thumbDown({double size = 24, Color? color}) =>
      icon('thumb-down', size: size, color: color);

  static Widget thumbUp({double size = 24, Color? color}) =>
      icon('thumb-up', size: size, color: color);

  static Widget ticket({double size = 24, Color? color}) =>
      icon('ticket', size: size, color: color);

  static Widget translate({double size = 24, Color? color}) =>
      icon('translate', size: size, color: color);

  static Widget trash({double size = 24, Color? color}) =>
      icon('trash', size: size, color: color);

  static Widget trendingDown({double size = 24, Color? color}) =>
      icon('trending-down', size: size, color: color);

  static Widget trendingUp({double size = 24, Color? color}) =>
      icon('trending-up', size: size, color: color);

  static Widget truck({double size = 24, Color? color}) =>
      icon('truck', size: size, color: color);

  static Widget upload({double size = 24, Color? color}) =>
      icon('upload', size: size, color: color);

  static Widget userAdd({double size = 24, Color? color}) =>
      icon('user-add', size: size, color: color);

  static Widget userCircle({double size = 24, Color? color}) =>
      icon('user-circle', size: size, color: color);

  static Widget userGroup({double size = 24, Color? color}) =>
      icon('user-group', size: size, color: color);

  static Widget userRemove({double size = 24, Color? color}) =>
      icon('user-remove', size: size, color: color);

  static Widget user({double size = 24, Color? color}) =>
      icon('user', size: size, color: color);

  static Widget users({double size = 24, Color? color}) =>
      icon('users', size: size, color: color);

  static Widget variable({double size = 24, Color? color}) =>
      icon('variable', size: size, color: color);

  static Widget videoCamera({double size = 24, Color? color}) =>
      icon('video-camera', size: size, color: color);

  static Widget viewBoards({double size = 24, Color? color}) =>
      icon('view-boards', size: size, color: color);

  static Widget viewGridAdd({double size = 24, Color? color}) =>
      icon('view-grid-add', size: size, color: color);

  static Widget viewGrid({double size = 24, Color? color}) =>
      icon('view-grid', size: size, color: color);

  static Widget viewList({double size = 24, Color? color}) =>
      icon('view-list', size: size, color: color);

  static Widget volumeOff({double size = 24, Color? color}) =>
      icon('volume-off', size: size, color: color);

  static Widget volumeUp({double size = 24, Color? color}) =>
      icon('volume-up', size: size, color: color);

  static Widget wifi({double size = 24, Color? color}) =>
      icon('wifi', size: size, color: color);

  static Widget xCircle({double size = 24, Color? color}) =>
      icon('x-circle', size: size, color: color);

  static Widget x({double size = 24, Color? color}) =>
      icon('x', size: size, color: color);

  static Widget zoomIn({double size = 24, Color? color}) =>
      icon('zoom-in', size: size, color: color);

  static Widget zoomOut({double size = 24, Color? color}) =>
      icon('zoom-out', size: size, color: color);
  static Widget buylist({double size = 24, Color? color}) =>
      icon('buylist', size: size, color: color);

  static Widget heart1({double size = 24, Color? color}) =>
      icon('heart1', size: size, color: color);

  static Widget post({double size = 24, Color? color}) =>
      icon('post', size: size, color: color);

  static Widget route({double size = 24, Color? color}) =>
      icon('route', size: size, color: color);
}
