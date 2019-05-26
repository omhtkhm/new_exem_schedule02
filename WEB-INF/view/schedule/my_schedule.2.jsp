<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>NHN Forward HoL - TOAST UI Grid</title>
    <!-- <link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" /> -->
    <!-- <script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script> -->

    <script src="./resources/script/node_modules/jquery/dist/jquery.js"></script>
    <script src="./resources/script/node_modules/underscore/underscore.js"></script>
    <script src="./resources/script/node_modules/backbone/backbone.js"></script>
    <script src="./resources/script/node_modules/tui-code-snippet/dist/tui-code-snippet.js"></script>
    <script src="./resources/script/node_modules/tui-pagination/dist/tui-pagination.js"></script>
    <script src="./resources/script/node_modules/tui-date-picker/dist/tui-date-picker.js"></script>
    <script src="./resources/script/node_modules/tui-grid/dist/tui-grid.js"></script>

    <link rel="stylesheet" type="text/css" href="./resources/script/node_modules/tui-grid/dist/tui-grid.css" />


  </head>
  <body>
    <h1>TOAST UI Grid</h1>
    <div id="grid"></div>
    <script type="text/javascript">

      const options = {
        el: document.getElementById('grid'),
        columns: [
          {
            title: 'Name',
            name: 'name'
          },
          {
            title: 'Artist',
            name: 'artist'
          },
          {
            title: 'Release',
            name: 'release'
          },
          {
            title: 'Genre',
            name: 'genre'
          }
        ],
        data: [
          {
            name: 'Beautiful Lies',
            artist: 'Birdy',
            release: '2016.03.26',
            genre: 'Pop'
          }
        ]
      };

      const grid = new tui.Grid(options);

    </script>
  </body>
</html>
