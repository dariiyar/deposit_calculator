DropdownInit = {
    init: function() {
        $('.dropdown-item').click(function () {
            let item =$(this);
            let item_parent = item.parent('.dropdown-menu');
            item_parent.siblings('input').val(item.data('value'));
            item_parent.siblings('.btn').text(item.text());
        });
    }
}