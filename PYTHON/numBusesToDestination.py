class Solution(object):
    def numBusesToDestination(self, routes, source, target):
        if source == target:
            return 0

        max_stop = max(max(route) for route in routes)
        if max_stop < target:
            return -1

        n = len(routes)
        min_buses_to_reach = [float('inf')] * (max_stop + 1)
        min_buses_to_reach[source] = 0

        flag = True
        while flag:
            flag = False
            for route in routes:
                mini = float('inf')
                for stop in route:
                    mini = min(mini, min_buses_to_reach[stop])
                mini += 1
                for stop in route:
                    if min_buses_to_reach[stop] > mini:
                        min_buses_to_reach[stop] = mini
                        flag = True

        return min_buses_to_reach[target] if min_buses_to_reach[target] < float('inf') else -1



class Solution:
    def numBusesToDestination(self, routes, starterBus, targetBus):
        path, travel, travelTaken, used = collections.defaultdict(set), [starterBus], 0, set()
        for i, route in enumerate(routes):
            for bus in route:
                path[bus].add(i)
        while travel:
            new = []
            for bus in travel:
                if bus == targetBus:
                    return travelTaken
                for route in path[bus]:
                    if route not in used:
                        used.add(route)
                        for nextBus in routes[route]:
                            if nextBus != bus:
                                new.append(nextBus)
            travelTaken += 1
            travel = new
        return -1
