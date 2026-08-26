#version 120

uniform sampler2D Sampler0; // Textura de entrada (framebuffer principal)
uniform float BlurRadius;   // Radio del blur

void main() {
    vec2 uv = gl_TexCoord[0].st;
    vec4 color = vec4(0.0);
    float total = 0.0;

    // Tamaño del paso para el desenfoque (ajustar para optimizar)
    float step = 1.0 / 512.0;

    // Desenfoque en un radio específico
    for (float x = -BlurRadius; x <= BlurRadius; x++) {
        for (float y = -BlurRadius; y <= BlurRadius; y++) {
            float weight = exp(-(x*x + y*y) / (2.0 * BlurRadius * BlurRadius));
            vec2 offset = vec2(x, y) * step;
            color += texture2D(Sampler0, uv + offset) * weight;
            total += weight;
        }
    }

    // Normalizar el color
    gl_FragColor = color / total;
}
