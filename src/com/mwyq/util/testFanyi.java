package com.mwyq.util;

public class testFanyi {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		translation tra = new translation();
		String s = "མི་དམངས་དྲ་བའི་འཕྲིན། ཟླ་11ཚེས་20ཉིན། པེ་ཅིང་དང་སི་ཁྲོན། བོད་ལྗོངས། མཚོ་སྔོན། ཀན་སུའུ་ནས་ཡོང་བའི་ གསར་འགོད་པ་རྣམས ཐང་གའི་ཕ་ཡུལ དུ་འབོད་པའི་སི་ཁྲོན་བྲག་འགོ་རུ་བསྐྱོད་དེ། གནས་དེའི་ཐང་གའི་མཛེས་ཉམས་ལ་ཉམས་སུ་མྱངས་པ་རེད། ";
		String re = tra.sendPostZang(s);
		System.out.println(re);
	}

}
