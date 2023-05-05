const targetNode = document.getElementById('mkdocs-search-results');
const config = { attributes: true, childList: true, subtree: true };
var observer = new MutationObserver(function(mutations) {
  var hasUpdates = false;
  for (var index = 0; index < mutations.length; index++) {
    var mutation = mutations[index];
    if (mutation.type === 'childList' && mutation.addedNodes.length) { 
    	hasUpdates = true
      break;
    }
  }
  if (hasUpdates) {
  		var body = document.getElementById('body');
		if ( targetNode.firstChild.nodeName != "P"){
			body.style.display = "none";
			targetNode.style.display = "block";
		}else{
			targetNode.style.display = "none";
			body.style.display = "block";
	    }
	}
});

observer.observe(targetNode, config);
var pizza = document.getElementById('nav-toggle');
var sidee = document.getElementById('side');
var scrh = document.getElementById('nav-scrh');
pizza.addEventListener("click", function(e){
	sidee.classList.toggle("chess");
	sidee.nextElementSibling.nextElementSibling.classList.toggle("cake");
});

scrh.addEventListener("click", function(e){
	document.getElementsByClassName('search')[0].classList.toggle("show");

});

(function() {
  var selects = document.getElementsByTagName('h2');
  var sections = {};
  for(var i = 0; i < selects.length; i++){
    sections[selects[i].id] = selects[i].offsetTop;
  };
  window.onscroll = function() {
    var scrollPosition = document.documentElement.scrollTop || document.body.scrollTop;
    for (var key in sections) {
      if (sections[key] <= scrollPosition) {
        document.querySelector('.current').setAttribute('class', '');
        document.querySelector('a[href*="#'+key+'"]').setAttribute('class', 'current');
      }
    }
  };
})();
