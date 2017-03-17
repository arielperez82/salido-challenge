function reloadData(resources) {
  if (resources === 'brands') {
    $.each(['locations', 'menu_items', 'order_types'], function(index, value) {
      loadData(value);
    })
  } else {
    loadData('day_parts');
  }
}

function loadData(resources) {
  var targetId = '#_' + resources.slice(0, -1) + '_id';

  if ($('#_brand_id').val() === '') {
    return fillValues($(targetId), []);
  };

  var baseURL = '/brands/' + $('#_brand_id').val();
  if (resources !== 'day_parts') {
    baseURL += '/' + resources;
  } else {
    if ($('#_location_id').val() === '') {
      return fillValues($(targetId), []);
    };

    baseURL += '/locations/' + $('#_location_id').val() + '/' +  resources;
  }

  $.get(baseURL,{}, function(data) { fillValues($(targetId), data); }, 'json');

  function fillValues(select, data) {
    select.find('option').remove();
    select.append('<option></option>');
    $.each(data, function(index, resource) {
      select.append('<option value="' + resource.id + '">' + resource.name + '</option>');
    });
  }
}

function updateMenuItemPrice() {
  var brandId = $('#_brand_id').val();
  var locationId = $('#_location_id').val();

  if (brandId && locationId) {
    var url = '/brands/' + brandId + '/locations/' + locationId + '/menu_item_price?'
    params = {
      menu_item_id: $('#_menu_item_id').val(),
      order_type_id: $('#_order_type_id').val()
    }
    if (dayPartId = $('#_day_part_id').val()) {
      params.day_part_id = dayPartId;
    }

    var keyValuePairs = [];
    $.each(params, function(key,value) {
      keyValuePairs.push(key + '=' + value);
    });

    url += keyValuePairs.join('&');

    $.get(
      url,
      {},
      function(data) {
        $('#price_level').text(getPriceLevel(data));
        $('#price').text(getPrice(data));
      },
      'json'
    );
  }

  function getPrice(data) {
    return (data.price != null) ? '$' + Number(data.price).toFixed(2) : '-';
  }

  function getPriceLevel(data) {
    return (data.price_level != null) ? data.price_level.name : 'Not configured';
  }
}