function add_subject_color() {
  $(".color-code").spectrum({
    showInput: true,
    showPalette: true,
    togglePaletteOnly: true,
    preferredFormat: "rgb",
    togglePaletteMoreText: 'more',
    togglePaletteLessText: 'less',

    palette: [
        ["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
        ["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
        ["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
        ["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
        ["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
        ["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
        ["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
        ["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
    ]
  });
}

function PrintDivTest(text) {
  var popupWin = window.open('', '_blank', 'width=300,height=300');
  popupWin.document.open();
  if (text.indexOf('span') == -1){
    popupWin.document.write('<html><body>' + '<span style="font-family:Comic Sans MS,cursive">' + text + '</span>' + '</html>');
    
  } else {
    popupWin.document.write('<html><body>' + text + '</html>'); 
  }
}

function initilize_data() {
  $('.ckeditor2').ckeditor({
    // optional config
  })
  $(".dummy_subject_id").change(function(){
    if (this.value == 'ENGLISH') {
      $("#sheet").empty().append("<option>I can use fronted adverbials.</option><option>I can use an embedded clause.</option>");
    }else if (this.value == 'MATHS') {
      $("#sheet").empty().append("<option>I can multiply 3 digit numbers.</option><option>I can divide using a range of methods.</option>");
    }else {
      $("#sheet").empty().append("<option>I can use fronted adverbials.</option><option>I can use an embedded clause.</option><option>I can multiply 3 digit numbers.</option><option>I can divide using a range of methods.</option>");
    }
  })

  
  $('.child-name').first().addClass('active-child');
  
  $('.child-name').on('click', function(){
    $(".child-name").removeClass('active-child');
    $(".label-name").text($(this).text())
    $(this).addClass('active-child');
    $("#dictation_test").val('')
    $('.multiple-child').prop( "checked", false );
  });

  

  $('.clear-label').click(function(){
    $("#dictation_test").val('')
  })

  $('#print-label').click(function(){
    if ($('.multiple-child:checkbox:checked').size() > 0) {
      $('.multiple-child:checkbox:checked').each(function () {
        console.log('1')
        PrintDivTest($("#dictation_test").val())
      })
    } else {
      PrintDivTest($("#dictation_test").val())
    }
  })
  

  var isRecording = false; 
  $("#record-btn").click(function(event){
    event.preventDefault();
    // if we're recording when the button is clicked
    if(isRecording) {
      annyang.abort();            // stop listening
      isRecording = false;          // set recording var to false
      $("span",this).text('Start Speech');      // change btn text
      $(this).removeClass('btn-danger');    // turn off red class
      
    // if we're not recording when the button is clicked
    } else {
      //annyang.abort()
      annyang.start();            // start listening
      isRecording = true;           // set recording var to true
      $("span",this).text('Stop');      // change btn text
      $(this).removeClass('btn-primary');   // turn off blue class
      $(this).addClass('btn-danger');     // turn on red class
    }
  });
  if (annyang) {
      // var isRecording = false; // create var to track recording state  
      var names = []; //insert names for annyang commands
      var grades = [];
      $('.student-list').find('a').each(function() {
        names.push(this.text)
      })
      $(':radio').each(function(){
        grades.push($(this).val().toLowerCase())
      });
      
      // define the functions our commands will run.
    
      var question = function() {
        str = $("#dictation_test").val()
        $("#dictation_test").val(str + '?')
      };

      // var remove = function() {
      //   str = $("#dictation").val()
      //   $("#dictation").val(str.slice(0,-1))
      // };

      var marked = function() {
        str = $("#dictation_test").val()
        $("#dictation_test").val(str+'!')
      };

      var comma = function() {
        str = $("#dictation_test").val()
        $("#dictation_test").val(str + ', ')
      };
      var nextLine = function() {
        str = $("#dictation_test").val()
        $("#dictation_test").val(str + '\n ')
      };

      var colon = function() {
       str = $("#dictation_test").val().replace(/\s+$/, '')
        $("#dictation_test").val(str + ':')
      };

      var semicolon = function() {
         str = $("#dictation_test").val().replace(/\s+$/, '')
        $("#dictation_test").val(str + '; ')
      };

      var hyphen = function() {
         str = $("#dictation_test").val().replace(/\s+$/, '')
        $("#dictation_test").val(str + '-')
      };

      var stop = function() {
        str = $("#dictation_test").val().replace(/\s+$/, '')
        $("#dictation_test").val(str + '. ')
      };

      var stopped = function() {
        str = $("#dictation_test").val().replace(/\s+$/, '')
        $("#dictation_test").val(str + '. ')
      };
      
      var writeIt = function(repeat) {

        if (names.includes(repeat)) {
          $("#"+repeat).click()
          $("#dictation_test").val('')
          
        }else if (grades.includes(repeat)) {
          $("input[data-grade='"+ repeat +"']").click()
          $(".text-size").val($("input[data-grade='"+ repeat +"']").data("marks"))
          $(".text-size").css("background-color", $("input[data-grade='"+ repeat +"']").data("color"));
        }else if (repeat == "clear label") {
          $("#dictation_test").val('')
        }else if (repeat == "print label") {
          PrintDivTest($("#dictation_test").val())
        }
        else{
          str = $("#dictation_test").val()
          if (str == ""){
            text = repeat.substr(0,1).toUpperCase()+repeat.substr(1)
            $("#dictation_test").val(text)
          } else if ((str[str.length-2]=='.') || (str[str.length-1]=='.')){
            text = repeat.substr(0,1).toUpperCase()+repeat.substr(1)
            $("#dictation_test").val(str +' '+text)
          } else if (str[str.length-1]=='!'){
            text = repeat.substr(0,1).toUpperCase()+repeat.substr(1)
            $("#dictation_test").val(str +' '+text)
          } else if (str[str.length-1]=='?'){
            text = repeat.substr(0,1).toUpperCase()+repeat.substr(1)
            $("#dictation_test").val(str +' '+text)
          } else if (repeat=='.'){
            $("#dictation_test").val(str +repeat +' ')
          } else {
            $("#dictation_test").val(str+' '+repeat)
          }
          
        }
        //$("#dictation").text(repeat);
      }

      // define our commands.
      // * The key is what you want your users to say say.
      // * The value is the action to do.
      //   You can pass a function, a function name (as a string), or write your function as part of the commands object.exclamation mark
      var commands = {
        'full stop (there)':        stop,
        'fullstop (there)':        stopped,
        'exclamation mark (there)':        marked,
        'question mark (there)':        question,
        'next line (there)':        nextLine,
        'comma (there)':        comma,
        'hyphen (there)':       hyphen,
        'semicolon (there)':    semicolon,
        'colon (there)':        colon,
        '*repeat':        writeIt
      };
      names.forEach(function(name) {
        commands[name] = function() {
          $.ajax({
            url: $("#"+name).attr('href'),
            //orther options ...
            success: function(data){
                $("#"+name).click()
            }
          });
        }
      })

      grades.forEach(function(grade) {
        commands[grade] = function() { grade }
      })

      annyang.debug();                // turn on debugging (console messages)

      // Add voice commands to respond to
      annyang.addCommands(commands);

    } else {
      $("#dictation_test").text('Sorry, browser not supported.');
    }
}