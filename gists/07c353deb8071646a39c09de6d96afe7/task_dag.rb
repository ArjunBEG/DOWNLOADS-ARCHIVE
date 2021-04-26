require 'plexus'
require 'yaml'

class TaskDag
  include Plexus

  def initialize(filepath = File.join('config', 'task_mappings.yml'))
    @dag = DirectedGraph.new # alias of Digraph
    @filepath = filepath
  end

  def build
    add_vertices_and_edges
  end

  def ancestors(task)
    dag.ancestors(task)
  end

  def root(task)
    ancestors(task).last
  end

  def visualize
    filename = dag.write_to_graphic_file and puts "Created #{filename}"
  end

  private

  attr_reader :dag, :filepath

  def add_vertices_and_edges(tasks = yml_tasks)
    tasks.each_pair do |task, child_tasks|
      next if child_tasks.nil?
      child_tasks.keys.each do |child|
        dag.add_edge!(task, child)
      end
      add_vertices_and_edges(child_tasks)
    end
  end

  def yml_tasks
    @yml_tasks ||= YAML.load_file(filepath)
  end
end
