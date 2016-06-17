public Path bfs(Vector start, Vector end , ArrayList<Line> edges )
{
  ArrayList<Line> lines = new ArrayList<Line>();
  lines.addAll(edges); // copy the edges over
  ArrayList<Path> q = new ArrayList<Path>();
  
  Path p = new Path(null, start);
  q.add(p);
  
  
  while(!q.isEmpty())
  {
    p = q.remove(0);                     // take out of the queue
    if(p.v == end) return p;             // if the current path leads to the end return it.
    
    for(int i = 0 ; i < lines.size(); i++)
    { // look for a line that connects p to another vector, then remove that line.
      Line l = lines.get(i);
      if(l.a == p.v)
      {
        q.add(new Path(p, l.b));
        lines.remove(i);
        i--;
        
      }
      else if(l.b == p.v)
      {
        q.add(new Path(p, l.a));
        lines.remove(i);
        i--;
      }
    } 
  }
  return null;
}

public Path dijkstra(Vector start, Vector end , ArrayList<Line> edges ) // TODO: pull edges in order of closeness
{
  HashMap<Vector, Path> v2p = new HashMap<Vector, Path>();
  ArrayList<Path> q         = new ArrayList<Path>();
  
  Path curPath = new Path(null, start); // start path, no previous node, distance 0
  v2p.put(start, curPath);
  q.add(curPath);
    
  while(!q.isEmpty())
  { 
    curPath = q.remove(0);                     // take out path out of the Queue
    for(Line l : edges)                        // check each line
    {
      Vector v = l.getOther( curPath.v );      // grab the vector mapped to curPath's vector
      if(v == null) continue;                  // if this line doesn't have it -> skip
      //println("found a link between: " + curPath.v + "and" + v);      
      if( ! v2p.containsKey(v) )               // if a path to v has not yet been made
      {
        Path newPath = new Path(curPath, v);
        v2p.put(v, newPath);      // save current path -> v
        q.add(newPath);           // explore this new path later 
      }
      else if( curPath.totalDistance() + l.distance() < v2p.get(v).totalDistance()) // if the current path to v is better than the old path to v
      {
        Path newPath = new Path(curPath, v);
        v2p.put(v, newPath);      // save current path -> v
        q.add(newPath);           // explore this new path later
      } 
    }
  }
  return v2p.get(end);
}


