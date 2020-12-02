from enum import Enum
import random


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

    def act(self, graph, node_data_obs):
        if self.type == AntType.worker:
            self.worker_act(graph, node_data_obs)
        elif self.type == AntType.fighter:
            self.fighter_act(graph, node_data_obs)
        elif self.type == AntType.enemy:
            self.enemy_act(graph, node_data_obs)

    def worker_act(self, graph, node_data_obs):
        new_node = random.choice(list(graph.neighbors(self.currentNode)))
        node_data_obs[self.currentNode].ants_at_node.remove(self)
        node_data_obs[new_node].ants_at_node.append(self)
        self.currentNode = new_node

    def fighter_act(self, graph, node_data_obs):
        print("Fighter act")

    def enemy_act(self, graph, node_data_obs):
        print("Enemy act")
