!function a(b,c,d){function e(g,h){if(!c[g]){if(!b[g]){var i="function"==typeof require&&require;if(!h&&i)return i(g,!0);if(f)return f(g,!0);throw new Error("Cannot find module '"+g+"'")}var j=c[g]={exports:{}};b[g][0].call(j.exports,function(a){var c=b[g][1][a];return e(c?c:a)},j,j.exports,a,b,c,d)}return c[g].exports}for(var f="function"==typeof require&&require,g=0;g<d.length;g++)e(d[g]);return e}({1:[function(a,b){var c,d,e,f,g,h,i,j,k,l,m,n;b.exports=c=function(){function a(a,b){this.url=a,this.byteData=b,this.name=this.url.split("/").pop(),this.palette=null,this.colorDepth=0,this.isGif=k.apply(this),this.isPng=l.apply(this),this.fileSize=d.apply(this),this.width=j.apply(this),this.height=f.apply(this),this.palette=g.apply(this),this.colorNum=n(this.palette).length}return a}(),n=function(a){var b,c,d,e;e=a.slice(0).sort(),c=[];for(b in e)d=e[b],(null==e[b-1]||e[b-1]!==d)&&c.push(d);return c},d=function(){return this.byteData.length},l=function(){var a;return a=this.byteData,a.length>24&&137===a[0]&&80===a[1]&&78===a[2]&&71===a[3]&&13===a[4]&&10===a[5]&&26===a[6]&&10===a[7]},k=function(){var a;return a=this.byteData,a.length>22&&71===a[0]&&73===a[1]&&70===a[2]},j=function(){var a,b;return a=this.byteData,b=0,l.apply(this)?(b+=a[16]<<24,b+=a[17]<<16,b+=a[18]<<8,b+=a[19]):k.apply(this)&&(b+=a[7]<<8,b+=a[6]),b},f=function(){var a,b;return b=this.byteData,a=0,l.apply(this)?(a+=b[20]<<24,a+=b[21]<<16,a+=b[22]<<8,a+=b[23]):k.apply(this)&&(a+=b[9]<<8,a+=b[8]),a},m=function(a){return(16>a?"0":"")+a.toString(16)},h=function(a,b,c){var d,e,f,g,h,i,j,k;if(i=Math.pow(2,b),c+3*i>a.length)return[];for(g=new Array(i),f=j=0,k=i-1;k>=0?k>=j:j>=k;f=k>=0?++j:--j)h=a[3*f+c],e=a[3*f+c+1],d=a[3*f+c+2],g[f]=m(h)+m(e)+m(d);return g},i=function(){var a,b,c;if(c=this.byteData,a=c[24],b=8,3!==c[25])return[];for(;b<c.length;){if(80===c[b+4]&&76===c[b+5]&&84===c[b+6]&&69===c[b+7]){b+=8;break}b+=12+(c[b]<<24)+(c[b+1]<<16)+(c[b+2]<<8)+c[b+3]}return this.colorDepth=a,h(c,a,b)},e=function(){var a,b,c,d;if(d=this.byteData,a=0,c=13,b=d[10]>>7&1,1===b)a=(7&d[10])+1;else for(;c<d.length;){if(44===d[c]){a=(7&d[c+9])+1,c+=10;break}if(33!==d[c])return[];if(249===d[c+1])c+=8;else if(254===d[c+1]){for(c+=2;0!==d[c];)c+=d[c]+1;c+=1}else if(1===d[c+1]){for(c+=15;0!==d[c];)c+=d[c]+1;c+=1}else{if(255!==d[c+1])return[];for(c+=14;0!==d[c];)c+=d[c]+1;c+=1}}return this.colorDepth=a,h(d,a,c)},g=function(){if(null!==this.palette)return this.palette;if(l.apply(this))return i.apply(this);if(k.apply(this))return e.apply(this);throw"File is not PNG or GIF.: "+this.url}},{}],2:[function(a,b){var c,d,e,f,g,h,i,j,k,l,m,n,o;d=a("./PixelUtil.coffee"),b.exports=c=function(){function a(a){this.url=a,this.bgcolor=0,this.zoomLevel=1,this.rotate=0,this.flipX=!1,this.flipY=!1,this.visible=!1}return a.prototype.show=function(a,b){return this.visible=!0,this.$tip?this.$tip.css({left:""+a+"px",top:""+b+"px"}).show():h.apply(this,[a,b])},a.prototype.hide=function(){return this.visible=!1,null!=this.$tip?this.$tip.hide():void 0},a}(),h=function(a,b){return this.$tip=$("<div class='pixelTip'></div>").css({position:"absolute"}).hide().hover(null,function(a){return function(){return a.hide()}}(this)).appendTo(document.body),this.$img=$("<img src='"+this.url+"'>").css({"background-color":f[0]}),d.load(this.url,function(c){return function(d){var f;return f=$("<div class='controll'>"+d.name+"</div>"),$('<button class="zoomIn" type="button">+</button>').click(function(){return n.apply(c)}).appendTo(f),$('<button class="zoomOut" type="button">-</button>').click(function(){return o.apply(c)}).appendTo(f),$('<button class="bgColor" type="button">[ ]</button>').click(function(){return g.apply(c)}).appendTo(f),$('<button class="flipX" type="button">↔</button>').click(function(){return j.apply(c)}).appendTo(f),$('<button class="flipY" type="button">↕</button>').click(function(){return k.apply(c)}).appendTo(f),$('<button class="rotate" type="button">↻</button>').click(function(){return l.apply(c)}).appendTo(f),c.$tip.append(f).append($('<div class="container"></div>').append(c.$img)).append($("<div class='info'>"+("<span class='width'>"+d.width+"</span>")+("<span class='height'>"+d.height+"</span>")+("<span class='size'>"+d.fileSize+"</span>")+("<span class='colorNum'>"+d.colorNum+"</span>")+("<span class='depth'>"+d.colorDepth+"</span></div>"))),e.apply(c,[c.$tip,d.palette]),c.baseWidth=c.$img.attr("width")||d.width,c.baseHeight=c.$img.attr("height")||d.height,m.apply(c),c.visible?c.show(a,b):void 0}}(this))},e=function(a,b){var c,d,e,f,h,i,j,k,l;if(0!==b.length){for(c=$('<div class="color">#000000</div>'),d=$("<table class='palette'></table>"),i=k=0;15>=k;i=++k){for(e=$("<tr></tr>"),j=function(a){return function(){var d;if(!(f>=b.length))return d="#"+b[f],$("<td></td>").css({"background-color":d}).mouseover(function(){return c.text(d).css({"border-color":d})}).click(function(){return g.apply(a,[d])}).appendTo(e)}}(this),h=l=0;15>=l;h=++l)f=h+16*i,j();e.children().size()&&d.append(e)}return a.append(d).append(c)}},f=["#FFF","#FCC","#CFC","#CCF","#F33","#3F3","#33F","#FF3","#3FF","#F3F","#000"],g=function(a){return a?this.bgcolor=-1:(this.bgcolor=(this.bgcolor+1)%f.length,a=f[this.bgcolor]),this.$img.css({"background-color":a})},n=function(){return this.zoomLevel<8&&(this.zoomLevel=2*this.zoomLevel),i.apply(this)},o=function(){return this.zoomLevel>1&&(this.zoomLevel=this.zoomLevel/2),i.apply(this)},i=function(){return this.$img.attr("width",""+this.baseWidth*this.zoomLevel+"px").attr("height",""+this.baseHeight*this.zoomLevel+"px"),m.apply(this)},j=function(){return this.flipX=!this.flipX,m.apply(this)},k=function(){return this.flipY=!this.flipY,m.apply(this)},l=function(){return this.rotate=(this.rotate+1)%4,m.apply(this)},m=function(){var a,b,c,d;return b=(this.baseWidth-this.baseHeight)*this.zoomLevel/2,c="",0!==this.rotate&&(c+=" rotate("+90*this.rotate+"deg)"),1===this.rotate&&(c+=" translate("+b+"px, 0px)"),3===this.rotate&&(c+=" translate("+-b+"px, 0px)"),this.flipX&&(c+=" rotateY(180deg)"),this.flipY&&(c+=" rotateX(180deg)"),this.$img.css({transform:c}),d=this.rotate%2===1?Math.max(this.baseHeight,this.baseWidth):this.baseWidth,a=this[this.rotate%2===1?"baseWidth":"baseHeight"],this.$img.parent().css({width:""+d*this.zoomLevel+"px",height:""+a*this.zoomLevel+"px"})}},{"./PixelUtil.coffee":3}],3:[function(a,b){var c;c=a("./PixelImage.coffee"),b.exports={load:function(a,b){var d;return d=new XMLHttpRequest,d.open("GET",a,!0),d.responseType="arraybuffer",d.onload=function(){return function(){var e,f;if(e=d.response,!e)throw"Couldn't load image: "+a;return f=new Uint8Array(e),b(new c(a,f))}}(this),d.send(null)}}},{"./PixelImage.coffee":1}],4:[function(a){null==window.PixelUtil&&(window.PixelUtil=a("./PixelUtil.coffee")),null==window.PixelTip&&(window.PixelTip=a("./PixelTip.coffee"))},{"./PixelTip.coffee":2,"./PixelUtil.coffee":3}]},{},[4]);