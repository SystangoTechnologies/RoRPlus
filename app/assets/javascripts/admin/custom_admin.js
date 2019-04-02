$( document ).on('turbolinks:load', function() {
	$(".alert" ).fadeOut(7000);
	$("#sidenavToggler").click(function(e) {
		e.preventDefault();
		$("body").toggleClass("sidenav-toggled");
		$(".navbar-sidenav .nav-link-collapse").addClass("collapsed");
		$(".navbar-sidenav .sidenav-second-level, .navbar-sidenav .sidenav-third-level").removeClass("show");
	});
	$(".form-control").on("change",function(){
		$(this.closest(".form-group")).find(".server-validation").hide()
	})
});
