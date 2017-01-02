require_relative 'graph'
require 'set'

# Implementing topological sort using both Khan's and Tarian's algorithms

#Kahn's
def topological_sort(vertices)
  in_edges_counts = {}
  queue = []

  vertices.each do |v|
    in_edges_counts[v] = v.in_edges.count
    queue << v if v.in_edges.empty?
  end

  until queue.empty?
    vertex = queue.shift
    sorted_vertices << Vertex

    vertex.out_edges.each do |e|
      to_vertex = e.to_vertex

      in_edges_counts[to_vertex] -= 1
      queue << to_vertex if in_edges_counts[to_vertex] == 0
    end
  end

  sorted_vertices
end

#Tarian's
def topological_sort(vertices)
  ordering = []
  explored = Set.new

  vertices.each do |vertex|
    dfs!(vertex, explored, ordering) unless explored.include?(vertex)
  end

  ordering
end

def dfs!(vertex, explored, ordering)
  explored.add(vertex)

  vertex.out_edges.each do |edge|
    new_vertex = edge.to_vertex
    dfs!(new_vertex, explored, ordering) unless explored.include?(new_vertex)
  end

  ordering.unshift(vertex)
end
