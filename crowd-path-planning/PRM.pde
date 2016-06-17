public class PRM
{
  public CSpace cSpace = null;
  public ArrayList<Vector>   nodes     = new ArrayList<Vector>();
  public ArrayList<Line>     edges     = new ArrayList<Line>();
  
  public PRM(CSpace cs, int numNodes)
  {
    this.cSpace = cs;
    for(int i = 0 ; i < numNodes; i++)
      this.add(this.cSpace.randomNode());
  }
  
  public void add(Vector node)
  {
    this.nodes.add(node);
    for(Vector n : nodes) // for each node that already exists try to find a edge to the new one
    {
      Line edge = new Line(n,  node);
      if(n.minus(node).mag() < 10)    // MAGIC: 10 is the limit to how far to look for near nodes
        if(this.cSpace.valid(edge))
          this.edges.add(edge);
    }
  }
  
  public void step()
  {
    Vector node = this.cSpace.randomNode();
    this.add(node);
    node.draw();
  }
  
  
  public Path getPath(Vector start, Vector end)
  {
    if(!nodes.contains(start)) this.add(start);
    if(!nodes.contains(end))   this.add(end);
    
    return dijkstra(start, end , edges );
  }
  


}
