The UIWebView component comes in handy for loading HTML content or displaying documents such as PDF, Excel, Word, PowerPoint, Keynote, Numbers and Pages.

The implementation of UIWebView is based on WebKit, which is a multi-platform open source web browser engine. However, UIWebView doesn't provide an obvious way for configuring the functionality of the rendering engine. For example, in case of memory pressure on iOS, WebKit will use the temporary folder to cache images. For security reasons, one might want to disable this behavior, but Apple doesn't provide a documented method on how to do so. 

Fortunately, when the UIWebView component is initialized, all WebKit properties are loaded using NSUserDefaults. By replacing the method -[NSUserDefaults objectForKey:] with our own implementation, we can get a complete list of settings that can be used to customize the behavior of WebKit.

http://objectiveself.com/post/84817251648/uiwebviews-hidden-properties
