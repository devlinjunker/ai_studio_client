import 'package:api/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_studio_client/store/StudioState.dart';

class MovieProductionLog extends StatelessWidget {
  const MovieProductionLog({super.key});

  static const padding = 10.0;
  static const logHeaderSize = 18.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Container(
          padding:
              const EdgeInsets.symmetric(vertical: padding, horizontal: 25),
          child: Consumer<StudioState>(builder: (context, provider, child) {
            var logs = [];
            if (provider.currentMovie?.log != null &&
                provider.currentMovie!.log!.isNotEmpty) {
              logs = provider.currentMovie!.log!.reversed.map((log) {
                var children = [];
                if (log.log.oneOf.isType(String)) {
                  children.add(RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: log.log.oneOf.value.toString(),
                      )));
                } else if (log.log.oneOf.isType(Issue)) {
                  children.add(RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: (log.log.oneOf.value as Issue).headline,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      )));
                } else if (log.log.oneOf.isType(Scandal)) {
                  children.add(Row(
                    children: [
                      Image.network(
                          height: 100,
                          width: 100,
                          'http://localhost:3000/image?path=${(log.log.oneOf.value as Scandal).imagePath}'),
                      RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: (log.log.oneOf.value as Scandal).headline,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ))
                    ],
                  ));
                }

                return Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Flex(direction: Axis.vertical, children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            constraints: BoxConstraints(
                                maxWidth: viewportConstraints.maxWidth - 50),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: log.date,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  ...children
                                ])),
                        const Divider(
                          color: Colors.black,
                          height: 5,
                          indent: 30,
                          endIndent: 30,
                        )
                      ])),
                    ]);
              }).toList();
            }
            return Container(
                constraints:
                    BoxConstraints(maxWidth: viewportConstraints.maxWidth),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    RichText(
                        text: const TextSpan(
                      text: "Log",
                      style: TextStyle(
                          fontSize: logHeaderSize,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    )),
                  ]),
                  Container(
                      constraints: BoxConstraints(
                          maxHeight: viewportConstraints.maxHeight -
                              (padding * 2 + logHeaderSize + 3),
                          maxWidth: viewportConstraints.maxWidth),
                      child: ListView(children: [...logs]))
                ]));
          }));
    });
  }
}
