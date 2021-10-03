function ondestroy() dieRollerInfo = Global.getTable('dieRollerInfo') dieRoller = getObjectFromGUID(dieRollerInfo.redDieRollerGUID) dieRoller.call('waitToUpdate') end












