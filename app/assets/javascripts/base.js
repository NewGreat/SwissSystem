$(document).ready(function(){
   $('.loader').hide();
///////////////////////////////////////////////////////////////////////////////////
// do skonczenia. Renderuje potyczki, ale nie renderuje calej strony po zakonczeniu ich. Do obejscia przyciskiem zakoncz ture.
//////////////////////////////////////////////////////////////////////////////////
  // $('.challanges_table').on('submit', '.challange form',function(event){
  //   var $this = $(this);
  //   var serialized_form = $this.serialize();
  //   var challange = $this.parents('.challange');
  //   var loader = $this.parents('.challange').find('.loader');
  //   loader.show();
  //   $this.hide();
  //   $.ajax({
  //     url: $this.attr('action'),
  //     type: 'POST', 
  //     data: serialized_form, 
  //     success: function(data,status,xhr) {
  //       $this.show();
  //       // if (data == "round is finished") {
  //         // window.open(,"_self")
  //         //$.ajax({
  //         // url: "#",
  //         // type: "GET", 
  //         // };
  //       // }else if (data == "game is finished") {}
  //       // else {
  //         console.log(data);
  //         alert(data);
  //       $this.html(data);
  //     // }
  //       $('.loader').hide();
  //     }
  //   });
  //   event.preventDefault();
  // });


});

$('players_table').on('submit',function(event){
    var $this = $(this)
    var serialized_form = $this.serialize();
    $('#table-wrapper').hide();
    $('#table-wrapper2').show();
    // infinite_rotate();
    $('#table-wrapper2').rotate();
    $('#index_rent_form')[0].reset();
    $('#index_rent_form').show();
        $.ajax({
          url: $this.attr('action'),
          type: 'POST', 
          data: serialized_form, 
         

          


          success: function(data,status,xhr) {
            $('#table-wrapper').show();
            $('#table-wrapper2').hide();
            $('#table-wrapper').html(data);
          }
        });
    event.preventDefault();
  });