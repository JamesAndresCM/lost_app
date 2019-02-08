$(document).on('turbolinks:load', function() {
    Turbolinks.clearCache();
    $('#regions').select2({
        
        placeholder: 'Selecccione Provincia',
        theme: "bootstrap",
        width: '100%',
        language: "es",
        minimumResultsForSearch: -1,
        delay: 250,

        ajax: {
          cache: true,
          dataType: "json",
          url: "/regions",
          processResults: function (data) {
            return {
                results: $.map(data, function (field, i) {
                  return {
                    text: field.name,
                    children: $.map(field.provinces, function(child){
                      return {
                          id: child.id,
                          text: child.name
                      }
                    })
                  }
                })
              }
            }
          },
      });
   

    $("#regions").change(function () {
      
      var province_id = Number($(this).children(":selected").attr("value"));

      clearTarget();

      if (!isNaN(province_id)) {
          
          $.ajax({
              type: "GET",
              url: "/provinces/" + province_id,
              contentType: 'application/json',
              dataType: "json",
              
              success: function (data) {
                for (var i = 0; i < data.length; i++) {
                  if (data.length > 0) {
                    $('#post_district_id').append("<option value=" + data[i].id + ">" + data[i].name + "</option>");
                    }
                  }
                },
              
              error: function (jqXHR, textStatus, errorThrown) {
                  console.log("error " + jqXHR + textStatus + errorThrown);
              },
          });
        }
      });

      function clearTarget() {
        return this.$("#post_district_id").html('<option value="">Seleccione Comuna</option>');
      }



    var today = new Date();

    $('#datetimepicker').datetimepicker({
      format: 'DD-MM-YYYY HH:mm',
      allowInputToggle : true,
      startDate: today,
      minDate: new Date(today.getFullYear(), today.getMonth()-1, 0),
      maxDate: today,
      useCurrent: false,
      todayHighlight: true,
      autoclose: true,
      language: 'es',
      buttons: {showClose: true },
      widgetPositioning: {
            horizontal: 'right',
            vertical: 'bottom'
        }
    });
});
