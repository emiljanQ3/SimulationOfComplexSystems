from random import random

from DataClasses.Ant import AntType, Ant

class Model:
    def __init__(self, graph, numWorkers, numFighters, foodProbability, deathProbability, raidFrequency, meanRaidSize, raidStandardDeviation):
        self.graph = graph
        self.foodProbability = foodProbability
        self.deathProbability = deathProbability
        self.raidFrequency = raidFrequency
        self.meanRaidSize = meanRaidSize
        self.raidStandardDeviation = raidStandardDeviation

        self.ants = self.make_ants(numWorkers, numFighters)


    def make_ants(self, num_workers, num_fighters):
        ants = []
        for i in range(num_workers):
            node = random.choice(self.graph)
            ant = Ant(node, None, AntType.worker, 0)
            ants.append(ant)

        for i in range(num_fighters):
            node = random.choice(self.graph)
            ant = Ant(node, None, AntType.fighter, 0)
            ants.append(ant)

        return ants

    def sim_step(self):
        for ant in self.ants:
            ant.act(None)