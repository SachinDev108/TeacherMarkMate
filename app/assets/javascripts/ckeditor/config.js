CKEDITOR.editorConfig = function (config) {
  // ... other configuration ...

  config.toolbar_mini = [
    ["Bold",  "Italic",  "Underline", "Font", "FontSize"],
  ];
  config.toolbar = "mini";
  config.height = 100;        // 500 pixels high.
	config.height = '5em';
	config.removePlugins = 'elementspath';
	config.resize_enabled = false;
	config.enterMode = CKEDITOR.ENTER_BR

  // ... rest of the original config.js  ...
}

CKEDITOR.config.font_defaultLabel = 'Comic Sans MS';
CKEDITOR.config.fontSize_defaultLabel = '10'; 

CKEDITOR.config.autoParagraph = false;

CKEDITOR.config.nomargin_style = {
    element: ['body'],
    styles: { 'margin': '0'}
};