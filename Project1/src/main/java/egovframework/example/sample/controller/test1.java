package egovframework.example.sample.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Scanner;



class Node{
	int one;
	int two;
	int three;
	
	public Node(int one, int two, int three) {
		super();
		this.one = one;
		this.two = two;
		this.three = three;
	}

	@Override
	public int hashCode() {
		return Objects.hash(one, three, two);
	}

	@Override
	public boolean equals(Object obj) {
		Node newNode = (Node) obj;
		
		if(this.one != newNode.one || this.two != newNode.two || this.three != newNode.three) {
			return false;
		}
		
		
		return true;
	}
	
	
	
}

// 3 4 7 10
// 4 8 14
public class test1 {
	public static int count = 0;
	public static List<Node> list = null;
	public static Map<Integer, Integer> map = null;
	public static void main(String[] args) throws Exception {
		Scanner sc = new Scanner(System.in);
			
		int n = sc.nextInt();
		
		for(int i=0;i<n;i++) {
			int element = sc.nextInt();
			list = new ArrayList<>();
			map = new HashMap<>();
			map.put(1, 0);
			map.put(2, 0);
			map.put(3, 0);
			count = 0;
			
			dfs(element, 0);
			
			System.out.println(count);
		
		}
		
		
	}
	
	
	public static void dfs(int num, int sum) {
		if(sum == num) {
			Node node = new Node(map.get(1), map.get(2), map.get(3));
			
			if(!list.contains(node)) {
				list.add(node);
				count++;
			}
			
			return;
		}
		
		if(sum > num) {
			return;
		}
		
		for(int i=1;i<=3;i++) {
			map.put(i, map.get(i) + 1);
			sum += i;
			dfs(num, sum);
			sum -= i;
			map.put(i, map.get(i) - 1);
		}
	}
	
}
