$(document).ready(function(){
   $('.chalanhes_table').off('click', '.challange submit',function(event){
    var $this = $(this)
    var serialized_form = $this.serialize();
    var challange = $this.parent
    challange.hide();
    // $('#table-wrapper2').show();
        $.ajax({
          url: $this.attr('action'),
          type: 'POST', 
          data: serialized_form, 
         

          


          success: function(data,status,xhr) {
            challange.show();
            // $('#table-wrapper2').hide();
            $('#table-wrapper').html(data);
          }
        });
    event.preventDefault();
  });
});