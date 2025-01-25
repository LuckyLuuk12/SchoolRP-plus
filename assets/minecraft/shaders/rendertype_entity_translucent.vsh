#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>

in vec3 Position, Normal;
in vec4 Color;
in vec2 UV0;
in ivec2 UV1, UV2;

uniform sampler2D Sampler0, Sampler1, Sampler2;

uniform mat4 ModelViewMat, ProjMat;
uniform int FogShape;

uniform vec3 Light0_Direction, Light1_Direction;

uniform float GlintAlpha;

out float vertexDistance;
out vec4 vertexColor, lightMapColor, overlayColor, normal;
out vec2 texCoord0, texCoord1;
out vec3 a, b;

vec3 getCubeSize(int cube, bool slim) {
    switch (cube) {
        case 0: // Head
        case 1: // Hat
            return vec3(8, 8, 8);
        case 2: // Left leg
        case 3: // Left pant
        case 10: // Right leg
        case 11: // Right pant
            return vec3(4, 12, 4);
        case 4: // Right arm
        case 5: // Right sleeve
        case 6: // Left arm
        case 7: // Left sleeve
            if (slim) {
                return vec3(3, 12, 4);
            } else {
                return vec3(4, 12, 4);
            }
        case 8: // Torso
        case 9: // Jacket
            return vec3(8, 12, 4);
    }
    return vec3(0,0,0);
}

vec2 getBoxUV(int cube) {
    switch(cube) {
        case 0: // Head
            return vec2(0, 0);
        case 1: // Hat
            return vec2(32, 0);
        case 2: // Left leg
            return vec2(16, 48);
        case 3: // Left pant
            return vec2(0, 48);
        case 4: // Right arm
            return vec2(40, 16);
        case 5: // Right sleeve
            return vec2(40, 32);
        case 6: // Left arm
            return vec2(32, 48);
        case 7: // Left sleeve
            return vec2(48, 48);
        case 8: // Torso
            return vec2(16, 16);
        case 9: // Jacket
            return vec2(16, 32);
        case 10: // Right leg
            return vec2(0, 16);
        case 11: // Right pant
            return vec2(0, 32);
    }
    return vec2(0, 0);
}

vec2 getUVOffset(int corner, vec3 cubeSize, float yOffset) {
    vec2 offset, uv;
    if (GlintAlpha != 1.0) {
        switch(corner / 4) {
            case 2: // Left
                offset = vec2(cubeSize.z + cubeSize.x, cubeSize.z);
                offset.y += yOffset;
                uv = vec2(cubeSize.z, cubeSize.y);
                break;
            case 4: // Right
                offset = vec2(0, cubeSize.z);
                offset.y += yOffset;
                uv = vec2(cubeSize.z, cubeSize.y);
                break;
            case 0: // Up
                offset = vec2(cubeSize.z, 0);
                uv = vec2(cubeSize.x, cubeSize.z);
                break;
            case 1: // Down
                offset = vec2(cubeSize.z + cubeSize.x, 0 + cubeSize.z);
                uv = vec2(cubeSize.x, -cubeSize.z);
                break;
            case 3: // Front
                offset = vec2(cubeSize.z, cubeSize.z);
                offset.y += yOffset;
                uv = vec2(cubeSize.x, cubeSize.y);
                break;
            case 5: // Back
                offset = vec2(2 * cubeSize.z + cubeSize.x, cubeSize.z);
                offset.y += yOffset;
                uv = vec2(cubeSize.x, cubeSize.y);
                break;
        }
    } 
	else {
        switch(corner / 4) {
            case 0: // Left
                offset = vec2(cubeSize.z + cubeSize.x, cubeSize.z);
                offset.y += yOffset;
                uv = vec2(cubeSize.z, cubeSize.y);
                break;
            case 1: // Right
                offset = vec2(0, cubeSize.z);
                offset.y += yOffset;
                uv = vec2(cubeSize.z, cubeSize.y);
                break;
            case 2: // Up
                offset = vec2(cubeSize.z, 0);
                uv = vec2(cubeSize.x, cubeSize.z);
                break;
            case 3: // Down
                offset = vec2(cubeSize.z + cubeSize.x, 0 + cubeSize.z);
                uv = vec2(cubeSize.x, -cubeSize.z);
                break;
            case 4: // Front
                offset = vec2(cubeSize.z, cubeSize.z);
                offset.y += yOffset;
                uv = vec2(cubeSize.x, cubeSize.y);
                break;
            case 5: // Back
                offset = vec2(2 * cubeSize.z + cubeSize.x, cubeSize.z);
                offset.y += yOffset;
                uv = vec2(cubeSize.x, cubeSize.y);
                break;
        }
    }

    switch(corner % 4) {
        case 0:
            offset += vec2(uv.x, 0);
            break;
        case 2:
            offset += vec2(0, uv.y);
            break;
        case 3:
            offset += vec2(uv.x, uv.y);
            break;
    }

    return offset;
}

bool isExcluded() {
    vec4 texture = texture(Sampler0, vec2(5., 57.) / 64.);
    return texture.a == (39./255.) && texture.r == (109./255.) && texture.g == (173./255.) && texture.b == (111./255.);
}

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    a = b = vec3(0);
    if(textureSize(Sampler0, 0) == vec2(64, 64) && UV0.y <= 0.25 && (gl_VertexID / 24 != 6 || UV0.x <= 0.5) && (!isExcluded())) {

        switch(gl_VertexID % 4) {
            case 0: a = vec3(UV0, 1); break;
            case 2: b = vec3(UV0, 1); break;
        }
        int cube = (gl_VertexID / 24) % 12;
        vec3 slimPixelColour = texture(Sampler0, vec2(55.0, 20.0) / 64.).rgb;
        bool slim = slimPixelColour.r + slimPixelColour.g + slimPixelColour.b == 0.0;
        int corner = gl_VertexID % 24;
        vec3 cubeSize = getCubeSize(cube, slim) / 64;
        vec2 boxUV = getBoxUV(cube) / 64;
        vec2 uvOffset = getUVOffset(corner, cubeSize, 0);
        texCoord0 = boxUV + uvOffset;

        // Debugging output
        // Uncomment the following line to output UV coordinates for debugging
        // printf("cube: %d, boxUV: %f, %f, uvOffset: %f, %f, texCoord0: %f, %f\n", cube, boxUV.x, boxUV.y, uvOffset.x, uvOffset.y, texCoord0.x, texCoord0.y);
    } else {
        texCoord0 = UV0;
    }

    vertexDistance = length((ModelViewMat * vec4(Position, 1.0)).xyz);
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color);
    lightMapColor = texelFetch(Sampler2, UV2 / 16, 0);
    overlayColor = texelFetch(Sampler1, UV1, 0);
    texCoord1 = UV0;
    normal = ProjMat * ModelViewMat * vec4(Normal, 0.0);
}