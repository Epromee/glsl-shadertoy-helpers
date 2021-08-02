
/** My custom tiny glsl library for shadertoy experiments **/

#define PI 3.1415926535897932384626433832795

float CPI = PI;

/** Generalized sigmoid **/
float sigmaGenRoot(float x, float power) {
    
    return (x / pow(sqrt(pow(x * x, power) + 1.), 1. / power));
}

/** Sigmoid function which clamps X between -1 and 1, with f(x)~x at x->0 point **/
float sigmaSquareRoot(float x) {

    return (x / sqrt(x * x + 1.));
}

/** Clamps x between low and high values in a soft way using a square root sigmoid function **/
float sigmaClamp(float x, float low, float high )
{

    float width = (high - low) / 2.0;
    float midPoint = (high + low) / 2.0;

    x = (x - midPoint) / width; //transpose
    
    x = sigmaSquareRoot(x); //squash [works on -1 to 1 span that's why we transpose]
    
    x = x * width + midPoint; // transpose back

    return x;
}

/** Like the previous, but returns value from 0 to 1 instead of from low to high **/
float sigmaBooleanSpan(float x, float low, float high ) {

    float width = (high - low) / 2.0;
    float midPoint = (high + low) / 2.0;

    x = (x - midPoint) / width; //transpose
    
    x = sigmaSquareRoot(x); //squash [works on -1 to 1 span that's why we transpose]
    
    x = x * 0.5 + 0.5; // transpose back but to 0 vs 1 span

    return x;
}

/** Sign aware pow - pows the abs of x and then attaches it's sign back **/
float saPow(float x, float order) {

    float rx = (x < 0. ? -x : x);
    
    rx = pow(rx, order);
    
    return (x < 0. ? -rx : rx);
}

/* Drags x around a pivot point */
float dragAround(float x, float pivot, float mul) {

    x -= pivot;
    x *= mul;
    x += pivot;
    
    return x;
}

/* Selects between left and right linearly, using a zero to one knob */
float sel(float knob, float l, float r) {

    return l + knob * (r - l);
}

/* Smoothes 0 to 1 line to a 0 to 1 sinewave */
float sinSmooth(float x) {

    x = x * 2. - 1.;
    x = sin(x * PI / 2.);
    x = (x + 1.) / 2.;
    return x;
}

