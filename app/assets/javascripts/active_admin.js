//= require active_admin/base
//= require activeadmin/quill_editor/quill
//= require activeadmin/quill_editor_input
//= require chosen-jquery


(function () {
    $(function () {
        return $("#active_admin_content select").chosen();
    });

}).call(this);
