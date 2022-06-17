const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#150f0d", /* black   */
  [1] = "#D89664", /* red     */
  [2] = "#C67045", /* green   */
  [3] = "#D7A292", /* yellow  */
  [4] = "#AE704F", /* blue    */
  [5] = "#c0574a", /* magenta */
  [6] = "#BB926A", /* cyan    */
  [7] = "#d9c8ce", /* white   */

  /* 8 bright colors */
  [8]  = "#978c90",  /* black   */
  [9]  = "#D89664",  /* red     */
  [10] = "#C67045", /* green   */
  [11] = "#D7A292", /* yellow  */
  [12] = "#AE704F", /* blue    */
  [13] = "#eb614d", /* magenta */
  [14] = "#BB926A", /* cyan    */
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
