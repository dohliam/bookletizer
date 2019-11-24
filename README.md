# Bookletizer - Create foldable booklets from any PDF

Bookletizer takes any standard PDF and turns it into a simple booklet suitable for printing on a regular printer. An example booklet created by Bookletizer can be found [here](https://storybookscanada.ca/editions/booklet/en/en-0141_chicken-booklet.pdf).

Bookletizer is a wrapper for `pdfjam` and `pdftk` that makes creating printable, foldable booklets out of any PDF as easy as possible. It is designed to streamline and automate the often tedious process of designing and paginating booklets. The resulting booklets do not require any staples or binding -- just print on double-sided paper and fold the pages together down the middle.

The main benefit of using Bookletizer is that it automatically handles pagination of booklets -- more specifically, it is able to insert the correct number of blank pages into the PDF to allow for a 2-up booklet layout. While this is possible to do manually or on a one-off basis with some commercial products, that approach does not scale to the production of hundreds or thousands of booklets, which was required for the [Global Storybooks](https://globalstorybooks.net/) project. Bookletizer solves that problem and now forms part of the regular PDF toolchain for the project, but can be easily used to convert any PDF without additional configuration.

## Example

The first page of a typical booklet pdf looks something like this (yes, it's supposed to be "upside-down"):

![image](https://user-images.githubusercontent.com/9295750/69487895-faeb1080-0e16-11ea-9919-7835d22bd1b7.png)

This arrangement allows both sides of a single booklet page to be printed together in the right order. When printed on a duplex (double-sided) printer, the pages will be automatically re-oriented to their correct positions.

## Requirements

* `pdftk`
  * Note: on recent versions of Debian and Ubuntu, the `pdftk` package has been removed in an eventual move to a new java-based version
  * Be aware that there are issues with installing `pdftk` as a snap package, including the inability to open files located anywhere other than the the user's home directory; [this answer](https://askubuntu.com/a/1046476) on AskUbuntu provides a straightforward way to install the program on Ubuntu LTS
* `pdfbook` (from `pdfjam`)
  * Available as part of `texlive-extra-utils` package from most distros or follow directions on [pdfjam home page](https://github.com/DavidFirth/pdfjam)

## Installation

No installation required -- once the [requirements](#requirements) have been satisfied, just download or clone this repository and [run the script](#usage) directly from the project folder.

## Usage

To create a simple, foldable booklet, just provide the name of an existing PDF:

`./bookletizer.rb "my_document.pdf"`

(Where `my_document.pdf` is the path to an existing PDF on your local machine.)

The resulting PDF will be located in the `output` folder, with the filename `my_document-booklet.pdf`.

## Paper size

Output defaults to A4 standard paper size. To specify US Letter size instead, use the `-l` option:

* `-l`, `--letter-size`: _Specify paper size as US letter (default A4)_

It is assumed -- but not necessary -- that the input file is in portrait orientation. Documents in landscape orientation will still work, but may look odd as they will be constrained to the horizontal width of the (portrait-oriented) booklet pages.

## License

MIT.
