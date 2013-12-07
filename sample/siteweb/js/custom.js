$(window).load(function() {
        $('#carousel-screenshots').carousel();

        $(".carousel-nav a").click(function(e){
            e.preventDefault();
            var index = parseInt($(this).attr('data-to'));
            $('#carousel-screenshots').carousel(index);
            var nav = $('.carousel-nav');
            var item = nav.find('a').get(index);
            nav.find('a.active').removeClass('active');
            $(item).addClass('active');
        });

        $("#carousel-screenshots").bind('slide', function(e) {
          var elements = 4; // change to the number of elements in your nav
          var nav = $('.carousel-nav');
          var index = $('#carousel-screenshots').find('.item.active').index();
          index = (index == elements - 1) ? 0 : index + 1;
          var item = nav.find('a').get(index);
          nav.find('a.active').removeClass('active');
          $(item).addClass('active');
        });

        $('.add-email').click(function(){
          var email = $(this).parents('#myModal').find('.email').val(),
              url   = 'http://nightowl.dev/?api=Sun_API&method=open_in&params[email]="'+email+'"';
          console.log(url);
          $.ajax({
            url:url,
            success: function(){
              $('#myModal').modal('hide');
            }
          });
        });
        
        
  });
  
$('#features-tab a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
})