import fs from 'fs-extra';

export default async function buildDeckSchemaLua(
  inJson: string,
  outLua: string,
): Promise<void> {
  const json = await fs.readJson(inJson);
  const lua: string[] = [
    '-- AUTO GENERATED (`npm run generate`). DO NOT MODIFY BY HAND.',
    'DeckSchema = {',
  ];

  const units = json['units'];
  lua.push('  units = {');
  Object.entries(units).forEach((factionAndRanks) => {
    const [faction, ranks] = factionAndRanks;
    lua.push(`    ["${faction}"] = {`);
    Object.entries(ranks as object).forEach((rankAndUnits) => {
      const [_rank, units] = rankAndUnits;
      (units as any[]).forEach((unit) => {
        let { name } = unit;
        if (unit.title) {
          name = `${name} ${unit.title}`;
        }
        lua.push(`      ["${name}"] = {`);
        Object.entries(unit).forEach((keyValuePair) => {
          let [key, value] = keyValuePair;
          if (typeof value === 'string') {
            value = `\"${value}\"`;
          }
          lua.push(`        ${key}  = ${value},`);
        });
        lua.push('      },');
      });
    });
    lua.push('    },');
  });

  lua.push('  },');
  lua.push('}');
  lua.push('');

  return fs.writeFile(outLua, lua.join('\n'), 'utf8');
}
