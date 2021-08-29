import fs from 'fs-extra';
import path from 'path';

function encodeKey(name: string): string {
  return `\"${name.toUpperCase().replace(/\"/g, '\\"')}\"`;
}

function formatData(data: object, indent: number): string[] {
  return Object.entries(data)
    .map((keyValuePair) => {
      let [key, value] = keyValuePair;
      if (typeof value === 'string') {
        value = `\"${value.replace(/\"/g, '\\"')}\"`;
      } else if (typeof value === 'object') {
        value = `{\n${formatData(value, indent + 2).join('\n')}${' '.repeat(
          indent,
        )}}`;
      }
      return `${' '.repeat(indent)}${key}  = ${value}`;
    })
    .map((v) => `${v},`);
}

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
    lua.push(`    [${encodeKey(faction)}] = {`);
    Object.entries(ranks as object).forEach((rankAndUnits) => {
      const [_rank, units] = rankAndUnits;
      (units as any[]).forEach((unit) => {
        let { name } = unit;
        if (unit.title) {
          name = `${name} ${unit.title}`;
        }
        lua.push(`      [${encodeKey(name)}] = {`);
        lua.push(...formatData(unit, 8));
        lua.push('      },');
      });
    });
    lua.push('    },');
  });

  lua.push('  },');

  const upgrades = json['upgrades'];
  lua.push('  upgrades = {');
  Object.entries(upgrades).forEach((typeAndUpgrades) => {
    const [type, upgrades] = typeAndUpgrades;
    lua.push(`    [${encodeKey(type)}] = {`);
    (upgrades as object[]).forEach((upgrade) => {
      lua.push(`      [${encodeKey((upgrade as any).name)}] = {`);
      lua.push(...formatData(upgrade, 8));
      lua.push('      },');
    });
    lua.push('    },');
  });
  lua.push('  },');

  lua.push('}');
  lua.push('');

  await fs.mkdirp(path.dirname(outLua));
  return fs.writeFile(outLua, lua.join('\n'), 'utf8');
}
