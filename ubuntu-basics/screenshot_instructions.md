# Taking Screenshots on Ubuntu Without a Print Screen Key

Not every keyboard has a dedicated **Print Screen** key, especially on laptops and compact layouts. Ubuntu still offers several ways to capture and share screenshots. This guide explains how to take screenshots on a DGX without needing a special key.

## Use the built‑in screenshot tool

On GNOME‑based desktops (the default on DGX), pressing **`Super + Shift + S`** opens a screenshot/recording overlay. The **Super** key is the Windows or Command key on most keyboards. Once the overlay appears you can:

* Click and drag to capture a rectangular area.
* Select the window or full‑screen options on the top bar.
* Choose whether to copy to the clipboard or save to the `Pictures/Screenshots` directory.

After capturing, simply paste into chat or a document with `Ctrl + V` if you chose “Copy to clipboard.”

## Create custom shortcuts

You can bind your own key combinations to screenshot actions. To create a custom shortcut:

1. Open the keyboard settings panel:

   ```bash
   gnome-control-center keyboard
   ```

2. Scroll down to **Screenshots** and find the actions for **Take screenshot**, **Area screenshot**, **Copy screenshot to clipboard**, etc.
3. Click the shortcut, press the new key combination you want to assign (for example `Ctrl + Shift + S`), and then close the settings window.

Now you can take screenshots without relying on a Print Screen key.

## Use the `gnome-screenshot` command

If you prefer using the command line or need to script screenshot capture, GNOME provides a command‑line utility:

* **Capture the entire screen and save it to your Pictures folder:**

  ```bash
  gnome-screenshot
  ```

* **Capture a selected area and copy it to the clipboard:**

  ```bash
  gnome-screenshot -ac
  ```

* **Capture the current window and copy to clipboard:**

  ```bash
  gnome-screenshot -wc
  ```

You can assign these commands to custom shortcuts as described above, or run them directly from the terminal.

## Alternatives

If you prefer more control or annotation features, consider installing a dedicated screenshot tool such as **Flameshot**. It provides a rich interface for editing and annotating screenshots before saving or copying them.

To install Flameshot:

```bash
sudo apt install flameshot -y
```

Run it with:

```bash
flameshot gui
```

You can then bind Flameshot to a key combination via the keyboard settings.