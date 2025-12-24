import 'package:adscope_sdk/amps_sdk_export.dart';
import 'package:adscope_sdk_demo/data/common.dart';
import 'package:adscope_sdk_demo/widgets/button_widget.dart';
import 'package:flutter/material.dart';
class InterstitialShowPage extends StatefulWidget {
  const InterstitialShowPage({super.key, required this.title});

  final String title;

  @override
  State<InterstitialShowPage> createState() => _InterstitialShowPageState();
}

class _InterstitialShowPageState extends State<InterstitialShowPage> {
  late AdCallBack _adCallBack;
  AMPSInterstitialAd? _interAd;
  bool couldBack = true;
  num eCpm = 0;

  @override
  void initState() {
    super.initState();
    _adCallBack = AdCallBack(onRenderOk: () {
      // _interAd?.showAd();
      debugPrint("ad load onRenderOk");
    }, onLoadFailure: (code, msg) {
      debugPrint("ad load failure=$code;$msg");
    }, onAdClicked: () {
      setState(() {
        couldBack = true;
      });
      debugPrint("ad load onAdClicked");
    }, onAdClosed: () {
      setState(() {
        couldBack = true;
      });
      debugPrint("ad load onAdClosed");
    }, onAdShow: () {
      setState(() {
        couldBack = false;
      });
      debugPrint("ad load onAdShow");
    });

    AdOptions options = AdOptions(spaceId: interstitialSpaceId);
    _interAd = AMPSInterstitialAd(config: options, mCallBack: _adCallBack);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: couldBack,
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox.expand(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      const SizedBox(height: 30),
                      ButtonWidget(
                          buttonText: "加载插屏广告",
                          callBack: () {
                            AdOptions options =
                                AdOptions(spaceId: interstitialSpaceId);
                            _interAd = AMPSInterstitialAd(
                                config: options, mCallBack: _adCallBack);
                            _interAd?.load();
                          }),
                      const SizedBox(height: 10),
                      ButtonWidget(
                          buttonText: '获取竞价=$eCpm',
                          callBack: () async {
                            bool? isReadyAd = await _interAd?.isReadyAd();
                            debugPrint("isReadyAd=$isReadyAd");
                            if (_interAd != null) {
                              num ecPmResult = await _interAd!.getECPM();
                              debugPrint("ecPm请求结果=$eCpm");
                              setState(() {
                                eCpm = ecPmResult;
                              });
                            }
                          }),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          child: const Text('点击展示插屏'),
                          onPressed: () {
                            _interAd?.showAd();
                          })
                    ]))
              ],
            )));
  }
}
