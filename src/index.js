// pull in desired CSS/SASS files
require( 'bootstrap/dist/css/bootstrap.css' );
require( './styles/app.less' );

// inject bundled Elm app into div#main
var Elm = require( './Main' );
Elm.Main.embed( document.getElementById( 'main' ) );
