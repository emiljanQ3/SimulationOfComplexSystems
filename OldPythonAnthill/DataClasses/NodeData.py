from enum import Enum


class NodeType(Enum):
    basic = 0
    queen = 1
    exit = 2
    tunnel = 3


class NodeData:
    def __init__(self, type, capacity, length):
        self.ants_at_node = []
        self.capacity = capacity
        self.type = type
        self.length = length
