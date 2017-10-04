
$(document).on('turbolinks:load', function(){
  var recipes = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: "/recipes/autocomplete?query=%QUERY",
      wildcard: "%QUERY"
    }
  });
  $('#recipes_search').typeahead(null, {
    source: recipes
  })
  $('#recipes_search').on('keypress', function(e) {
  if (e.which == 13) {
    e.preventDefault();
    var q = $('#recipes_search').val();
    window.location.href = "/recipes?term="+q;
  }
 });
})
