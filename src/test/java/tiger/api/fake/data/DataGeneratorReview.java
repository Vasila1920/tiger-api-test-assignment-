package tiger.api.fake.data;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.github.javafaker.Faker;

public class DataGeneratorReview {

	public static String getEmail() {
		Faker faker = new Faker();
		return faker.name().firstName() + faker.name().lastName() + "@gmail.com";
	}

	public static String getName() {
		Faker faker = new Faker();
		return faker.name().firstName();
	}

	public static String getLastName() {
		Faker faker = new Faker();
		return faker.name().lastName();
	}

	public static String getTitle() {
		Faker faker = new Faker();
		return faker.name().title();
	}

	public static String getDob() {
		Faker faker = new Faker();
		Date date = faker.date().birthday();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
		return format.format(date);
	}

	public static String getPhoneNumber() {
		Faker faker = new Faker();
		return faker.phoneNumber().phoneNumber();
	}
	
		
	}


