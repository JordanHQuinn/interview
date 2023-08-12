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

    @Override
    public boolean equals(Object object) {
        if (this == object) {
            return true;
        }
        if (object == null || getClass() != object.getClass()) {
            return false;
        }
        WizardResultData returnValue = (WizardResultData) object;

        if (spellCastCount != returnValue.spellCastCount) {
            return false;
        }

        if (wizardName != null) {
            return wizardName.equals(returnValue.wizardName);
        } else {
            return returnValue.wizardName == null;
        }
    }

    @Override
    public int hashCode() {
        int result;
        if (wizardName != null) {
            result = wizardName.hashCode();
        } else {
            result = 0;
        }
        result = 31 * result + spellCastCount;
        return result;
    }

}
