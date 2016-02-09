;(function () {
    if (typeof window.Hours === "undefined" ) {
        window.Hours = {};
    }

    Hours.hours = {};
    Hours.WAGE = 15;

    Hours.refresh = function () {
      // $("#currentHours").text(Hours.hours)
    }

    Hours.refreshPay = function () {
      // $("#currentPay").text("$" + (Hours.hours * Hours.WAGE))
    }

    Hours.deleteHours = function () {
      $.ajax({
        dataType: "json",
        method: "DELETE",
        url: "/hours",
        success: function (resp) {
          Hours.hours = resp.hours;
          Hours.refresh();
          Hours.refreshPay();
        }
      });
    }

    Hours.getHours = function () {
      $.ajax({
        dataType: "json",
        method: "GET",
        url: "/hours",
        success: function (resp) {
          Hours.hours = resp.hours;
          Hours.refresh();
          Hours.refreshPay();
        }
      });
    }

    Hours.postHours = function () {
      $.ajax({
        dataType: 'json',
        method: "POST",
        url: "/hours",
        processData: false,
        data: JSON.stringify(Hours.hours),
        success: function (resp) {
          Hours.hours = resp.hours;
          Hours.refresh();
          Hours.refreshPay();
        }
      })
    }

    $(document).ready(function () {
      Hours.getHours();

      $("#resetButton").on("click", function (e) {
        e.preventDefault();
        Hours.deleteHours();
      });

      $("#addHours").on("submit", function (e, f, g) {
        e.preventDefault();
        Hours.hours = $("#addHours").serializeJSON();

        Hours.postHours();
      })
    });
})();
