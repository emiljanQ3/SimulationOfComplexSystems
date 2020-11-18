from enum import Enum
from random import random


class AntType(Enum):
    worker = 0
    fighter = 1
    enemy = 2


class Ant:
    def __init__(self, currentNode, carriedObject, type):
        self.currentNode = currentNode
        self.carriedObject = carriedObject
        self.type = type
        self.age = 0

    def act(self, parameters):
        if self.type == AntType.worker:
            self.worker_act(self, parameters)
        elif self.type == AntType.fighter:
            self.fighter_act(parameters)
        elif self.type == AntType.enemy:
            self.enemy_act(self, parameters)

    def worker_act(self, parameters):
        new_node = random.choice(self.currentNode.neighbours)  # TODO how to access neighbours?
        self.currentNode.data.ants_at_node.remove(self)
        new_node.data.ants_at_node.append(self)

    def fighter_act(self):
        print("Worker act")

    def enemy_act(self, parameters):
        print("Worker act")
