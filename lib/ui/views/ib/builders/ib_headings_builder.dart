import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:mobile_app/services/ib_engine_service.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class IbHeadingsBuilder extends MarkdownElementBuilder {
  final Map<String, int> slugMap;
  final AutoScrollController controller;
  final bool selectable;
  var index = 0;

  IbHeadingsBuilder({this.slugMap, this.controller, this.selectable = true});

  @override
  Widget visitElementAfter(md.Element element, TextStyle preferredStyle) {
    var text = element.textContent;

    var widget = selectable
        ? SelectableText(
            text,
            style: preferredStyle,
          )
        : Text(
            text,
            style: preferredStyle,
          );

    slugMap[IbEngineService.getSlug(text)] = index;

    return AutoScrollTag(
      key: ValueKey(index),
      controller: controller,
      index: index++,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: widget,
      ),
    );
  }
}
