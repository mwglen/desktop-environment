const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#150f0d", /* black   */
  [1] = "#AE704F", /* red     */
  [2] = "#C67045", /* green   */
  [3] = "#BB926A", /* yellow  */
  [4] = "#D89664", /* blue    */
  [5] = "#B97490", /* magenta */
  [6] = "#D7A292", /* cyan    */
  [7] = "#d9c8ce", /* white   */

  /* 8 bright colors */
  [8]  = "#978c90",  /* black   */
  [9]  = "#AE704F",  /* red     */
  [10] = "#C67045", /* green   */
  [11] = "#BB926A", /* yellow  */
  [12] = "#D89664", /* blue    */
  [13] = "#B97490", /* magenta */
  [14] = "#D7A292", /* cyan    */
  [15] = "#d9c8ce", /* white   */

  /* special colors */
  [256] = "#150f0d", /* background */
  [257] = "#d9c8ce", /* foreground */
  [258] = "#d9c8ce",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
