package tiger.api.runner.review;

import com.intuit.karate.junit5.Karate;

public class RunnerReview {
	@Karate.Test
	public Karate RunTest() {
        return Karate.run("classpath:features").tags("EndToEnd");
	}

}
