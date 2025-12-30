import 'package:flutter/material.dart';

class JumpThirdAppPage extends StatefulWidget {
  const JumpThirdAppPage({super.key});

  @override
  State<JumpThirdAppPage> createState() => _JumpThirdAppPageState();
}

class _JumpThirdAppPageState extends State<JumpThirdAppPage> {
  Future<bool> _open(BuildContext context, Uri uri) async {
    // if (!await canLaunchUrl(uri)) {
    //   ToastUtil.show("无法启动URLSchemes");
    //   return false;
    // }
    // if (!await launchUrl(uri)) {
    //   ToastUtil.show("启动URLSchemes失败");
    //   return false;
    // }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('常用URLSchemes')),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            TextButton(
              child: const Text('百度地图'),
              onPressed: () {
                Uri uri = Uri.parse('baidumap://');
                _open(context, uri);
              },
            ),
            TextButton(
              child: const Text('微信'),
              onPressed: () {
                Uri uri = Uri.parse('weixin://');
                _open(context, uri);
              },
            ),
            TextButton(
              child: const Text('支付宝'),
              onPressed: () {
                Uri uri = Uri.parse('alipays://');
                _open(context, uri);
              },
            ),
            TextButton(
              child: const Text('QQ'),
              onPressed: () {
                Uri uri = Uri.parse('mqq://');
                _open(context, uri);
              },
            ),
            TextButton(
              child: const Text('企业微信'),
              onPressed: () {
                Uri uri = Uri.parse('wxwork://');
                _open(context, uri);
              },
            ),
            TextButton(
              child: const Text('抖音'),
              onPressed: () {
                Uri uri = Uri.parse('awemesso://');
                _open(context, uri);
              },
            ),
            TextButton(
              child: const Text('高德地图'),
              onPressed: () {
                Uri uri = Uri.parse('iosamap://');
                _open(context, uri);
              },
            ),
            TextButton(
              child: const Text('微信小程序*需相关开发配合'),
              onPressed: () {
                Uri uri = Uri.parse('weixin://dl/business/?t= *TICKET*');
                _open(context, uri);
              },
            ),
            TextButton(
              child: const Text('微信扫码*ios能用'),
              onPressed: () {
                Uri uri = Uri.parse('weixin://scanqrcode');
                _open(context, uri);
              },
            ),
            TextButton(
              child: const Text('支付宝扫码'),
              onPressed: () {
                Uri uri = Uri.parse(
                  'alipays://platformapi/startapp?saId=10000007',
                );
                _open(context, uri);
              },
            ),
            TextButton(
              child: const Text('蚂蚁森林'),
              onPressed: () {
                Uri uri = Uri.parse(
                  'alipays://platformapi/startapp?saId=60000002',
                );
                _open(context, uri);
              },
            ),
            const SizedBox(),
          ],
        ).toList(),
      ),
    );
  }
}
