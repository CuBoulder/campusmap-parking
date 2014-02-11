/*

OPEN STREETS
============

A TileMill map style for OpenStreetMap. For PostGIS databases created 
by osm2pgsql with a default style file, or style that is compatible 
with the default.

Use the included `configure.py` script to customize your database and
extent settings. See the README for more info.

<http://github.com/mapbox/open-streets-style>

*/

/* ==========style.mss========== */

/* ---- PALETTE ---- */

@water:     #c0d8ff;
@land:      #f4f6f0;
@forest:    #c7e6a8;
@agriculture:#f4f0e0;
@grass:     lighten(@forest,5);
@park:      lighten(@forest,10);
@beach:     #ffeec7;
@building:  darken(#e8e4e4,8);

/* ---- NATURAL & LANDUSE ---- */

Map { background-color: transparent; }

#world[zoom<6],
#shoreline_300[zoom>=6][zoom<10],
#processed_p[zoom>=10] {
  polygon-fill: @land;
}

#ne-lakes[zoom<6],
.water[zoom>5] {
  polygon-fill:@water;
  polygon-gamma:0.8;
}
.water-outline[zoom>11] {
  line-color:darken(@water,10);
  [zoom=12] { line-width:0.8; }
  [zoom=13] { line-width:1.2; }
  [zoom=14] { line-width:1.4; }
  [zoom=15] { line-width:1.6; }
  [zoom=16] { line-width:1.8; }
  [zoom>16] { line-width:2; }
}

.wetland[zoom>10] {
  polygon-pattern-file:url(./res/wetland-8.png);
  [zoom>13] { polygon-pattern-file:url(./res/wetland-16.png); }
  [zoom>15] { polygon-pattern-file:url(./res/wetland-32.png); }
  polygon-pattern-alignment: global;
}

.forest[zoom>6][size='huge'],
.forest[zoom>7][size='large'],
.forest[zoom>8][size='medium'],
.forest[zoom>9][size='small'] {
  /* At lower zoom levels forests are dense and distracting. 
     Ramp them in gradually. */
  [zoom=7] { polygon-fill:lighten(@forest,14); }
  [zoom=8] { polygon-fill:lighten(@forest,12); }
  [zoom=9] { polygon-fill:lighten(@forest,9); }
  [zoom=10]{ polygon-fill:lighten(@forest,6); }
  [zoom=11]{ polygon-fill:lighten(@forest,3); }
  [zoom>11] { polygon-fill:@forest; }
  /* These outlines create a slight faux-blur effect. */
  [zoom>14] {
    line-color:@forest;
    line-opacity:0.4;
    line-join:round; }
  [zoom=15] { line-width:1.6; }
  [zoom=16] { line-width:2.6; }
  [zoom=17] { line-width:3.6; }
  [zoom>=18] { line-width:4.6; }
  /* a second outline for addtional blur */
  ::xtra {
    [zoom>16] {
      line-color:@forest;
      line-opacity:0.2;
      line-join:round; }
    [zoom=17] { line-width:7; }
    [zoom>=18] { line-width:9; }
  }
}

.agriculture[zoom>9] {
  polygon-fill:@agriculture;
}

.beach[zoom>9] {
  polygon-fill:@beach;
}

.grass[zoom>9][size='huge'],
.grass[zoom>10][size='large'],
.grass[zoom>11][size='medium'],
.grass[zoom>12][size='small'] {
  /* lighten relative to forest ramping */
  [zoom=10]{ polygon-fill:lighten(@grass,6); }
  [zoom=11]{ polygon-fill:lighten(@grass,3); }
  polygon-fill:@grass;
}

.park[zoom>9] {
  polygon-fill:@park;
  [zoom>13] { line-color:darken(@park,20); }
  [zoom=14] { line-width:0.6; }
  [zoom=15] { line-width:0.8; }
  [zoom>15] { line-width:1.2; }
}

/* ---- CAMPUSES ---- */
/* Note that amenity=school, amenity=hospital, etc are ideally polygons of the
   *campus*, but are occasionally applied to the physical building instead. */
@campus: #ECF;
.campus[zoom>10] {
  polygon-opacity:0.2;
  polygon-fill:@campus;
  [zoom>12] {
    line-opacity:0.4;
    line-color:spin(darken(@campus,20),20);
  }
  [zoom=13] { line-width:0.3; }
  [zoom=14] { line-width:0.5; }
  [zoom=15] { line-width:0.7; }
  [zoom=16] { line-width:0.8; }
  [zoom=17] { line-width:0.9; }
  [zoom=18] { line-width:1.0; }
}

/* ---- BUILDINGS ---- */
/* Transparent buildings account for situations where routes go
   in or under them */
.building[zoom>10][zoom<17] {
  polygon-fill:@building;
  [zoom=11] { polygon-opacity:0.1; }
  [zoom=12] { polygon-opacity:0.2; }
  [zoom=13] { polygon-opacity:0.3; }
  [zoom>13] {
    polygon-opacity:0.4;
    line-color:darken(@building,5);
    line-width:0.2;
  }
  [zoom>15] {
    line-color:darken(@building,10);
    line-width:0.4;
  }
}
.building[zoom>=17] {
  building-fill:lighten(@building,4);
  building-fill-opacity: 0.8;
  building-height:1.2;
}

/* ==========borders.mss========== */
/* Using shapefiles from Natural Earth. */
/* TODO: Only use Natural Earth @ low zoom levels;
         style actual OSM borders further down... */
#ne-admin-0::glow[zoom>0] {
  line-opacity: 0.5;
  line-color: #6ff2ff;
  [zoom=1] { line-width:0.4 + 2; }
  [zoom=2] { line-width:0.6 + 2; }
  [zoom=3] { line-width:0.8 + 2; }
  [zoom=4] { line-width:1.0 + 2; }
  [zoom=5] { line-width:1.5 + 2; }
  [zoom>5] { line-width:2.0 + 2; }
}
#ne-admin-0[zoom>0] {
  line-opacity: 0.5;
  line-color: #437;
  [zoom=1] { line-width:0.4; }
  [zoom=2] { line-width:0.6; }
  [zoom=3] { line-width:0.8; }
  [zoom=4] { line-width:1.0; }
  [zoom=5] { line-width:1.5; }
  [zoom>5] { line-width:2.0; }
}

#ne-admin-1::glow[zoom>3] {
  line-opacity: 0.5;
  line-color: #6ff2ff;
  [zoom=5] { line-width:0.4 + 2; }
  [zoom=6] { line-width:0.6 + 2; }
  [zoom=7] { line-width:0.8 + 2; }
  [zoom=8] { line-width:1.0 + 2; }
  [zoom>8] { line-width:1.5 + 2; }
}
#ne-admin-1[zoom>4] {
  line-opacity: 0.5;
  line-color: #437;
  [zoom=5] { line-width:0.4; line-dasharray:2,1; }
  [zoom=6] { line-width:0.6; line-dasharray:3,1; }
  [zoom=7] { line-width:0.8; line-dasharray:5,2; }
  [zoom=8] { line-width:1.0; line-dasharray:8,2; }
  [zoom>8] { line-width:1.5; line-dasharray:10,2; }
}

/* ==========highway.mss========== */

/* ---- PALETTE ---- */

@motorway_fill: #a8bae0; /*#93b5d9;*/
@motorway_line: spin(darken(@motorway_fill,25),-10);
@trunk_fill:    #a7dea5;/*#fabd7d;*/
@trunk_line:    spin(darken(@trunk_fill,25),-10);
@primary_fill:  #fcf7bd;
@primary_line:  spin(darken(@primary_fill,25),-10);
@secondary_fill:@primary_fill;
@secondary_line:spin(darken(@secondary_fill,25),-10);
@road_fill:     #6ff2ff;
@road_line:     #bbb;
@access_fill:   @road_fill;
@access_line:   @road_line;
@track:         @road;
@footway:       #6B9;
@cycleway:      #69B;
@bridge:        rgba(64,64,64,0.66);
@rail:          #999;

/* ---- ROADS ---- */

/* Service/Access */
.route.line[highway='service'] {
  [zoom>12]{ line-color:@access_line; line-cap:square; line-join:round; }
  [zoom=13]{ line-width:0.2; line-opacity:0.4; }
  [zoom=14]{ line-width:0.4; line-opacity:0.6; }
  [zoom=15]{ line-width:1; line-opacity:0.8; }
  [zoom=16]{ line-width:1.6 + 2; }
  [zoom=17]{ line-width:4 + 2; }
  [zoom>17]{ line-width:7 + 3; }
}
.route.fill[highway='service'] {
  [zoom>15]{ line-color:@access_fill; line-cap:square; line-join:round; }
  [zoom=16]{ line-width:1.6; }
  [zoom=17]{ line-width:4; }
  [zoom>17]{ line-width:7; }
}

/* Motorway Links */
.route.line[highway='motorway_link'][tunnel='no'],
.route.tunnel[highway='motorway_link'] {
  [zoom>9] { line-color:@motorway_line; line-cap:round; line-join:round; }
  .tunnel[zoom>9] { line-dasharray:4,2; line-cap:butt; }
  .tunnel[zoom>13]{ line-dasharray:6,2; }
  [zoom=10]{ line-width:0.8; }
  [zoom=11]{ line-width:1; }
  [zoom=12]{ line-width:1.0 + 2; }
  [zoom=13]{ line-width:1.2 + 2; }
  [zoom=14]{ line-width:2 + 2; }
  [zoom=15]{ line-width:3.5 + 2; }
  [zoom=16]{ line-width:5 + 2.5; }
  [zoom=17]{ line-width:6 + 2.5; }
  [zoom>17]{ line-width:14 + 2.5; }
}
.route.bridge::b[highway='motorway_link'] {
  [zoom>9] { line-color:darken(@motorway_line,15); line-cap:butt; line-join:round; }
  [zoom=10]{ line-width:0.8 + 1; }
  [zoom=11]{ line-width:1; }
  [zoom=12]{ line-width:1.0 + 2; }
  [zoom=13]{ line-width:1.2 + 2; }
  [zoom=14]{ line-width:2 + 2; }
  [zoom=15]{ line-width:3.5 + 2; }
  [zoom=16]{ line-width:5 + 2.5; }
  [zoom=17]{ line-width:6 + 2.5; }
  [zoom>17]{ line-width:14 + 2.5; }
}
.route.fill[highway='motorway_link'] {
  [zoom>11]{ line-color:@motorway_fill; line-cap:round; line-join:round; }
  [zoom>11][tunnel='yes'] { line-color:lighten(@motorway_fill,10); }
  /*[zoom=11]{ line-width:0.8; }*/
  [zoom=12]{ line-width:1.0; }
  [zoom=13]{ line-width:1.2; }
  [zoom=14]{ line-width:2; }
  [zoom=15]{ line-width:3.5; }
  [zoom=16]{ line-width:5; }
  [zoom=17]{ line-width:6; }
  [zoom>17]{ line-width:14; }
}

/* Trunk Links */
.route.line[highway='trunk_link'][tunnel='no'],
.route.tunnel[highway='trunk_link'] {
  [zoom>9] { line-color:@trunk_line; line-cap:round; line-join:round; }
  .tunnel[zoom>9] { line-dasharray:4,2; line-cap:butt; }
  .tunnel[zoom>13]{ line-dasharray:6,2; }
  [zoom=10]{ line-width:0.8; }
  [zoom=11]{ line-width:1; }
  [zoom=12]{ line-width:1.0 + 2; }
  [zoom=13]{ line-width:1.2 + 2; }
  [zoom=14]{ line-width:2 + 2; }
  [zoom=15]{ line-width:3.5 + 2; }
  [zoom=16]{ line-width:5 + 2.5; }
  [zoom=17]{ line-width:6 + 2.5; }
  [zoom>17]{ line-width:14 + 2.5; }
}
.route.bridge::b[highway='trunk_link'] {
  [zoom>9] { line-color:darken(@trunk_line,15); line-cap:butt; line-join:round; }
  [zoom=10]{ line-width:0.8 + 1; }
  [zoom=11]{ line-width:1; }
  [zoom=12]{ line-width:1.0 + 2; }
  [zoom=13]{ line-width:1.2 + 2; }
  [zoom=14]{ line-width:2 + 2; }
  [zoom=15]{ line-width:3.5 + 2; }
  [zoom=16]{ line-width:5 + 2.5; }
  [zoom=17]{ line-width:6 + 2.5; }
  [zoom>17]{ line-width:14 + 2.5; }
}
.route.fill[highway='trunk_link'] {
  [zoom>11]{ line-color:@trunk_fill; line-cap:round; line-join:round; }
  [zoom>11][tunnel='yes'] { line-color:lighten(@trunk_fill,10); }
  [zoom=12]{ line-width:1.0; }
  [zoom=13]{ line-width:1.2; }
  [zoom=14]{ line-width:2; }
  [zoom=15]{ line-width:3.5; }
  [zoom=16]{ line-width:5; }
  [zoom=17]{ line-width:6; }
  [zoom>17]{ line-width:14; }
}

/* Primary Links */
.route.line[highway='primary_link'][tunnel='no'],
.route.tunnel[highway='primary_link'] {
  [zoom>9] { line-color:@primary_line; line-cap:round; line-join:round; }
  .tunnel[zoom>9] { line-dasharray:4,2; line-cap:butt; }
  .tunnel[zoom>13]{ line-dasharray:6,2; }
  [zoom=10]{ line-width:0.8; }
  [zoom=11]{ line-width:1; }
  [zoom=12]{ line-width:1.0 + 2; }
  [zoom=13]{ line-width:1.2 + 2; }
  [zoom=14]{ line-width:2 + 2; }
  [zoom=15]{ line-width:3.5 + 2; }
  [zoom=16]{ line-width:5 + 2.5; }
  [zoom=17]{ line-width:6 + 2.5; }
  [zoom>17]{ line-width:14 + 2.5; }
}
.route.bridge::b[highway='primary_link'] {
  [zoom>9] { line-color:darken(@primary_line,15); line-cap:butt; line-join:round; }
  [zoom=10]{ line-width:0.8 + 1; }
  [zoom=11]{ line-width:1; }
  [zoom=12]{ line-width:1.0 + 2; }
  [zoom=13]{ line-width:1.2 + 2; }
  [zoom=14]{ line-width:2 + 2; }
  [zoom=15]{ line-width:3.5 + 2; }
  [zoom=16]{ line-width:5 + 2.5; }
  [zoom=17]{ line-width:6 + 2.5; }
  [zoom>17]{ line-width:14 + 2.5; }
}
.route.fill[highway='primary_link'] {
  [zoom>11]{ line-color:@primary_fill; line-cap:round; line-join:round; }
  [zoom>11][tunnel='yes'] { line-color:lighten(@primary_fill,10); }
  [zoom=12]{ line-width:1.0; }
  [zoom=13]{ line-width:1.2; }
  [zoom=14]{ line-width:2; }
  [zoom=15]{ line-width:3.5; }
  [zoom=16]{ line-width:5; }
  [zoom=17]{ line-width:6; }
  [zoom>17]{ line-width:14; }
}

/* Secondary Links */
.route.line[highway='secondary_link'][tunnel='no'],
.route.tunnel[highway='secondary_link'] {
  [zoom>9] { line-color:@secondary_line; line-cap:round; line-join:round; }
  .tunnel[zoom>9] { line-dasharray:4,2; line-cap:butt; }
  .tunnel[zoom>13]{ line-dasharray:6,2; }
  [zoom=10]{ line-width:0.6; }
  [zoom=11]{ line-width:0.8; }
  [zoom=12]{ line-width:0.9 + 1.8; }
  [zoom=13]{ line-width:1.0 + 2; }
  [zoom=14]{ line-width:2 + 2; }
  [zoom=15]{ line-width:3.5 + 2; }
  [zoom=16]{ line-width:5 + 2.5; }
  [zoom=17]{ line-width:6 + 2.5; }
  [zoom>17]{ line-width:14 + 2.5; }
}
.route.bridge::b[highway='secondary_link'] {
  [zoom>9] { line-color:darken(@secondary_line,15); line-cap:butt; line-join:round; }
  [zoom=10]{ line-width:0.6; }
  [zoom=11]{ line-width:0.8; }
  [zoom=12]{ line-width:0.9 + 1.8; }
  [zoom=13]{ line-width:1.0 + 2; }
  [zoom=14]{ line-width:2 + 2; }
  [zoom=15]{ line-width:3.5 + 2; }
  [zoom=16]{ line-width:5 + 2.5; }
  [zoom=17]{ line-width:6 + 2.5; }
  [zoom>17]{ line-width:14 + 2.5; }
}
.route.fill[highway='secondary_link'] {
  [zoom>11]{ line-color:@secondary_fill; line-cap:round; line-join:round; }
  [zoom>11][tunnel='yes'] { line-color:lighten(@secondary_fill,10); }
  [zoom=12]{ line-width:1.0; }
  [zoom=13]{ line-width:1.2; }
  [zoom=14]{ line-width:2; }
  [zoom=15]{ line-width:3.5; }
  [zoom=16]{ line-width:5; }
  [zoom=17]{ line-width:6; }
  [zoom>17]{ line-width:14; }
}

/* Standard/Unknown */
.route.line[highway='living_street'],
.route.line[highway='residential'],
.route.line[highway='road'],
.route.line[highway='tertiary'],
.route.line[highway='tertiary_link'],
.route.line[highway='unclassified'] {
  [zoom>9] { line-color:@road_line; line-cap:round; line-join:round; }
  [zoom=10]{ line-width:0.2; line-opacity:0.4; }
  [zoom=11]{ line-width:0.4; line-opacity:0.6; }
  [zoom=12]{ line-width:0.6; line-opacity:0.8; }
  [zoom=13]{ line-width:0.8; }
  [zoom=14]{ line-width:1.0 + 1.8; }
  [zoom=15]{ line-width:3.5 + 2; }
  [zoom=16]{ line-width:6 + 2; }
  [zoom=17]{ line-width:8 + 2; }
  [zoom>17]{ line-width:10 + 3; }
}
.route.bridge::b[highway='living_street'],
.route.bridge::b[highway='residential'],
.route.bridge::b[highway='road'],
.route.bridge::b[highway='tertiary'],
.route.bridge::b[highway='tertiary_link'],
.route.bridge::b[highway='unclassified'] {
  [zoom>9] { line-color:spin(darken(@road_line,15),-10); line-cap:butt; line-join:round; }
  [zoom=10]{ line-width:0.2 + 1; }
  [zoom=11]{ line-width:0.4 + 1; }
  [zoom=12]{ line-width:0.6 + 1; }
  [zoom=13]{ line-width:0.8 + 1; }
  [zoom=14]{ line-width:1.0 + 1.8; }
  [zoom=15]{ line-width:3.5 + 2; }
  [zoom=16]{ line-width:6 + 2.5; }
  [zoom=17]{ line-width:8 + 3; }
  [zoom>17]{ line-width:10 + 4; }
}
.route.fill[highway='living_street'],
.route.fill[highway='residential'],
.route.fill[highway='road'],
.route.fill[highway='tertiary'],
.route.fill[highway='tertiary_link'],
.route.fill[highway='unclassified'] {
  [zoom>13]{ line-color:@road_fill; line-cap:round; line-join:round; }
  [zoom=14]{ line-width:1.0; }
  [zoom=15]{ line-width:3.5; }
  [zoom=16]{ line-width:6; }
  [zoom=17]{ line-width:8; }
  [zoom>17]{ line-width:10; }
}

/* Secondary */
.route.line[highway='secondary'][tunnel='no'],
.route.tunnel[highway='secondary'] {
  [zoom>7] { line-color:@road_line; line-cap:round; line-join:round; }
  .tunnel[zoom>7] { line-dasharray:2,1; line-cap:butt; }
  .tunnel[zoom=13]{ line-dasharray:4,2; }
  .tunnel[zoom=14]{ line-dasharray:6,2; }
  .tunnel[zoom=15]{ line-dasharray:8,2; }
  .tunnel[zoom>15]{ line-dasharray:10,2; }
  [zoom=8] { line-width:0.3; line-opacity:0.8; }
  [zoom=9] { line-width:0.5; }
  [zoom=10]{ line-width:0.7; }
  [zoom=11]{ line-width:0.9; }
  [zoom>11]{ line-color:@secondary_line; }
  [zoom=12]{ line-width:0.9 + 2; }
  [zoom=13]{ line-width:1.2 + 2; }
  [zoom=14]{ line-width:2.6 + 2; }
  [zoom=15]{ line-width:4 + 2; }
  [zoom=16]{ line-width:6 + 2.5; }
  [zoom=17]{ line-width:8 + 3; }
  [zoom>17]{ line-width:16 + 3; }
}
.route.bridge::b[highway='secondary'] {
  [zoom>7] { line-color:spin(darken(@road_line,15),-10); line-cap:butt; line-join:round; }
  [zoom=8] { line-width:0.3; }
  [zoom=9] { line-width:0.5; }
  [zoom=10]{ line-width:0.7; }
  [zoom=11]{ line-width:0.9; }
  [zoom>11]{ line-color:spin(darken(@secondary_line,15),-10); }
  [zoom=12]{ line-width:0.9 + 2; }
  [zoom=13]{ line-width:1.2 + 2; }
  [zoom=14]{ line-width:2.6 + 2; }
  [zoom=15]{ line-width:4 + 2; }
  [zoom=16]{ line-width:6 + 2.5; }
  [zoom=17]{ line-width:8 + 3; }
  [zoom>17]{ line-width:16 + 3; }
}
.route.fill[highway='secondary'] {
  [zoom>11]{ line-color:@secondary_fill; line-cap:round; line-join:round; }
  [zoom>11][tunnel='yes'] { line-color:lighten(@secondary_fill,10); }
  [zoom=12]{ line-width:0.9; }
  [zoom=13]{ line-width:1.2; }
  [zoom=14]{ line-width:2.6; }
  [zoom=15]{ line-width:4; }
  [zoom=16]{ line-width:6; }
  [zoom=17]{ line-width:8; }
  [zoom>17]{ line-width:16; }
}

/* Primary */
.route.line[highway='primary'][tunnel='no'],
.route.tunnel[highway='primary'] {
  [zoom>6] { line-color:@primary_line; line-cap:round; line-join:round; }
  .tunnel[zoom>6] { line-dasharray:2,1; line-cap:butt; }
  .tunnel[zoom=13]{ line-dasharray:4,2; }
  .tunnel[zoom=14]{ line-dasharray:6,2; }
  .tunnel[zoom=15]{ line-dasharray:8,2; }
  .tunnel[zoom>15]{ line-dasharray:10,2; }
  [zoom=7] { line-width:0.2; line-opacity:0.6; }
  [zoom=8] { line-width:0.4; line-opacity:0.8; }
  [zoom=9] { line-width:0.6; }
  [zoom=10]{ line-width:0.8; }
  [zoom=11]{ line-width:0.8 + 1.8; }
  [zoom=12]{ line-width:1.0 + 2; }
  [zoom=13]{ line-width:1.4 + 2; }
  [zoom=14]{ line-width:3 + 2; }
  [zoom=15]{ line-width:5 + 2; }
  [zoom=16]{ line-width:7 + 2.5; }
  [zoom=17]{ line-width:9 + 3; }
  [zoom>17]{ line-width:18 + 3; }
}
.route.bridge::b[highway='primary'] {
  [zoom>6] { line-color:spin(darken(@primary_line,15),-10); line-cap:butt; line-join:round; }
  [zoom=7] { line-width:0.2 + 1; }
  [zoom=8] { line-width:0.4 + 1; }
  [zoom=9] { line-width:0.6 + 1; }
  [zoom=10]{ line-width:0.8 + 1; }
  [zoom=11]{ line-width:0.8 + 1.8; }
  [zoom=12]{ line-width:1.0 + 2; }
  [zoom=13]{ line-width:1.4 + 2; }
  [zoom=14]{ line-width:3 + 2; }
  [zoom=15]{ line-width:5 + 2; }
  [zoom=16]{ line-width:7 + 2.5; }
  [zoom=17]{ line-width:9 + 3; }
  [zoom>17]{ line-width:18 + 3; }
}
.route.fill[highway='primary'] {
  [zoom>10]{ line-color:@primary_fill; line-cap:round; line-join:round; }
  [zoom>10][tunnel='yes'] { line-color:lighten(@primary_fill,10); }
  [zoom=11]{ line-width:0.8; }
  [zoom=12]{ line-width:1.0; }
  [zoom=13]{ line-width:1.4; }
  [zoom=14]{ line-width:3; }
  [zoom=15]{ line-width:5; }
  [zoom=16]{ line-width:7; }
  [zoom=17]{ line-width:9; }
  [zoom>17]{ line-width:18; }
}

/* Trunk */
.route.line[highway='trunk'][tunnel='no'],
.route.tunnel[highway='trunk'] {
  [zoom>6] { line-color:@trunk_line; line-cap:round; line-join:round; }
  .tunnel[zoom>6] { line-dasharray:2,1; line-cap:butt; }
  .tunnel[zoom=13]{ line-dasharray:4,2; }
  .tunnel[zoom=14]{ line-dasharray:6,2; }
  .tunnel[zoom=15]{ line-dasharray:8,2; }
  .tunnel[zoom>15]{ line-dasharray:10,2; }
  [zoom=7] { line-width:0.3; line-opacity:0.6; }
  [zoom=8] { line-width:0.5; line-opacity:0.8; }
  [zoom=9] { line-width:0.7; }
  [zoom=10]{ line-width:0.8; }
  [zoom=11]{ line-width:0.8 + 1.8; }
  [zoom=12]{ line-width:1.0 + 2; }
  [zoom=13]{ line-width:1.4 + 2; }
  [zoom=14]{ line-width:3 + 2; }
  [zoom=15]{ line-width:5 + 2; }
  [zoom=16]{ line-width:7 + 2.5; }
  [zoom=17]{ line-width:9 + 3; }
  [zoom>17]{ line-width:18 + 3; }
}
.route.bridge::b[highway='trunk'] {
  [zoom>6] { line-color:spin(darken(@trunk_line,15),-10); line-cap:butt; line-join:round; }
  [zoom=7] { line-width:0.3; }
  [zoom=8] { line-width:0.5; }
  [zoom=9] { line-width:0.7 + 1; }
  [zoom=10]{ line-width:0.8 + 1; }
  [zoom=11]{ line-width:0.8 + 1.8; }
  [zoom=12]{ line-width:1.0 + 2; }
  [zoom=13]{ line-width:1.4 + 2; }
  [zoom=14]{ line-width:3 + 2; }
  [zoom=15]{ line-width:5 + 2; }
  [zoom=16]{ line-width:7 + 2.5; }
  [zoom=17]{ line-width:9 + 3; }
  [zoom>17]{ line-width:18 + 3; }
}
.route.fill[highway='trunk'] {
  [zoom>10]{ line-color:@trunk_fill; line-cap:round; line-join:round; }
  [zoom>10][tunnel='yes'] { line-color:lighten(@trunk_fill,10); }
  [zoom=11]{ line-width:0.8; }
  [zoom=12]{ line-width:1.0; }
  [zoom=13]{ line-width:1.4; }
  [zoom=14]{ line-width:3; }
  [zoom=15]{ line-width:5; }
  [zoom=16]{ line-width:7; }
  [zoom=17]{ line-width:9; }
  [zoom>17]{ line-width:18; }
}

/* Motorway */
.route.line[highway='motorway'][tunnel='no'],
.route.tunnel[highway='motorway'] {
  [zoom>6] { line-color:@motorway_line; line-cap:round; line-join:round; }
  .tunnel[zoom>6] { line-dasharray:2,1; line-cap:butt; }
  .tunnel[zoom=13]{ line-dasharray:4,2; }
  .tunnel[zoom=14]{ line-dasharray:6,2; }
  .tunnel[zoom=15]{ line-dasharray:8,2; }
  .tunnel[zoom>15]{ line-dasharray:10,2; }
  [zoom=7] { line-width:0.4; line-opacity:0.6; }
  [zoom=8] { line-width:0.6; line-opacity:0.8; }
  [zoom=9] { line-width:0.8; }
  [zoom=10]{ line-width:1.0; }
  [zoom=11]{ line-width:1.0 + 1.8; }
  [zoom=12]{ line-width:1.2 + 2; }
  [zoom=13]{ line-width:2 + 2; }
  [zoom=14]{ line-width:3 + 2; }
  [zoom=15]{ line-width:6 + 2; }
  [zoom=16]{ line-width:8 + 2.5; }
  [zoom=17]{ line-width:10 + 3; }
  [zoom>17]{ line-width:20 + 3; }
}
.route.bridge::b[highway='motorway'] {
  [zoom>6] { line-color:spin(darken(@motorway_line,15),-10); line-cap:butt; line-join:round; }
  [zoom=7] { line-width:0.4; }
  [zoom=8] { line-width:0.6; }
  [zoom=9] { line-width:0.8 + 1; }
  [zoom=10]{ line-width:1.0 + 1; }
  [zoom=11]{ line-width:1.0 + 1.8; }
  [zoom=12]{ line-width:1.2 + 2; }
  [zoom=13]{ line-width:2 + 2; }
  [zoom=14]{ line-width:3 + 2; }
  [zoom=15]{ line-width:6 + 2; }
  [zoom=16]{ line-width:8 + 2.5; }
  [zoom=17]{ line-width:10 + 3; }
  [zoom>17]{ line-width:20 + 3; }
}
.route.fill[highway='motorway'] {
  [zoom>10]{ line-color:@motorway_fill; line-cap:round; line-join:round; }
  [zoom>10][tunnel='yes'] { line-color:lighten(@motorway_fill,10); }
  [zoom=11]{ line-width:1.0; }
  [zoom=12]{ line-width:1.2; }
  [zoom=13]{ line-width:2; }
  [zoom=14]{ line-width:3; }
  [zoom=15]{ line-width:6; }
  [zoom=16]{ line-width:8; }
  [zoom=17]{ line-width:10; }
  [zoom>17]{ line-width:20; }
}

/* ---- TURNING CIRCLES ---- */

.turning-circle[zoom>=14] {
  marker-fill:@road_fill;
  marker-line-color:@road_line;
  marker-line-width:1;
  [zoom=14] { marker-width: 2; }
  [zoom=15] { marker-width: 4; }
  [zoom=16] { marker-width: 7; }
  [zoom=17] { marker-width: 9; }
  [zoom>17] { marker-width: 12; marker-line-width: 1.5; }
}

/* ---- ONE WAY ARROWS ---- */
/* TODO: oneway='-1' */
.highway-label::arrow[oneway='yes'][zoom>15] {
  marker-type:arrow;
  marker-line-width:1;
  marker-line-opacity:0.5;
  marker-line-color:#6ff2ff;
  marker-spacing: 300;
  marker-fill:darken(@motorway_line,10);
  marker-opacity:0.8;
  [zoom=16] {
    marker-transform:"scale(0)";
    [highway='motorway'],
    [highway='trunk'],
    [highway='primary'],
    [highway='secondary'] { marker-transform:"scale(0.8)"; }
  }
  [zoom=17] {
    marker-transform:"scale(0.8)";
    [highway='motorway'],
    [highway='trunk'],
    [highway='primary'],
    [highway='secondary'] { marker-transform:"scale(0.9)"; }
  }
  [zoom>17] {
    marker-transform:"scale(1)";
    [highway='motorway'],
    [highway='trunk'],
    [highway='primary'],
    [highway='secondary'] { marker-transform:"scale(1.2)"; }
  }
}

/* ---- AERO ---- */
.aero.poly[zoom>13] {
  line-color:lighten(@road_line,5);
  polygon-fill:lighten(#6ff2ff,10);
}

.route.line[aeroway='runway'][zoom>=11],
.route.line[aeroway='taxiway'][zoom>=11] {
  line-cap: square;
  line-color: lighten(@road_line,5);
}
.route.fill[aeroway='runway'][zoom>=12],
.route.fill[aeroway='taxiway'][zoom>=12] {
  line-cap: square;
  line-color: lighten(#6ff2ff,10);
}

.route.line[aeroway='runway'] {
  [zoom=11] { line-width: 2; }
  [zoom=12] { line-width: 1 + 2; }
  [zoom=13] { line-width: 3 + 2; }
  [zoom=14] { line-width: 9 + 2; }
  [zoom=15] { line-width: 16 + 2; }
  [zoom=16] { line-width: 22 + 2; }
  [zoom=17] { line-width: 28 + 2; }
  [zoom>17] { line-width: 34 + 2; }
}

.route.fill[aeroway='runway'] {
  [zoom=12] { line-width: 1; }
  [zoom=13] { line-width: 3; }
  [zoom=14] { line-width: 9; }
  [zoom=15] { line-width: 16; }
  [zoom=16] { line-width: 22; }
  [zoom=17] { line-width: 28; }
  [zoom>17] { line-width: 34; }
}

.route.line[aeroway='taxiway'] {
  [zoom=11] { line-width: 1; }
  [zoom=12] { line-width: 0.8 + 1.8; }
  [zoom=13] { line-width: 1 + 2; }
  [zoom=14] { line-width: 2 + 2; }
  [zoom=15] { line-width: 6 + 2; }
  [zoom=16] { line-width: 10 + 2; }
  [zoom=17] { line-width: 10 + 2; }
  [zoom>17] { line-width: 14 + 2; }
}

.route.fill[aeroway='taxiway'] {
  [zoom=12] { line-width: 0.8; }
  [zoom=13] { line-width: 1; }
  [zoom=14] { line-width: 2; }
  [zoom=15] { line-width: 6; }
  [zoom=16] { line-width: 10; }
  [zoom=17] { line-width: 10; }
  [zoom>17] { line-width: 14; }
}

/* ---- PARKING ---- */
.parking[zoom>13] {
  polygon-fill:lighten(@land,3);
  line-color:darken(@land,6);
  [zoom=14] { line-width:0.4; }
  [zoom=15] { line-width:0.6; }
  [zoom>15] { line-width:0.8; }
}

/* ---- RAILWAYS ---- */
/* TODO: Railway bridges */
.route.fill[railway='rail'][zoom>10] {
  line-color:@rail;
  line-width:0.3;
  line-dasharray:4,3;
  ::x {
    line-color:lighten(@rail,10);
    line-dasharray:0,4,3,0;
    line-width:0.3;
  }
  [zoom=13], ::x[zoom<14] { line-width:0.4; }
  [zoom=14], ::x[zoom=14] { line-width:0.5; }
  [zoom=15], ::x[zoom=15] { line-width:0.6; }
  [zoom=16], ::x[zoom=16] { line-width:0.8; }
  [zoom=17], ::x[zoom=17] { line-width:1.5; }
  [zoom=18], ::x[zoom=18] { line-width:2.0; }
}


/* ==========labels.mss========== */
@font_reg: "Ubuntu Regular","Arial Regular","DejaVu Sans Book";

/* ---- PLACENAMES ---- */

.placename.medium[place='city'][zoom>6][zoom<14],
.placename.medium[place='metropolis'][zoom>6][zoom<14] {
  text-face-name:@font_reg;
  text-name:"[name]";
  text-fill:#555;
  text-halo-fill:#6ff2ff;
  text-halo-radius:2;
  [zoom=7] { text-size:10; text-halo-radius:1; }
  [zoom=8] { text-size:10; text-halo-radius:1; }
  [zoom=9] { text-size:11; }
  [zoom=10] { text-size:12; }
  [zoom=10] { text-size:13; text-character-spacing:1; }
  [zoom=11] { text-size:14; text-character-spacing:2; }
  [zoom=12] { text-size:16; text-character-spacing:4; }
  [zoom=13] { text-size:18; text-character-spacing:6; }
}

.placename.medium[place='large_town'][zoom>7][zoom<16],
.placename.medium[place='town'][zoom>8][zoom<16],
.placename.medium[place='small_town'][zoom>9][zoom<16]{
  text-face-name:@font_reg;
  text-name:"[name]";
  text-fill:#555;
  text-halo-fill:#6ff2ff;
  text-halo-radius:2;
  [zoom=8] { text-size:10; text-halo-radius:1; }
  [zoom=9] { text-size:10; text-halo-radius:1; }
  [zoom=10] { text-size:10; text-halo-radius:1; }
  [zoom=11] { text-size:11; }
  [zoom=12] { text-size:12; }
  [zoom=13] { text-size:13; text-character-spacing:1; }
  [zoom=14] { text-size:14; text-character-spacing:2; }
  [zoom=15] { text-size:16; text-character-spacing:4; }
  [zoom=16] { text-size:18; text-character-spacing:6; }
}

/* ---- HIGHWAY ---- */

.highway-label[zoom>11] {
  text-face-name:@font_reg;
  text-halo-radius:1;
  text-placement:line;
  text-name:"''";
  [highway='motorway'][zoom>=12] {
    text-name:"[name]";
    text-fill:spin(darken(@motorway_fill,70),-15);
    text-halo-fill:lighten(@motorway_fill,8);
    [zoom>=13] { text-size:11; }
    [zoom>=15] { text-size:12; }
    [zoom>=17] { text-size:14; }
  }
  [highway='trunk'][zoom>=12] {
    text-name:"[name]";
    text-fill:spin(darken(@trunk_fill,66),-15);
    text-halo-fill:lighten(@trunk_fill,8);
    [zoom>=15] { text-size:11; }
    [zoom>=17] { text-size:12; }
  }
  [highway='primary'][zoom>=13] {
    text-name:"[name]";
    text-fill:spin(darken(@primary_fill,66),-15);
    text-halo-fill:lighten(@primary_fill,8);
    [zoom>=15] { text-size:11; }
    [zoom>=17] { text-size:12; }
  }
  [highway='secondary'][zoom>=13] {
    text-name:"[name]";
    text-fill:spin(darken(@secondary_fill,66),-15);
    text-halo-fill:lighten(@secondary_fill,8);
    [zoom>=15] { text-size:11; }
    [zoom>=17] { text-size:12; }
  }
  [highway='residential'][zoom>=15],
  [highway='road'][zoom>=15],
  [highway='tertiary'][zoom>=15],
  [highway='unclassified'][zoom>=15] {
    text-name:"[name]";
    text-fill:#444;
    text-halo-fill:#6ff2ff;
    [zoom>=17] { text-size:12; }
  }
}

