const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0a0409", /* black   */
  [1] = "#9B2E33", /* red     */
  [2] = "#C9473A", /* green   */
  [3] = "#99374F", /* yellow  */
  [4] = "#B14856", /* blue    */
  [5] = "#DD615B", /* magenta */
  [6] = "#F79D62", /* cyan    */
  [7] = "#f5d8a6", /* white   */

  /* 8 bright colors */
  [8]  = "#ab9774",  /* black   */
  [9]  = "#9B2E33",  /* red     */
  [10] = "#C9473A", /* green   */
  [11] = "#99374F", /* yellow  */
  [12] = "#B14856", /* blue    */
  [13] = "#DD615B", /* magenta */
  [14] = "#F79D62", /* cyan    */
  [15] = "#f5d8a6", /* white   */

  /* special colors */
  [256] = "#0a0409", /* background */
  [257] = "#f5d8a6", /* foreground */
  [258] = "#f5d8a6",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
