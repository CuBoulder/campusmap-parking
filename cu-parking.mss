.parking{
  //polygon-fill:#ffeeb6;
  [amenity='parking']{
    polygon-fill:#ffeeb6;
  }
  [amenity='motorcycle_parking']{
    polygon-fill: #957ff4;
    
  }
  polygon-opacity: 0.5;
  line-color:#a4a4a4;
}

.parking[access='student'], 
.parking[access=~'.*student.*'],
.parking[acc=~'.*student.*']{
  polygon-fill:transparent;
  polygon-pattern-file: url(res/hatch-yellow.png);
}

.parking[access='employee'], 
.parking[access=~'.*employee.*'], 
.parking[acc=~'.*employee.*']{
  polygon-fill:transparent;
  polygon-pattern-file: url(res/hatch-blue.png);
}


.parking[access='public'],
.parking[access=~'.*public.*'],
.parking[acc=~'.*public.*']{
  polygon-fill:transparent;
  polygon-pattern-file: url(res/hatch-pink.png); 
}

.parking[parking="loading_dock"]{
  polygon-fill:transparent;
  polygon-pattern-file: url(res/hatch-green.png);
}

.vending_machines{
  [vending='parking_tickets']{
    [zoom <= 15] {}
  	[zoom = 16] {point-file: url(res/parking-ticket-12.png);}
  	[zoom >= 17] {point-file: url(res/parking-ticket-18.png);} 
  	[zoom >= 19] {point-file: url(res/parking-ticket-24.png);}
  }
}

/*
.parking[capacity_disabled>0]{
  [zoom <= 15] {}
  [zoom = 16] {point-file: url(res/handicap-12.png);}
  [zoom >= 17] {point-file: url(res/handicap-18.png);} 
  [zoom >= 19] {point-file: url(res/handicap-24.png);}
}
*/
 
.parking::labels{
    [zoom>16]{
      text-face-name:@font_reg;
      text-fill:#555;
      text-halo-fill:#fff;
      text-halo-radius:2;
      text-name:"[ref]";
    }

  }