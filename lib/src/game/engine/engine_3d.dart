import 'dart:math';
import 'package:flutter/material.dart';

class Vector3D {
  double x, y, z;
  Vector3D(this.x, this.y, this.z);

  Vector3D operator +(Vector3D v) => Vector3D(x + v.x, y + v.y, z + v.z);
  Vector3D operator -(Vector3D v) => Vector3D(x - v.x, y - v.y, z - v.z);
  Vector3D operator *(double s) => Vector3D(x * s, y * s, z * s);

  double dot(Vector3D v) => x * v.x + y * v.y + z * v.z;

  Vector3D cross(Vector3D v) {
    return Vector3D(
      y * v.z - z * v.y,
      z * v.x - x * v.z,
      x * v.y - y * v.x,
    );
  }

  double get length => sqrt(x * x + y * y + z * z);

  Vector3D normalize() {
    double l = length;
    if (l == 0) return Vector3D(0, 0, 0);
    return Vector3D(x / l, y / l, z / l);
  }
}

class Face3D {
  List<Vector3D> vertices;
  Color color;
  Vector3D normal;
  double depth = 0;

  Face3D(this.vertices, this.color) : normal = _calculateNormal(vertices);

  static Vector3D _calculateNormal(List<Vector3D> v) {
    if (v.length < 3) return Vector3D(0, 1, 0);
    Vector3D v1 = v[1] - v[0];
    Vector3D v2 = v[2] - v[0];
    return v1.cross(v2).normalize();
  }
}

class Camera3D {
  Vector3D position;
  double pitch;
  double yaw;
  double fov;

  Camera3D({
    required this.position,
    this.pitch = 0.20,
    this.yaw = 0.0,
    this.fov = 400.0,
  });

  Offset project(Vector3D point, Size screenSize) {
    double dx = point.x - position.x;
    double dy = point.y - position.y;
    double dz = point.z - position.z;

    double cosY = cos(yaw), sinY = sin(yaw);
    double cosP = cos(pitch), sinP = sin(pitch);

    double x1 = dx * cosY - dz * sinY;
    double z1 = dx * sinY + dz * cosY;

    double y2 = dy * cosP - z1 * sinP;
    double z2 = dy * sinP + z1 * cosP;

    if (z2 <= 2.0) z2 = 2.0;

    // Centered projection raised above bottom edge
    double screenX = (x1 * fov / z2) + screenSize.width / 2;
    double screenY = (-y2 * fov / z2) + screenSize.height / 2 - 30;

    return Offset(screenX, screenY);
  }
}

class Model3DFactory {
  static List<Face3D> createBox(Vector3D pos, Vector3D scale, Color color) {
    double sx = scale.x / 2;
    double sy = scale.y / 2;
    double sz = scale.z / 2;

    List<Vector3D> v = [
      pos + Vector3D(-sx, -sy, -sz),
      pos + Vector3D(sx, -sy, -sz),
      pos + Vector3D(sx, sy, -sz),
      pos + Vector3D(-sx, sy, -sz),
      pos + Vector3D(-sx, -sy, sz),
      pos + Vector3D(sx, -sy, sz),
      pos + Vector3D(sx, sy, sz),
      pos + Vector3D(-sx, sy, sz),
    ];

    Vector3D sunLight = Vector3D(0.4, 1.0, -0.6).normalize();

    List<Face3D> rawFaces = [
      Face3D([v[0], v[1], v[2], v[3]], color),
      Face3D([v[5], v[4], v[7], v[6]], color),
      Face3D([v[4], v[0], v[3], v[7]], color),
      Face3D([v[1], v[5], v[6], v[2]], color),
      Face3D([v[3], v[2], v[6], v[7]], color),
      Face3D([v[4], v[5], v[1], v[0]], color),
    ];

    for (var face in rawFaces) {
      double lightIntensity = (face.normal.dot(sunLight) * 0.45 + 0.55).clamp(0.25, 1.0);
      int r = ((color.r * 255.0).round() * lightIntensity).toInt().clamp(0, 255);
      int g = ((color.g * 255.0).round() * lightIntensity).toInt().clamp(0, 255);
      int b = ((color.b * 255.0).round() * lightIntensity).toInt().clamp(0, 255);
      face.color = Color.fromRGBO(r, g, b, 1.0);
    }

    return rawFaces;
  }

  static List<Face3D> createPyramid(Vector3D pos, Vector3D scale, Color color) {
    double sx = scale.x / 2;
    double sz = scale.z / 2;

    Vector3D top = pos + Vector3D(0, scale.y, 0);
    Vector3D v0 = pos + Vector3D(-sx, 0, -sz);
    Vector3D v1 = pos + Vector3D(sx, 0, -sz);
    Vector3D v2 = pos + Vector3D(sx, 0, sz);
    Vector3D v3 = pos + Vector3D(-sx, 0, sz);

    return [
      Face3D([v0, v1, top], color),
      Face3D([v1, v2, top], color.withValues(alpha: 0.9)),
      Face3D([v2, v3, top], color.withValues(alpha: 0.8)),
      Face3D([v3, v0, top], color.withValues(alpha: 0.85)),
    ];
  }

  static List<Face3D> createOrganic3DCatMesh(Vector3D pos, double runAnimAngle, bool isJumping, Color color) {
    double jumpY = isJumping ? 50.0 : 0.0;
    Vector3D catPos = pos + Vector3D(0, jumpY, 0);

    List<Face3D> catFaces = [];

    // 1. Sleek Cat Torso
    catFaces.addAll(createBox(catPos + Vector3D(0, 18, 0), Vector3D(22, 20, 32), color));

    // 2. Rounded Cat Head
    catFaces.addAll(createBox(catPos + Vector3D(0, 36, 14), Vector3D(20, 20, 20), color));

    // 3. Pointed Cat Ears (3D Pyramids)
    catFaces.addAll(createPyramid(catPos + Vector3D(-6, 50, 14), Vector3D(6, 12, 6), Colors.pinkAccent));
    catFaces.addAll(createPyramid(catPos + Vector3D(6, 50, 14), Vector3D(6, 12, 6), Colors.pinkAccent));

    // 4. Cat Eyes & Whiskers
    catFaces.addAll(createBox(catPos + Vector3D(-5, 38, 24), Vector3D(4, 4, 2), Colors.black));
    catFaces.addAll(createBox(catPos + Vector3D(5, 38, 24), Vector3D(4, 4, 2), Colors.black));

    // 5. Silver Blossom Charm Pendant
    catFaces.addAll(createBox(catPos + Vector3D(0, 26, 16), Vector3D(5, 5, 2), Colors.cyanAccent));

    // 6. Jointed 4 Legs with Animated Gait Cycle
    double legOffset = sin(runAnimAngle) * 12;
    catFaces.addAll(createBox(catPos + Vector3D(-9, 2 + legOffset, 12), Vector3D(5, 14, 5), color));
    catFaces.addAll(createBox(catPos + Vector3D(9, 2 - legOffset, 12), Vector3D(5, 14, 5), color));
    catFaces.addAll(createBox(catPos + Vector3D(-9, 2 - legOffset, -12), Vector3D(5, 14, 5), color));
    catFaces.addAll(createBox(catPos + Vector3D(8, 2 + legOffset, -10), Vector3D(5, 14, 5), color));

    // 7. Waving Cat Tail
    double tailWiggle = sin(runAnimAngle * 0.5) * 6;
    catFaces.addAll(createBox(catPos + Vector3D(tailWiggle, 22, -22), Vector3D(4, 18, 4), color));

    // 8. Katana Blade in Hand
    catFaces.addAll(createBox(catPos + Vector3D(15, 30, 18), Vector3D(2, 2, 42), Colors.cyanAccent));

    return catFaces;
  }
}
