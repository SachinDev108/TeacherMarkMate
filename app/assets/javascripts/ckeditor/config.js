CKEDITOR.editorConfig = function (config) {
  // ... other configuration ...

  config.toolbar_mini = [
    ["Bold",  "Italic",  "Underline", "Font"],
  ];
  config.toolbar = "mini";
  config.height = 100;        // 500 pixels high.
	config.height = '5em';
	config.removePlugins = 'elementspath';
config.resize_enabled = false;

  // ... rest of the original config.js  ...
}

CKEDITOR.config.autoParagraph = false;

CKEDITOR.config.nomargin_style = {
    element: ['body'],
    styles: { 'margin': '0'}
};