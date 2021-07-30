import tinymce from 'tinymce/tinymce'
import 'tinymce/themes/silver/theme'
import 'tinymce/plugins/table'
import 'tinymce/plugins/lists';
import 'tinymce/skins/ui/oxide/content.min.css';
import 'tinymce/skins/ui/oxide/skin.min.css';

// if you're using a language file, you can place its content here
// export { tinyMce };

document.addEventListener('turbolinks:load', function () {
  tinymce.init({
    selector: 'textarea.tinymce',
    skin: false,
    // content_css: 'tinymce/skins/content/default/content.min.css',

    // some other settings, like height, language,         // order of buttons on your toolbar etc.
    plugins: ['table', 'lists'],

  });
})
