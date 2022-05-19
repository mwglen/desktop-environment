const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0d0f12", /* black   */
  [1] = "#6C3E43", /* red     */
  [2] = "#5A4147", /* green   */
  [3] = "#754245", /* yellow  */
  [4] = "#8F4548", /* blue    */
  [5] = "#B64F56", /* magenta */
  [6] = "#BF555B", /* cyan    */
  [7] = "#ddb4b8", /* white   */

  /* 8 bright colors */
  [8]  = "#9a7d80",  /* black   */
  [9]  = "#6C3E43",  /* red     */
  [10] = "#5A4147", /* green   */
  [11] = "#754245", /* yellow  */
  [12] = "#8F4548", /* blue    */
  [13] = "#B64F56", /* magenta */
  [14] = "#BF555B", /* cyan    */
  [15] = "#ddb4b8", /* white   */

  /* special colors */
  [256] = "#0d0f12", /* background */
  [257] = "#ddb4b8", /* foreground */
  [258] = "#ddb4b8",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
