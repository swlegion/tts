import os from 'os';
import fs from 'fs-extra';
import path from 'path';

function encodeKey(name: string): string {
  return `\"${name.toUpperCase().replace(/\"/g, '\\"')}\"`;
}

function formatData(
  data: { [key: string]: unknown },
  indent: number,
): string[] {
  if (Array.isArray(data)) {
    return [
      ...data.map((value) => {
        if (typeof value === 'string') {
          value = `${' '.repeat(indent)}\"${value.replace(/\"/g, '\\"')}\",`;
        } else if (typeof value === 'object') {
          value = `${' '.repeat(indent)}{\n${formatData(value, indent + 2).join(
            '\n',
          )}\n${' '.repeat(indent)}},`;
        }
        return value;
      }),
    ];
  }
  return Object.entries(data)
    .map((keyValuePair) => {
      let [key, value] = keyValuePair;
      if (typeof value === 'string') {
        value = `\"${value.replace(/\"/g, '\\"')}\"`;
      } else if (typeof value === 'object') {
        value = `{\n${formatData(
          value as { [key: string]: unknown },
          indent + 2,
        ).join('\n')}${' '.repeat(indent)}\n${' '.repeat(indent)}}`;
      }
      if (key.indexOf(' ') !== -1) {
        key = `[\"${key}\"]`;
      }
      return `${' '.repeat(indent)}${key} = ${value}`;
    })
    .map((v) => `${v},`);
}

export default async function buildDeckSchemaLua(
  inJson: string,
  outLua: string,
): Promise<void> {
  const json = await fs.readJson(inJson);
  const lua: string[] = [
    '-- AUTO GENERATED (`npm run generate`). DO NOT MODIFY BY HAND. Booyah',
    'GENERATED_CARDS_SCHEMA = {',
  ];

   const units = json['units'];
   const pathBase: string = "contrib/cards";
   lua.push('  units = {');

   var unitsArray = Object.entries<Array<string>>(units);
   var count = unitsArray.length;
   for (let a = 0; a < count; a++) {
      var faction = unitsArray[a][0];
      lua.push(`    [${encodeKey(faction)}] = {`);

      var unitContent: string[] = unitsArray[a][1];
      for (var key in unitContent)
      {
         var unitContentPath : string = path.join(pathBase, unitContent[key]);
         let rawUnitJson = fs.readFileSync(unitContentPath, 'utf-8');
         let unitJson = JSON.parse(rawUnitJson as string);
         for (var rank in unitJson)
         {
            const units = unitJson[rank];
            (units as { [key: string]: unknown }[]).forEach((unit) => {
               unit = { ...unit, rank, faction };
               if (unit.content != null) {
                  var unitEmbedContentPath = unit.content as string;
                  let rawUnitEmbedContent = fs.readFileSync(unitEmbedContentPath, 'utf-8');
                  unit = JSON.parse(rawUnitEmbedContent as string);
                  unit = { ...unit, rank, faction };
               }
               let { name } = unit;
               if (unit.title) {
                  name = `${name} ${unit.title}`;
               }
               lua.push(`      [${encodeKey(name as string)}] = {`);
               lua.push(...formatData(unit, 8));
               lua.push('      },');
            });
            lua.push('    },');
         }
      }
      
   }
  lua.push('  },');

  const allUpgradesSorted: { [key: string]: unknown }[] = [];
  Object.entries(json['upgrades']).forEach((typeAndUpgrades) => {
    const [type, upgrades] = typeAndUpgrades;
    (upgrades as { [key: string]: unknown }[]).forEach((upgrade) => {
      allUpgradesSorted.push({ ...upgrade, type });
    });
  });

  // Handle "flip" cards by double-indexing (this is lazy, but deal with it).
  [...allUpgradesSorted].forEach((upgrade) => {
    if (!upgrade.flip) {
      return;
    }
    allUpgradesSorted.push({
      ...(upgrade.flip as { [key: string]: unknown }),
      type: (upgrade as { [key: string]: unknown }).type,
      points: (upgrade as { [key: string]: unknown }).points,
      restrictions: (upgrade as { [key: string]: unknown }).restrictions,
      mini: upgrade.mini,
      flip: {
        name: upgrade.name,
        image: upgrade.image,
      },
    });
  });

  allUpgradesSorted.sort((a, b) =>
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    (a as any).name > (b as any).name ? 1 : -1,
  );
  lua.push('  upgrades = {');
  allUpgradesSorted.forEach((upgrade) => {
    lua.push(`    [${encodeKey(upgrade.name as string)}] = {`);
    lua.push(...formatData(upgrade, 6));
    lua.push('    },');
  });
  lua.push('  },');

  const allCommandsSorted: { [key: string]: unknown }[] = [];
  Object.entries(json['commands']).forEach((factionAndCommands) => {
    const [faction, commands] = factionAndCommands;
    (commands as { [key: string]: unknown }[]).forEach((command) => {
      allCommandsSorted.push({
        ...command,
        faction,
      });
    });
  });

  allCommandsSorted.sort((a, b) =>
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    (a as any).name > (b as any).name ? 1 : -1,
  );
  lua.push('  commands = {');
  allCommandsSorted.forEach((command) => {
    lua.push(`    [${encodeKey(command.name as string)}] = {`);
    lua.push(...formatData(command, 6));
    lua.push('    },');
  });
  lua.push('  },');

  const { battlefield } = json;
  lua.push('  battlefield = {');
  Object.entries(battlefield).forEach((typeAndCategories) => {
    const [type, categories] = typeAndCategories;
    lua.push(`    ${type.toLowerCase()} = {`);
    Object.entries(categories as { [key: string]: unknown }).forEach(
      (categoryAndCards) => {
        const [category, cards] = categoryAndCards;
        lua.push(`      ${category.toLowerCase()} = {`);
        (cards as { [key: string]: unknown }[]).forEach((card) => {
          lua.push(`        [${encodeKey(card.name as string)}] = {`);
          lua.push(...formatData(card, 10));
          lua.push('        },');
        });
        lua.push('      },');
      },
    );
    lua.push('    },');
  });
  lua.push('  },');

  const { objects } = json;
  lua.push('  objects = {');
  if (objects) {
    lua.push(...formatData(objects, 4));
  }
  lua.push('  },');

  lua.push('}');
  lua.push('');

  await fs.mkdirp(path.dirname(outLua));
  return fs.writeFile(outLua, lua.join('\n'), 'utf8');
}
