# dropdown.js - A halley.js library

A simple way to implement dropdown in your project.

![](https://i.imgur.com/Q3dUyca.gif)

## Usage
### Single istance

```ES6
import dropdown from 'halley.js/packages/lib/dropdown';

dropdown('#my-dropdown'); // Here you can pass an element or a selector
```

### Multiple instances
```ES6
  import { init } from 'halley.js/packages/lib/dropdown';

  init('.my-dropdown'); // Here you can pass an selector or an array of elements
```

### CSS
you need to import module css
```SCSS
  @import 'node_modules/halley.js/packages/lib/dropdown/dist/dropdown.css';
```

### Options
You can pass a settings object, values ​​shown here are the defaults.

```ES6

  init('.my-dropdown', {
    onClose: Function, // callback on close dropdown
    onOpen: Function, // callback on open dropdown
    selectors: {
      button: '[halley-dropdown-button]',
      list: '[halley-dropdown-list]',
    },
    activeButton: 'active' // class inserted in button when dropdown is open
  })
```

### Properties
  - `options` - Here you have configuration items used to create the instance.
  - `elements` - Here you have the used elements.


### Methods
  - `open` - Method that opens dropdown
  - `close` - Method that closes dropdown


### Calbacks
These callbacks get an event as a parameter.

- `onOpen` - Function called when opening dropdown
- `onClose` - Function called when closing dropdown

### HTML Markup
The module needs an HTML structure to work, following this structure is essential for the module to work perfectly.

```html
  <div halley-dropdown>
    <button halley-dropdown-button>Halley</button>
    <div halley-dropdown-list>
      <ul>
        <li>
          <a href="#halley">Halley</a>
        </li>
      </ul>
    </div>
  </div>
```


[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/built-by-developers.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/made-with-javascript.svg)](https://forthebadge.com)

MIT. © 2020 [NovaHaus](https://www.novahaus.com.br)
