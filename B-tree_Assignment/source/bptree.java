import java.io.*;
import java.util.ArrayList;
import java.util.List;


public class bptree {


    static class Node {

        static class Pair {

            int key;
            int val;
            Node child; //child of Pair

            Pair(int key, int val, Node n) {
                this.key = key;
                this.val = val;
                this.child = n; //left child
            }

        }

        int m; //Pair
        List<Pair> p; //<key, leftChild> <key, data>
        Node r; //right


        Node() {
            this.m = 0;
            this.p = new ArrayList<>();
            this.r = null;

        }

    }

    private static int M = 0;
    private static int count = 0; // node count

    public static Node root = new Node();


    public static List<Node> tree = new ArrayList<>();
    public static List<Integer> leaf = new ArrayList<>();

    // used to find parent node
    private static Node parentNode;
    private static int parentIndex;


    //args start from -

    public static void main(String[] args) {

        String command = args[0];
        String indexFile = args[1];

        switch (command) {
            case "-c"://creation
                message(args, 3);

                M = Integer.parseInt(args[2]);
                creation(indexFile);
                System.out.println("creation");
                break;
            case "-i": //insertion
                message(args, 3);
                String dataFile = args[2];
                insertion(indexFile, dataFile);
                System.out.println("insertion");
                break;

            case "-d":
                message(args, 3);
                String deleteFile = args[2];
                deletion(indexFile, deleteFile);
                System.out.println("deletion");
                break;
            case "-s":
                message(args, 3);
                int findKey = Integer.parseInt(args[2]);
                singleSearch(indexFile, findKey);
                break;
            case "-r":
                message(args, 4);
                int fromKey = Integer.parseInt(args[2]);
                int toKey = Integer.parseInt(args[3]);

                rangedSearch(indexFile, fromKey, toKey);
                break;
            case "-p":
                message(args, 2);
                readTree(indexFile);
                System.out.println("====file====");
                printFile(indexFile);

                break;

            default:
                System.out.println("Argument error!");

        }


    }


    //Error message
    private static void message(String[] args, int num) {
        if (args.length != num) {
            switch (args[0]) {
                case "-c":
                    System.out.println("Usage : -c [indexFile] [m]");
                    System.exit(-1);
                case "-i":
                    System.out.println("Usage : -i [indexFile] [dataFile]");
                    System.exit(-1);
                case "-d":
                    System.out.println("Usage : -d [indexFile] [dataFile]");
                    System.exit(-1);
                case "-s":
                    System.out.println("Usage :-s [indexFile] [key]");
                    System.exit(-1);
                case "-r":
                    System.out.println("Usage : -r  [indexFile] [startKey] [endKey]");
                    System.exit(-1);
                case "-p":
                    System.out.println("Usage : -p [indexFile]");
                    System.exit(-1);
            }


        }
    }

    //creation
    private static void creation(String indexFile) {

        try {

            FileWriter fr = new FileWriter(indexFile, false);
            fr.write(M + "\r\n");
            fr.close();


        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    //print

    private static void printFile(String indexFile) {
        FileReader fr = null;
        try {
            fr = new FileReader(indexFile);
            BufferedReader br = new BufferedReader(fr);
            String str = null;
            str = br.readLine();
            while (!(str == null)) {
                System.out.println(str);
                str = br.readLine();
            }
            br.close();
            fr.close();

        } catch (IOException e) {
            e.printStackTrace();
        }


    }


    private static void readTree(String indexFile) {

        File file = new File(indexFile);

        try {

            char leafchar = '#';

            FileReader fr = new FileReader(file);
            BufferedReader br = new BufferedReader(fr);
            String line;

            M = Integer.parseInt(br.readLine());


            while ((line = br.readLine()) != null) {


                if (line.charAt(0) == leafchar) {
                    break; //index node end
                }


                //parent, this number

                String[] splitLine = line.split(" "); //* 0 1
                int parentN = Integer.parseInt(splitLine[1]); //parent
                int thisN = Integer.parseInt(splitLine[2]);// myNum

                Node nowNode = new Node();

                // data inside node
                line = br.readLine(); //key value / key value
                splitLine = line.split(" / ");
                for (String dataLine : splitLine) {

                    String[] data = dataLine.split(" "); //key value
                    int key = Integer.parseInt(data[0]); //key
                    int value = Integer.parseInt(data[1]); //value

                    nowNode.m++;
                    nowNode.p.add(new Node.Pair(key, value, null));

                }


                // add node to tree
                for (int i = 0; i <= thisN - tree.size(); i++) {
                    tree.add(null);
                }

                tree.add(thisN, nowNode);

                // parent connection
                if (parentN == 0) {

                    root = nowNode;

                } else {

                    Node parentNode = tree.get(parentN);

                    boolean connection = false;

                    // find index of parent
                    for (int i = 0; i < parentNode.m; i++) {

                        if (parentNode.p.get(i).child == null) {

                            parentNode.p.get(i).child = nowNode;
                            connection = true;
                            break;

                        }

                    }


                    if (!connection) {
                        parentNode.r = nowNode;
                    }

                }

            }


            // leaf
            if (line != null) { // #leafs

                String[] leafList = line.split(" ");


                // connect leaves
                for (int i = 1; i < leafList.length - 1; i++) {

                    Node node = tree.get(Integer.parseInt(leafList[i]));
                    node.r = tree.get(Integer.parseInt(leafList[i + 1]));


                }

            }
            br.close();
            fr.close();


        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    //insertion

    private static void insertion(String indexFile, String dataFile) {


        readTree(indexFile);

        try {

            FileReader fr = new FileReader(dataFile);
            BufferedReader br = new BufferedReader(fr);
            String line;


            while ((line = br.readLine()) != null) {


                String[] data = line.split(",");
                int key = Integer.parseInt(data[0]);
                int value = Integer.parseInt(data[1]);


                insert(key, value);

            }

            br.close();
            fr.close();

        } catch (IOException e) {
            e.printStackTrace();


        }

        save(indexFile);
    }


    //insert key, value
    private static void insert(int key, int value) {


        Node nowN = findCorrectLeaf(key);
        Node.Pair newN = new Node.Pair(key, value, null);
        nowN.p.add(FindIndex(nowN, key), newN);
        nowN.m++;

        if (nowN.m < M) {
            return;
        }


        splitLeaf(nowN);


    }

    private static Node findCorrectLeaf(int key) {

        Node nowN = root;


        while (true) {
            boolean check = false;


            if (nowN.m == 0 || nowN.p.get(0).child == null)
                return nowN;


            for (int i = 0; i < nowN.m; i++) {

                if (key < nowN.p.get(i).key) {
                    nowN = nowN.p.get(i).child;
                    check = true;
                    break;
                }
            }
            if (!check) {
                nowN = nowN.r;
            }


        }

    }

    private static int FindIndex(Node node, int key) {

        int index = node.m;

        for (int i = 0; i < node.m; i++) {

            if (key < node.p.get(i).key) {
                index = i;
                break;
            }


        }

        return index;
    }

    private static void splitLeaf(Node nowN) {
        Node rightN = new Node();

        int middle = M / 2;
        int middleKey = nowN.p.get(middle).key;
        int middleValue = nowN.p.get(middle).val;


        for (int i = middle; i < M; i++) {

            Node.Pair pair = nowN.p.get(i);
            rightN.p.add(new Node.Pair(pair.key, pair.val, pair.child));

        }


        //even
        if (M % 2 == 0) {
            rightN.m = middle;
        }
        //odd
        else {
            rightN.m = middle + 1;
        }

        rightN.r = nowN.r;


        //root node
        if (nowN == root) {

            Node leftN = new Node();

            leftN.m = middle;

            for (int i = 0; i < middle; i++) {
                Node.Pair pair = root.p.get(i);
                leftN.p.add(new Node.Pair(pair.key, pair.val, pair.child));
            }

            leftN.r = rightN;

            root.r = rightN;
            root.m = 1;
            root.p.clear();
            root.p.add(new Node.Pair(middleKey, middleValue, leftN));


        } else { //not root

            nowN.r = rightN;
            nowN.m = middle;
            nowN.p.subList(middle, M).clear();


            parentNode = null;
            findParentNode(root, nowN);

            parentNode.m++;
            parentNode.p.add(parentIndex, new Node.Pair(middleKey, middleValue, nowN));


            if (parentIndex == parentNode.m - 1) { // right most child
                parentNode.r = rightN;
            } else {
                parentNode.p.get(parentIndex + 1).child = rightN;

            }

            if (parentNode.m >= M) {
                splitParent(parentNode);
            }

        }
    }


    private static void splitParent(Node nowN) {

        Node right = new Node();

        int middle = nowN.m / 2;
        int middleKey = nowN.p.get(middle).key;
        int middleValue = nowN.p.get(middle).val;


        for (int i = middle + 1; i < nowN.m; i++) {

            Node.Pair pair = nowN.p.get(i);
            right.p.add(new Node.Pair(pair.key, pair.val, pair.child));


        }

        //even
        if (nowN.m % 2 == 0) {
            right.m = middle - 1;
        }
        //odd
        else {
            right.m = middle;
        }

        right.r = nowN.r;


        //root node
        if (nowN == root) {

            Node leftN = new Node();

            leftN.m = middle;

            for (int i = 0; i < middle; i++) {
                Node.Pair pair = root.p.get(i);
                leftN.p.add(new Node.Pair(pair.key, pair.val, pair.child));
            }
            leftN.r = nowN.p.get(middle).child;

            root.r = right;
            root.m = 1;
            root.p.clear();
            root.p.add(new Node.Pair(middleKey, middleValue, leftN));


        } else { // not root

            nowN.r = nowN.p.get(middle).child;
            nowN.m = middle;
            nowN.p.subList(middle, nowN.m).clear();

            parentNode = null;
            findParentNode(root, nowN);

            parentNode.m++;
            parentNode.p.add(parentIndex, new Node.Pair(middleKey, middleValue, nowN));

            if (parentIndex == parentNode.m - 1) { // right most child
                parentNode.r = right;
            } else {
                parentNode.p.get(parentIndex + 1).child = right;

            }

            if (parentNode.m >= M) {
                splitParent(parentNode);
            }


        }
    }


    //delete
    private static void deletion(String indexFile, String dataFile) {


        readTree(indexFile);

        try {

            FileReader fr = new FileReader(dataFile);
            BufferedReader bufReader = new BufferedReader(fr);
            String line;

            while ((line = bufReader.readLine()) != null) {

                int key = Integer.parseInt(line);
                delete(key);

            }

            bufReader.close();
            fr.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

        save(indexFile);

    }


    //delete key
    private static void delete(int key) {


        Node nowN = findCorrectLeaf(key);
        int idx;

        idx = -1;
        for (int i = 0; i < nowN.m; i++) {
            if (nowN.p.get(i).key == key) {
                idx = i;
            }
        }

        // if key doesn't exist in tree
        if (idx == -1) {

            System.out.println(key + " does not exist");
            return;

        }

        Node leftLeaf = findLeftLeaf(nowN.p.get(0).key);
        int changeKey = nowN.p.get(0).key;

        nowN.p.remove(idx);
        nowN.m--;

        //delete ok
        if ((M - 1) / 2 <= nowN.m) {

            if (idx == 0) {
                keyChange(key, nowN.p.get(0).key);

            }

        } else {

            Node leftSibling = findSibling(nowN, "left");
            Node rightSibling = findSibling(nowN, "right");

            //get data from left
            if (leftSibling != null && (M - 1) / 2 <= leftSibling.m - 1) {


                int leftKey = leftSibling.p.get(leftSibling.m - 1).key;
                int leftValue = leftSibling.p.get(leftSibling.m - 1).val;

                leftSibling.p.remove(leftSibling.m - 1);
                leftSibling.m--;

                nowN.p.add(0, new Node.Pair(leftKey, leftValue, null));
                nowN.m++;

                keyChange(changeKey, leftKey);

            } else if (rightSibling != null && (M - 1) / 2 <= rightSibling.m - 1) {

                int rightKey = rightSibling.p.get(0).key;
                int rightValue = rightSibling.p.get(0).val;

                rightSibling.p.remove(0);
                rightSibling.m--;

                keyChange(rightKey, rightSibling.p.get(0).key);

                nowN.p.add(new Node.Pair(rightKey, rightValue, null));
                nowN.m++;

                if (idx == 0) {
                    keyChange(changeKey, nowN.p.get(0).key);
                }

            } else {
                // leaf delete
                parentNode = null;
                findParentNode(root, nowN);

                if (parentNode != null) {

                    if (leftSibling != null) {

                        for (int i = 0; i < nowN.m; i++) {
                            leftSibling.p.add(nowN.p.get(i));
                            leftSibling.m++;
                        }

                        leftSibling.r = nowN.r;

                        // delete parent
                        parentNode.p.remove(parentIndex - 1);
                        parentNode.m--;

                        //connect child
                        if (parentNode.m > 0 && parentIndex - 1 != parentNode.m) {
                            parentNode.p.get(parentIndex - 1).child = leftSibling;
                        } else {
                            parentNode.r = leftSibling;
                        }

                        if (parentNode == root) {
                            if (parentNode.m == 0) {
                                root = leftSibling;
                            }
                        } else {
                            if (parentNode.m < (M - 1) / 2) {
                                mergeParent(parentNode);
                            }
                        }


                    } else if (rightSibling != null) {

                        // merge pairs to sibling
                        for (int i = 0; i < nowN.m; i++) {

                            rightSibling.p.add(i, nowN.p.get(i));
                            rightSibling.m++;

                        }

                        if (idx == 0) {
                            keyChange(changeKey, rightSibling.p.get(0).key);
                        }
                        if (leftLeaf != null) {
                            leftLeaf.r = rightSibling;
                        }
                        // delete parent
                        parentNode.p.remove(parentIndex);
                        parentNode.m--;

                        if (parentNode == root) {
                            if (parentNode.m == 0) {
                                root = rightSibling;
                            }
                        } else {
                            if (parentNode.m < (M - 1) / 2) {
                                mergeParent(parentNode);
                            }
                        }

                    }

                }

            }

        }

    }

    private static void mergeParent(Node nowN) {

        parentNode = null;
        findParentNode(root, nowN);

        if (parentNode != null) {

            Node leftSibling = findSibling(nowN, "left");
            Node rightSibling = findSibling(nowN, "right");

            if (leftSibling != null) {

                // key in parent to be pulled down

                int leftKey = parentNode.p.get(parentIndex - 1).key;
                int leftVal = parentNode.p.get(parentIndex - 1).val;

                leftSibling.p.add(leftSibling.m, new Node.Pair(leftKey, leftVal, leftSibling.r));
                leftSibling.m++;

                // merge pairs to sibling
                for (int i = 0; i < nowN.m; i++) {

                    leftSibling.p.add(leftSibling.m, nowN.p.get(i));
                    leftSibling.m++;

                }

                leftSibling.r = nowN.r;

                // delete parent
                parentNode.p.remove(parentIndex - 1);
                parentNode.m--;

                // connect child to parent
                if (parentNode.m > 0 && parentIndex - 1 != parentNode.m) {

                    parentNode.p.get(parentIndex - 1).child = leftSibling;
                } else
                    parentNode.r = leftSibling;

                // split node
                if (leftSibling.m >= M) {
                    splitParent(leftSibling);
                }

                //fix parent
                if(parentNode == root){
                    if(parentNode.m == 0){
                        root = leftSibling;
                    }
                }else{
                    if(parentNode.m < (M-1)/2){
                        mergeParent(parentNode);
                    }
                }



            } else if (rightSibling != null) {

                // key in parent to be pulled down
                int rightKey = parentNode.p.get(parentIndex).key;
                int rightVal = parentNode.p.get(parentIndex).val;

                // merge pairs to sibling
                for (int i = 0; i < nowN.m; i++) {


                    rightSibling.p.add(i, nowN.p.get(i));
                    rightSibling.m++;

                }
                rightSibling.p.add(nowN.m, new Node.Pair(rightKey, rightVal, nowN.r));
                rightSibling.m++;

                parentNode.p.remove(parentIndex);
                parentNode.m--;

                if (rightSibling.m >= M) {
                    splitParent(rightSibling);
                }
                //fix parent
                if(parentNode == root){
                    if(parentNode.m == 0){
                        root = rightSibling;
                    }
                }else{
                    if(parentNode.m < (M-1)/2){
                        mergeParent(parentNode);
                    }
                }

            }

        }

    }

    private static void findParentNode(Node nowN, Node target) {

        if (nowN == null || parentNode != null) {
            return;
        }

        boolean check = false;
        int key = 0;

        if (target.m != 0) {
            check = true;
            key = target.p.get(0).key;
        }

        for (int i = 0; i < nowN.m; i++) {

            if (nowN.p.get(i).child == target) {

                parentNode = nowN;
                parentIndex = i;


            } else {
                findParentNode(nowN.p.get(i).child, target);
            }

            if (check) {
                if (nowN.p.get(i).key > key) {
                    return;
                }
            }

        }

        if (nowN.m == 0 || nowN.p.get(0).child != null) {
            if (nowN.r != null) {
                if (nowN.r == target) {
                    parentNode = nowN;
                    parentIndex = nowN.m;
                } else {
                    findParentNode(nowN.r, target);
                }
            }
        }


    }


    //find sibling (left, right)
    private static Node findSibling(Node nowN, String action) {

        parentNode = null;
        findParentNode(root, nowN);

        if (parentNode == null) {
            return null;
        }

        if (parentIndex == 0) { //nowN is left most child

            if (action.equals("left")) {
                return null;
            } else { //right

                if (parentNode.m == 1) {
                    return parentNode.r;
                } else {
                    return parentNode.p.get(parentIndex + 1).child;
                }

            }

        } else {

            if (action.equals("left")) {
                return parentNode.p.get(parentIndex - 1).child;

            } else { //right

                if (parentNode.m == parentIndex) { //right most node
                    return null;
                } else if (parentNode.m == parentIndex + 1) {
                    return parentNode.r;
                } else {
                    return parentNode.p.get(parentIndex + 1).child;
                }

            }

        }
    }


    private static Node findLeftLeaf(int targetKey) {

        Node nowN = root;

        while (true) {
            boolean flag = false;

            if (nowN.m == 0 || nowN.p.get(0).child == null) {
                return nowN;
            }

            for (int i = 0; i < nowN.m; i++) {
                if (targetKey <= nowN.p.get(i).key) {
                    nowN = nowN.p.get(i).child;
                    flag = true;
                    break;
                }
            }

            if (!flag) {
                nowN = nowN.r;
            }
        }

    }


    //change key
    private static void keyChange(int before, int after) {

        Node nowN = root;


        while (true) {
            boolean check = false;


            if (nowN.m == 0 || nowN.p.get(0).child == null) { // key in child should not be changed

                break;
            }

            for (int i = 0; i < nowN.m; i++) {

                if (before <= nowN.p.get(i).key) {

                    if (before == nowN.p.get(i).key) {

                        nowN.p.get(i).key = after;

                        return;

                    }
                    nowN = nowN.p.get(i).child;
                    check = true;
                    break;
                }
            }
            if (!check) {
                nowN = nowN.r;
            }

        }
    }


    //single key find
    private static void singleSearch(String indexFile, int findKey) {

        readTree(indexFile);

        singleKeyFind(findKey);

    }

    private static void singleKeyFind(int findKey) {


        Node nowN = root;
        int index;


        // similar to findcorrectleaf
        while (true) {

            boolean checked = false;
            index = nowN.m;

            for (int i = 0; i < nowN.m; i++) {

                if (findKey < nowN.p.get(i).key) {
                    checked = true;
                    index = i;
                    break;
                }

            }

            if (nowN.m == 0 || nowN.p.get(0).child == null) {
                break;
            }

            for (int i = 0; i < nowN.m - 1; i++) {
                System.out.print(nowN.p.get(i).key + ",");
            }

            System.out.print(nowN.p.get(nowN.m - 1).key + "\n");

            if (!checked) {
                nowN = nowN.r;
            } else {
                nowN = nowN.p.get(index).child;
            }

        }

        // print value
        for (int i = 0; i < nowN.m; i++) {

            if (nowN.p.get(i).key == findKey) {

                System.out.print(nowN.p.get(i).val + "\n");
                return;

            }

        }

        System.out.print("Not found\n");
    }

    //ranged key find
    private static void rangedSearch(String indexFile, int fromKey, int toKey) {

        readTree(indexFile);

        rangedKeyFind(fromKey, toKey);


    }

    private static void rangedKeyFind(int fromKey, int toKey) {


        Node nowN = root;
        int index;


        // similar to findCorrectLeaf
        while (true) {

            if (nowN == null) {
                break;
            }


            boolean checked = false;
            index = nowN.m;

            for (int i = 0; i < nowN.m; i++) {

                if (nowN.p.get(i).key > fromKey) {
                    checked = true;
                    index = i;
                    break;

                }

            }

            if (nowN.m == 0 || nowN.p.get(0).child == null) {
                break;
            }

            if (!checked) {
                nowN = nowN.r;
            } else {
                nowN = nowN.p.get(index).child;
            }


        }

        // print nodes in leaves
        while (true) {

            for (int i = 0; i < nowN.m; i++) {

                if (nowN.p.get(i).key > toKey) {
                    return;
                }
                if (nowN.p.get(i).key >= fromKey) {
                    System.out.println(nowN.p.get(i).key + "," + nowN.p.get(i).val);
                }

            }

            if (nowN.r != null) {
                nowN = nowN.r;
            } else return;

        }


    }


    //save


    private static void save(String indexFile) {

        try {

            FileWriter fw = new FileWriter(indexFile);

            // M
            fw.write(M + "\n"); //5

            fw.close();

            fw = new FileWriter(indexFile, true);

            //node
            saveTree(fw, root, 0);


            //  node ended
            fw.write("#");

            // list of leaves

            for (Integer integer : leaf) { //# 2 3 4
                fw.write(" " + integer);
            }
            fw.flush();
            fw.close();

        } catch (IOException e) {
            e.printStackTrace();
        }


    }

    private static void saveTree(FileWriter fw, Node nowN, int parentNum) {

        count++;
        int thisN = count;

        try {

            if (nowN.m == 0) {
                return;
            }

            // node parent and number
            fw.write("* " + parentNum + " " + thisN + "\n"); //* 0 1

            // data inside node
            for (int i = 0; i < nowN.m; i++) {
                fw.write(nowN.p.get(i).key + " " + nowN.p.get(i).val + " / "); //key value / key value
            }

            fw.write("\n");

            // children
            for (int i = 0; i < nowN.m; i++) {

                if (nowN.p.get(i).child != null) {
                    saveTree(fw, nowN.p.get(i).child, thisN);
                }

            }

            //non-leaf
            if (nowN.p.get(0).child != null && nowN.r != null) {
                saveTree(fw, nowN.r, thisN);
            }

            // thisN == leaf
            if (nowN.p.get(0).child == null) {
                leaf.add(thisN);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }


    }


}


