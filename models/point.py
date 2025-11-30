import json
import os

class Point:
    def __init__(self, id, lat, lng, name, description):
        self.id = id
        self.lat = lat
        self.lng = lng
        self.name = name
        self.description = description

    def to_dict(self):
        return {
            'id': self.id,
            'lat': self.lat,
            'lng': self.lng,
            'name': self.name,
            'description': self.description
        }

    @classmethod
    def from_dict(cls, data):
        return cls(**data)

class PointModel:
    FILE_PATH = 'data/points.json'

    def __init__(self):
        self.points = self._load()

    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            return [Point.from_dict(item) for item in json.load(f)]

    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            json.dump([p.to_dict() for p in self.points], f, indent=4)

    def get_all(self):
        return self.points

    def add(self, point):
        self.points.append(point)
        self._save()