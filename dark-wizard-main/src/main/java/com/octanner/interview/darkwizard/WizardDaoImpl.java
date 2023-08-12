package com.octanner.interview.darkwizard;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class WizardDaoImpl implements WizardDao {

  private final JdbcTemplate jdbcTemplate;
  private List<WizardResultData> darkWizards;

  public WizardDaoImpl(JdbcTemplate jdbcTemplate) {
    this.jdbcTemplate = jdbcTemplate;
    darkWizards = new ArrayList<>();
    updateDarkWizardsList();
  }

  private void updateDarkWizardsList() {
    String sql = "SELECT w.name AS wizard_name, Count(sc.spell_id) AS spell_cast_count FROM wizard w JOIN spell_cast_event sc ON w.wand_id = sc.wand_id JOIN spell s ON sc.spell_id = s.spell_id WHERE s.name IN ('Avada Kedavra', 'Imperio', 'Crucio') GROUP BY w.name ORDER BY spell_cast_count DESC";
    List<WizardResultData> newDarkWizards = jdbcTemplate.query(sql, new RowMapper<WizardResultData>() {
      @Override
      public WizardResultData mapRow(ResultSet resultSet, int rowNum) throws SQLException {
        int spellCastCount = resultSet.getInt("spell_cast_count");
        String wizardName = resultSet.getString("wizard_name");
        return new WizardResultData(wizardName, spellCastCount);

      }
    });
    
    darkWizards = newDarkWizards;

  }

  @Override
  public List<WizardResultData> getDarkWizards() {
    return darkWizards;
  }
}
