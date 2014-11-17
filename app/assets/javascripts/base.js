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

$('.players_table').on('submit',function(event){
    var $this = $(this);
    var table = $this.parents('.players_table').find('.table_of_players');
    var loader = $this.parents('.players_table').find('.loader');
    var serialized_form = $this.serialize();
    table.hide();
    loader.show();
    $this.reset();
    console.log(serialized_form);
        $.ajax({
          url: $this.attr('action'),
          type: 'POST', 
          data: serialized_form, 
          success: function(data,status,xhr) {
            table.show();
            loader.hide();
         console.log(data);
           alert(data);
            $('#players_index').html(data);
          }
        });
    event.preventDefault();
  });