$(function(){

	$('#go_button').on('click', function(){

    $('.connections, .desc').hide();
    $('.connections .name').remove();

		var person1 = $('#person1').val();
		var person2 = $('#person2').val();

		if(person1 == person2){
			alert("Choose 2 different people");
		}
		else{
      var people = {
        person1 : person1,
        person2 : person2
      };
      $.ajax({
        url : '/connect',
        data: people,
        dataType: 'json',
        success: function(data){
          $('#separation_number').text(data.length - 1);
          for(var i=0; i < data.length; ++i){
            var the_name = $('<span/>');
            the_name.addClass('name').text(data[i]);
            $('.connections').append(the_name);
          }

          $('.connections, .desc').show();
        },
        error : function(jqXHR, textStatus, errorThrown) {
          console.log("Failed ajax request - Status: " + textStatus + ", Error: " + errorThrown);
        }
      });
		}
	});	

});
