

function OnMouseOver(elmt)
{
    //alert('h呵呵aha');
	//elmt.parentNode.parentNode.parentNode.style.backgroundColor = '#E9E9E9';
}



/*
scrollUp
*/
$(document).ready(function(){ 

	$(window).scroll(function(){
		if ($(this).scrollTop() > 100) {
			$('.scrollup').fadeIn();
		} else {
			$('.scrollup').fadeOut();
		}
	}); 

	$('.scrollup').click(function(){
		$("html, body").animate({ scrollTop: 0 }, 600);
		return false;
	});

});





