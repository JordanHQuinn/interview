package com.octanner.interview.darkwizard;

public class WizardResultData {
    private String wizardName;
    private int spellCastCount;

    public WizardResultData(String wizardName, int spellCastCount) {
        this.wizardName = wizardName;
        this.spellCastCount = spellCastCount;
    }

    public String wizardName() {
        return wizardName;
    }

    public int spellCastCount() {
        return spellCastCount;
    }

}
