# Carousel - Fast Register Rotation

Carousel is a Neovim plugin designed to simplify the process of pasting from registers. Instead of manually inspecting and selecting registers with `:reg`,  Carousel lets you quickly cycle through registers in a forward or backward direction and paste the current register for a specified amount of time.

## Features

- Fast rotation through registers with customizable keybindings.
- Easy pasting and undoing of register contents.
- A timer to automatically reset registers to their original state.

## Getting Started

1. **Installation**

   First, install the `carousel` plugin in Neovim using your preferred plugin manager. For example, with packer:

   ```
   use('davidrwoodland/carousel')
   ```
   In a required file, usually in an "after" folder, you can, but should not need to, add:

   ```
   require('carousel')
   ```

2. **Configuration**

   if you would like to change the default keymaps, you can add the following:
   ```
   require('carousel').setup({
      carouselTimer = 1500, -- 1.5 seconds is the default value
      keymapForward = '<M-p>', -- Alt-p is the default forward (or on Mac, 'Option+Command+p')
      keymapBackward = '<M-P>', -- Alt-P is the default backward (or on Mac, 'Option+Command+P')
   })
   ```

3. **Usage**

  To paste the contents of register 0, use the keybinding `<M-p>`. Pressing it again will undo the paste and paste the contents of register 1. You can cycle through the registers in a forward direction using this keybinding.

   To reverse the order and rotate backward through the registers (especially if you accidentally skipped past what you intended), use `<M-P>`.

   Once you land on the desired register, you can paste its contents using the standard `p` command, or you can continue using `<M-p>` or `<M-P>` to cycle through the registers.

   The timer value is used to reset the registers to what they were before Carousel was invoked. So if you can't paste what you wanted within 1.5 seconds, you can change the timer value to suit your needs.


# carousel
#### Video Demo:  <https://www.youtube.com/watch?v=d7j7msMr8RA>
#### Description:
For my CS50 final project, I decided to create an NVIM plugin written in Lua. My brother recommended NVIM to me, and I'm afraid I simply have not been able to exit ever since I loaded it up. Really, my only option was to write a plugin...

My plugin contains three Lua files: `carousel.lua`, `config.lua`, and `init.lua`, each stored in a tree of folders `/project/carousel/lua/carousel/files`. `init.lua` is a reserved name that is required to be loaded in NVIM, the contents of which are used to set up the plugin. The `M.setup` function takes `userConfig` as input and will configure the plugin to the default settings in `config.lua` or replace those values with user-specified ones.

`carousel.lua` contains the main functions used to rotate through registers. `M.carousel` moves forwards through registers 0-9, while `M.lesuorac` moves in the opposite direction. Each time those functions are called, a timer is started or reset through `M.startOrResetTimer`.

`Carousel` and `Lesuorac` save register 0 in a variable, and then each register reached by subsequent calls is put into register 0. The reason for this is that if you want to paste copies of the register reached, you can now spam `p` to paste register 0 until the timer runs out. At that point, all registers will be returned to their original state, preventing loss of information.

`M.emptyRegisterControl` is called inside `carousel` and `lesuorac`, respectively, to skip past any empty registers. `M.setTimer` is used to adjust the timer value, which defaults to 1.5 seconds.

Some issues I ran into are related to how NVIM itself handles plugins, which can be rather difficult to understand. For instance, passing values or functions from one file to another can create error messages on startup. My solution was not to require my `init.lua` file but to pass functions that `init.lua` could call to feed the value back to the other file. This required creating a specific function for the timer setup but results in a tidier plugin that won't throw any errors on NVIM startup.

In essence, I created this plugin because having access to the history of deleted lines is incredibly useful. There have been several instances where I've been in the midst of cleaning up a function, deleted something, and then realized I needed it or something similar. The process of typing :reg, sifting through lines of code, and then typing something like "7p" to print register 7 felt cumbersome and disrupted my workflow.

Being able to swiftly paste the code and view it in real-time keeps you in a state of flow. I hope the NVIM community finds value in this plugin. While it addresses a minor inconvenience, it has the potential to keep numerous engineers in the zone for a few extra minutes each day, ultimately saving thousands of hours over time.

NVIM feels like a superpower once you learn to use it.
