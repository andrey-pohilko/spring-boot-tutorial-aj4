package com.example.springboottutorial.aj4;

/*

*** Добавить в pom.xml
		<dependency>
			<groupId>org.seleniumhq.selenium</groupId>
			<artifactId>selenium-java</artifactId>
			<version>3.141.59</version>
		</dependency>

*** Добавить selenium в ваш проект
* Скачать архив для Java с сайта https://www.selenium.dev/downloads/
* распаковать во временную папку.
* Project Structure - Libraries - Add и выбрать все jar файлы
 */

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
//import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.WebDriverWait;
//import static org.openqa.selenium.support.ui.ExpectedConditions.presenceOfElementLocated;
import java.util.concurrent.TimeUnit;

public class HelloSelenium {

    public static void main(String[] args) {
        WebDriver driver = new ChromeDriver();
        WebDriverWait wait = new WebDriverWait(driver, 10);
        try {
            driver.get("http://localhost:8080");
            driver.findElement(By.name("myName")).sendKeys("cheese" + Keys.ENTER);
            TimeUnit.SECONDS.sleep(3);
//            WebElement firstResult = wait.until(presenceOfElementLocated(By.cssSelector("h3")));
            System.out.println(driver.getPageSource());
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            driver.quit();
        }
    }
}
