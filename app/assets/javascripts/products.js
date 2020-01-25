$(document).on("click", ".card", function(){
  $("#product_details").modal("show");
  $("#product_details .modal-title strong").html($(this).data("title"));
  $("#product_details .description span").html($(this).data("description"));
  $("#product_details .country span").html($(this).data("country"));
  $("#product_details .price span").html($(this).data("price"));
  $("#product_details .tags span").html($(this).data("tags"));
  $("#product_details .created_at span").html($(this).data("createdAt"));
});

$(document).on("change", ".sort-by-form select", function(){
  $(".sort-by-form").submit();
});