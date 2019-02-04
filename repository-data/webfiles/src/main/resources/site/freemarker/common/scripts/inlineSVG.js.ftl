<#ftl output_format="HTML">

<#--  https://github.com/jonnyhaynes/inline-svg  -->

<script>
    // plugin library
    !function(a,b){"function"==typeof define&&define.amd?define([],b(a)):"object"==typeof exports?module.exports=b(a):a.inlineSVG=b(a)}("undefined"!=typeof global?global:this.window||this.global,function(a){var b,c={},d=!!document.querySelector&&!!a.addEventListener,e={initClass:"js-inlinesvg",svgSelector:"img.svg"},f=function(a,b){if(--a<1)return b.apply(this,arguments)},g=function(){var a={},b=!1,c=0,d=arguments.length;"[object Boolean]"===Object.prototype.toString.call(arguments[0])&&(b=arguments[0],c++);for(var e=function(c){for(var d in c)Object.prototype.hasOwnProperty.call(c,d)&&(b&&"[object Object]"===Object.prototype.toString.call(c[d])?a[d]=g(!0,a[d],c[d]):a[d]=c[d])};c<d;c++){e(arguments[c])}return a},h=function(){return document.querySelectorAll(b.svgSelector)},i=function(a){var c=h(),d=f(c.length,a);Array.prototype.forEach.call(c,function(a,c){var e=a.src||a.getAttribute("data-src"),f=a.attributes,g=new XMLHttpRequest;g.open("GET",e,!0),g.onload=function(){if(g.status>=200&&g.status<400){var c=new DOMParser,e=c.parseFromString(g.responseText,"text/xml"),h=e.getElementsByTagName("svg")[0];if(h.removeAttribute("xmlns:a"),h.removeAttribute("width"),h.removeAttribute("height"),h.removeAttribute("x"),h.removeAttribute("y"),h.removeAttribute("enable-background"),h.removeAttribute("xmlns:xlink"),h.removeAttribute("xml:space"),h.removeAttribute("version"),Array.prototype.slice.call(f).forEach(function(a){"src"!==a.name&&"alt"!==a.name&&h.setAttribute(a.name,a.value)}),h.classList?h.classList.add("inlined-svg"):h.className+=" inlined-svg",h.setAttribute("role","img"),f.longdesc){var i=document.createElementNS("http://www.w3.org/2000/svg","desc"),j=document.createTextNode(f.longdesc.value);i.appendChild(j),h.insertBefore(i,h.firstChild)}if(f.alt){h.setAttribute("aria-labelledby","title");var k=document.createElementNS("http://www.w3.org/2000/svg","title"),l=document.createTextNode(f.alt.value);k.appendChild(l),h.insertBefore(k,h.firstChild)}a.parentNode&&a.parentNode.replaceChild(h,a),d&&d(b.svgSelector)}else console.error("There was an error retrieving the source of the SVG.")},g.onerror=function(){console.error("There was an error connecting to the origin server.")},g.send()})};return c.init=function(a,c){d&&(b=g(e,a||{}),i(c||function(){}),document.documentElement.className+=" "+b.initClass)},c});

    // init plugin
    inlineSVG.init({
        svgSelector: '.infographic__img',
        initClass: 'js-inlinesvg'
    });
</script>
