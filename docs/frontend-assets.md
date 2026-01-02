# Bolt Agent Documentation

This document provides guidance for AI agents working on the Mautic codebase.

## Frontend Asset Management

### Build Process

To compile and minify frontend assets, run the following command:

```bash
npm run build
```

This command performs two main tasks:

1.  **Compiles LESS to CSS**: It processes all `.less` files located in `app/bundles/**/Assets/css` and `plugins/**/Assets/css`, converting them into standard CSS files.
2.  **Minifies CSS**: It takes the compiled CSS files, removes unnecessary characters (like whitespace and comments), and saves them with a `.min.css` extension.

### Asset Loading in Production

In the `prod` environment, the `AssetsHelper` service is configured to automatically serve minified CSS assets. For any given stylesheet, the system first checks for the existence of a corresponding `.min.css` file. If a minified version is found, it is used in place of the original, unminified file. This behavior is designed to improve performance by reducing the size of assets transferred over the network.

When adding or modifying CSS, be sure to run the `npm run build` command to ensure that your changes are properly compiled and minified for the production environment.
