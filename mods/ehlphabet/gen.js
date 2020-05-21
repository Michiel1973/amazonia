var page = require('webpage').create();
var w = 64;  // 16,32,64
var h = 64;
var con = console;

//viewportSize being the actual size of the headless browser
page.viewportSize = { width: w, height: h };

//the clipRect is the portion of the page you are taking a screenshot of
page.clipRect = { top: 0, left: 0, width: w, height: h };

page.content = '<html><body><div id="character"></div></body></html>';

var chars = [
  // numbers
  "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
  // latin
  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
  "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
  // special chars
  "!", "#", "$", "%", "&", "(", ")", "*", "+", ",", "-", ".", "/", ":", ";",
  "<", "=", ">", "?", "@", '"', "'",
  // german
  "Ä", "Ö", "Ü", "ß",
  // cyrillic
  "А", "Б", "В", "Г", "Д", "Е", "Ё", "Ж", "З", "И", "Й", "К", "Л", "М", "Н",
  "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ъ", "Ы", "Ь",
  "Э", "Ю", "Я",
  // greek
  "Α", "Β", "Γ", "Δ", "Ε", "Ζ", "Η", "Θ", "Ι", "Κ", "Λ", "Μ", "Ν", "Ξ", "Ο",
  "Π", "Ρ", "Σ", "Τ", "Υ", "Φ", "Χ", "Ψ", "Ω",
  // 
  "猫" , //  neko
  "北", //   (North, U+5317), pronounced běi
  "东", //   (East, Simplified, U+4E1C), pronounced dōng
  "東", //   (East, Traditional, U+6771), pronounced dōng
  "南", //   (South, U+5357), pronounced nán
  "西", //   (West, U+897F), pronounced xī
  "站", //   (Station, U+7AD9  )
];

function encode_utf8(s) {
  return unescape(encodeURIComponent(s));
}

function decode_utf8(s) {
  return decodeURIComponent(escape(s));
}

function pad(n, width, z) {
  z = z || '0';
  n = n + '';
  return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}

page.evaluate(function () {
  var chEl = document.getElementById('character');

  document.body.style.backgroundColor = 'white';
  document.body.style.margin = '0px';
//  chEl.style.fontSize = '12px';    // 16
//  chEl.style.fontSize = '24px';  // 32
  chEl.style.fontSize = '48px';    // 64
  chEl.style.fontWeight = 'bold';
//  chEl.style.marginTop = '1px';     // 16
//  chEl.style.marginTop = '2px';   // 32
  chEl.style.marginTop = '4px';     // 64
  chEl.style.textAlign = 'center';
});

page.render('textures/ehlphabet_000.png');

chars.forEach(function (ch) {
  var file;
  page.evaluate(function (ch) {
    var chEl = document.getElementById('character');
    chEl.innerText = ch;
  }, ch);

  ch = encode_utf8(ch);
  if (ch.length > 1) {
    file = pad(ch.charCodeAt(0), 3) + '_' + pad(ch.charCodeAt(1), 3);
  } else  {
    file = pad(ch.charCodeAt(0), 3);
  }

  page.render('textures/ehlphabet_' + file + '.png');
});

console.log('done');

phantom.exit();
