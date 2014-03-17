Pixel-Tip
=====

## 概要

ブラウザでドット絵の情報を表示するためのライブラリです。
動作には別途jQueryが必要です。

### 利用イメージ

![利用例](http://manaten.net/wp-content/uploads/2014/03/pixel-tip.png)

## 利用方法

表示を行いたいサイトで pixel-tip.css と dpixel-tip.js を読み込み、表示のためのイベントハンドラを設定します。
これらのファイルのビルド済みのものは、本リポジトリのdstディレクトリ以下に有ります。

### 利用例
```html
<link rel="stylesheet" type="text/css" media="all" href="./pixel-tip.css" />
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type='text/javascript' src="./dpixel-tip.js"></script>
<script type='text/javascript'>
$(function() {
  var tips = [];
  $('img').each(function(_, img) {
    var $img = $(img);
    var tip = new PixelTip($img.attr('src'));
    tips.push(tip);
    $img.hover(function() {
      var pos = $img.offset();
      $.each(tips, function(_, v) { v.hide(); });
      tip.show(pos.left-10, pos.top-10);
    }, null);
  });
});
</script>
```

## ビルド

自身でビルドを行う場合、[Grunt](http://gruntjs.com/) と [Compass](http://compass-style.org/) が必要です。

```bash
# install node packages.
npm install

# not minify build.
grunt compile

# or minify build.
grunt compile-min
```
