(function () {
    if (typeof window.Hours === "undefined" ) {
        window.Hours = {};
    }

    Hours.horus = null;

    Hours.refresh = function () {
      $("#currentHours").text(Hours.hours)
    }

    $(document).ready(function () {

      $("#resetButton").on("click", function (e) {
        e.preventDefault();

        $.ajax({
          dataType: "json",
          method: "DELETE",
          url: "/hours",
          success: function (resp) {
            console.log(resp)
            console.log(resp.hours)
            Hours.hours = resp.hours
            Hours.refresh()
          }
        })
      })

    });
})();
