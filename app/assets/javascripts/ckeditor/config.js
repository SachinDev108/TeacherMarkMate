CKEDITOR.editorConfig = function (config) {
  // ... other configuration ...

  config.toolbar_mini = [
    ["Bold",  "Italic",  "Underline", "Font", "FontSize" ],
  ];
  config.toolbar = "mini";

  // ... rest of the original config.js  ...
}

CKEDITOR.config.autoParagraph = false;