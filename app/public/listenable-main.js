require(["jquery", "spin.min"], function($, spin) {
  $(function() {
    var opts = {
      lines: 13, // The number of lines to draw
      length: 15, // The length of each line
      width: 2, // The line thickness
      radius: 17, // The radius of the inner circle
      rotate: 0, // The rotation offset
      color: '#000', // #rgb or #rrggbb
      speed: 0.6, // Rounds per second
      trail: 89, // Afterglow percentage
      shadow: true, // Whether to render a shadow
      hwaccel: false, // Whether to use hardware acceleration
      className: 'spinner', // The CSS class to assign to the spinner
      zIndex: 2e9, // The z-index (defaults to 2000000000)
      top: 'auto', // Top position relative to parent in px
      left: 'auto' // Left position relative to parent in px
    };

    var spinner = new Spinner(opts);

    var start_spinner = function() {
      $(".spinner").show();
      spinner.spin($(".spinner")[0]);
    };

    var stop_spinner = function() {
      spinner.stop($(".spinner")[0]);
      $(".spinner").hide();
    };

    var rdio_url = "http://www.rdio.com";
    var search = function() {
      $(".output").empty();
      start_spinner();
      $.get("/listenable/search", { query: $("#artist").val() }, function(data) {

        stop_spinner();
        $(".output").empty();

        if(data == "Sorry! Not (yet)...") {
          $(".output").html(data);
          return;
        }

        $.each(JSON.parse(data), function(_, artist) {
          var artist_div = $("<div class='artist'></div>");
          $(".output").append(artist_div);

          var artist_link = $("<a href='" + rdio_url + artist.artist.url + "'>View on Rdio</a>");
          artist_div.append(artist_link);

          var artist_h3 = $("<h3>" + artist.artist.name + "</h3>");
          artist_div.append(artist_h3);

          var album_ul = $("<ul class='albums'></ul>");
          artist_div.append(album_ul);

          $.each(artist.albums, function(_, album) {
            var album_li = $("<li class='album'></li>");

            var album_img = $("<img src='" + album.icon + "' />");
            album_li.append(album_img);

            var album_span = $("<span>" + album.name + " (Streamable? " + album.canStream + ")</span>");
            album_li.append(album_span);

            album_ul.append(album_li);
          });
          $(".output").append("<div class='spacer'></div>");
        });
      });
    };

    $("input[type=submit]").click(search);
    $("#artist").bind('keyup', function(e) {
      if(e.which === 13) {
        search();
      }
    }).bind('click', function() {
      this.select();
    });
  });
});
