public class Tree {
  protected Node root;
  protected PVector dimensions;

  public Tree() {
    root = null;
  }

  public Node find(int v) {
    if (root == null) return null;
    else return find(v, root);
  }

  private Node find(int v, Node n) {
    if (n == null) return null;
    else if (v == n.value) return n;
    else if (v < n.value) return find(v, n.left);
    else return find(v, n.right);
  }

  public void draw(PGraphics mpg) {
    if (root == null) return;

    mpg.beginDraw();
    if (dimensions != null) root.drawNode(mpg, (int)dimensions.y);
    else root.drawNode(mpg, height());
    mpg.endDraw();
  }

  public int height() {
    if (root == null) return 0;

    int tHeight = root.calculateHeight(new PVector(0.5, 0));
    dimensions = new PVector((1 << (tHeight - 1)), tHeight);
    return tHeight;
  }

  public String toString() {
    if (root == null) return "Ø";
    else return root.printNode();
  }

  public Node insert(Node n) {
    if (root == null) {
      root = n;
      return root;
    } else return insert(n, root);
  }

  private Node insert(Node n, Node root) {
    if (n.value == root.value) {
      root.count += n.count;
      return root;
    } else if (n.value < root.value) {
      if (root.left == null) {
        root.left = n;
        n.parent = root;
        return n;
      } else {
        return insert(n, root.left);
      }
    } else {
      if (root.right == null) {
        root.right = n;
        n.parent = root;
        return n;
      } else {
        return insert(n, root.right);
      }
    }
  }
}

class Node {
  private int value;
  private int count;
  private Node left;
  private Node right;
  private Node parent;

  private PVector location;

  public Node(int v) {
    value = v;
    count = 1;
    left = right = parent = null;
  }

  public Node(Node n) {
    value = n.value;
    count = n.count;
    left = n.left;
    right = n.right;
    parent = n.parent;
  }

  public boolean isLeftChild() {
    if (parent == null) return false;
    else return (parent.left == this);
  }

  public String printNode() {
    StringBuilder buffer = new StringBuilder(1024);
    printNode(buffer, "", true);
    return buffer.toString();
  }

  private void printNode(StringBuilder buffer, String prefix, boolean fromLeft) {
    if (right != null) right.printNode(buffer, prefix + (fromLeft ? "│   " : "    "), false);

    buffer.append(prefix).append(fromLeft ? "└── " : "┌── ").append(value).append('\n');

    if (left != null) left.printNode(buffer, prefix + (fromLeft ? "    " : "│   "), true);
  }

  private PVector drawNode(PGraphics mpg, int treeHeight) {
    float dx = location.x * mpg.width;
    float dy = (location.y / (treeHeight - 1)) * mpg.height;

    dy *= map(noise(location.y/1000f), 0, 1, 0.2, 2.0);

    if (left != null) {
      PVector leftDrawLocation = left.drawNode(mpg, treeHeight);
      mpg.line(dx, dy, leftDrawLocation.x, leftDrawLocation.y);
    }
    if (right != null) {
      PVector rightDrawLocation = right.drawNode(mpg, treeHeight);
      mpg.line(dx, dy, rightDrawLocation.x, rightDrawLocation.y);
    }

    return new PVector(dx, dy);
  }

  private int calculateHeight(PVector loc) {
    location = loc;
    int leftHeight = 0;
    int rightHeight = 0;

    if (left != null) {
      float lx = location.x - (2.0 / (1 << int(location.y + 2)));
      leftHeight = left.calculateHeight(new PVector(lx, location.y + 1));
    }

    if (right != null) {
      float rx = location.x + (2.0 / (1 << int(location.y + 2)));
      rightHeight = right.calculateHeight(new PVector(rx, location.y + 1));
    }

    return (max(leftHeight, rightHeight) + 1);
  }
}
