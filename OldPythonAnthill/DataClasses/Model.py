import random

from DataClasses.Ant import AntType, Ant

class Model:
    def __init__(self, graph, node_data_obs, numWorkers, numFighters, foodProbability, deathProbability, raidFrequency, meanRaidSize, raidStandardDeviation):
        self.graph = graph
        self.node_data_obs = node_data_obs
        self.foodProbability = foodProbability
        self.deathProbability = deathProbability
        self.raidFrequency = raidFrequency
        self.meanRaidSize = meanRaidSize
        self.raidStandardDeviation = raidStandardDeviation
        self.ants = []
        self.make_ants(numWorkers, numFighters)


    def make_ants(self, num_workers, num_fighters):

        for i in range(num_workers):
            node = random.choice(list(self.graph.nodes))
            ant = Ant(node, None, AntType.worker)
            self.ants.append(ant)
            self.node_data_obs[node].ants_at_node.append(ant)

        for i in range(num_fighters):
            node = random.choice(self.graph)
            ant = Ant(node, None, AntType.fighter)
            self.ants.append(ant)
            self.node_data_obs[node].ants_at_node.append(ant)


    def sim_step(self):
        for ant in self.ants:
            ant.act(self.graph, self.node_data_obs)