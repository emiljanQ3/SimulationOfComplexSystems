import networkx as nx
from DataClasses.NodeData import NodeData, NodeType
from DataClasses.Model import Model
import matplotlib.pyplot as plt

# Create graph

graph = nx.Graph()

chambers = []
for i in range(4):
    chambers.append(NodeData(NodeType.basic, 10, None))

tunnels = []
for i in range(4):
    tunnels.append(NodeData(NodeType.tunnel, 5, 3))

node_data_obs = chambers + tunnels

graph.add_nodes_from(range(len(node_data_obs)))

edges = [
    (0, 7),
    (0, 5),
    (1, 7),
    (1, 6),
    (2, 5),
    (2, 6),
    (2, 4),
    (3, 4)
]

graph.add_edges_from(edges)

# Create model
model = Model(graph, node_data_obs, 1, 0, None, None, None, None, None)

# Run model
ant_pos = []
for i in range(20):
    model.sim_step()
    ant_pos.append(model.ants[0].currentNode)

# Validate
print(ant_pos)

print(graph.degree(range(4)))
plt.subplot(121)
nx.draw(graph, with_labels=True, font_weight='bold')
plt.show()
