public class PRM
{
  
  
  public void add(Vector node)
  {
    for(Vector n : nodes) // for each node that already exists try to find a edge to the new one
    {
      Line edge = new Line(n,  node);
      if(n.minus(node).mag() < 10)
        if(agent.cSpace.validEdge(edge))
          edges.add(edge);
    }
  }
  
  public void step()
  {
    Vector node = agent.cSpace.randomNode();
    nodes.add(node);
    node.draw();
    this.add(node);
  }
  
  
  public Path getPath()
  {
    return dijkstra(goalPos, startPos , edges );
    //return bfs(goalPos, startPos, edges);
  }
  
 

}
