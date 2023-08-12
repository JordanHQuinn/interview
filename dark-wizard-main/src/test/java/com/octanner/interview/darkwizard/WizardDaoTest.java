package com.octanner.interview.darkwizard;


import java.util.Arrays;
import java.util.List;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.jdbc.JdbcTest;
import org.springframework.context.annotation.Import;

import static org.assertj.core.api.Assertions.assertThat;

@JdbcTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Import(WizardDaoImpl.class)
class WizardDaoTest {

  @Autowired WizardDaoImpl wizardDao;

  @Test
  @DisplayName("Count of wizards that use unforgivable curses")
  public void testWizardResultCount() {
    assertThat(wizardDao.getDarkWizards().size()).isEqualTo(5);
  }

  @Test
  @DisplayName("Tom Riddle should be listed first and have cast 16 spells")
  public void testTomRiddle() {
    var darkWizards = wizardDao.getDarkWizards();
    var tom = darkWizards.get(0);
    assertThat(tom.wizardName()).isEqualTo("Tom Riddle");
    assertThat(tom.spellCastCount()).isEqualTo(16);
  }

  @Test
  @DisplayName("Harry Potter should be listed 4th and have cast 2 spells")
  public void testHarryPotter() {
    var darkWizards = wizardDao.getDarkWizards();
    var harry = darkWizards.get(3);
    assertThat(harry.wizardName()).isEqualTo("Harry Potter");
    assertThat(harry.spellCastCount()).isEqualTo(2);
  }

  @Test
  @DisplayName("Hermione Granger should not be in the list")
  public void testHermioneGranger() {
    var darkWizards = wizardDao.getDarkWizards();
    assertThat(darkWizards.stream().anyMatch(w -> w.wizardName().equals("Hermione Granger"))).isFalse();
  }

  @Test
  @DisplayName("Testing if you can compare lists of objects")
  public void testTomIsFirst() {
    var expected = List.of(
        new WizardResultData("Tom Riddle", 16),
        new WizardResultData("Bellatrix Lestrange", 8),
        new WizardResultData("Severus Snape", 3),
        new WizardResultData("Harry Potter", 2),
        new WizardResultData("Draco Malfoy", 1)
    );
    var darkWizards = wizardDao.getDarkWizards();
    assertThat(darkWizards).containsExactlyElementsOf(expected);
  }
}