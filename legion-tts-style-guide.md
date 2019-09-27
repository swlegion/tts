# Star Wars Legion TTS Mod - Lua Style Guide

This style guide contains a list of guidelines to follow for code changes to this
project. It does not attempt to make arguments for the styles; its goal is
to provide consistency across projects.


## <a name='TOC'>Table of Contents</a>

  1. [Documentation](#documentation)
  1. [Tables](#tables)
  1. [Strings](#strings)
  1. [Functions](#functions)
  1. [Properties](#properties)
  1. [Variables](#variables)
  1. [Variable Scope](#variablescope)
  1. [Conditional Expressions & Equality](#conditionals)
  1. [Blocks](#blocks)
  1. [Whitespace](#whitespace)
  1. [Commas](#commas)
  1. [Semicolons](#semicolons)
  1. [Type Casting & Coercion](#type-coercion)
  1. [Naming Conventions](#naming-conventions)
  1. [Accessors](#accessors)
  1. [Constructors](#constructors)
  1. [Modules](#modules)


## <a name='documentation'>Documentation</a>

  - Document function signatures using
[LDoc](https://stevedonovan.github.io/ldoc/). Specifying typing information
after each parameter or return value is a nice plus.
```lua
--- Load a local or remote manifest describing a repository.
-- All functions that use manifest tables assume they were obtained
-- through either this function or load_local_manifest.
-- @param repo_url string: URL or pathname for the repository.
-- @param lua_version string: Lua version in "5.x" format, defaults to installed version.
-- @return table or (nil, string, [string]): A table representing the manifest,
-- or nil followed by an error message and an optional error code.
function manif.load_manifest(repo_url, lua_version)
   -- code
end
```
  - Use TODO and FIXME tags in comments. TODO indicates a missing feature to be implemented later. FIXME indicates a problem in the existing code (inefficient implementation, bug, unnecessary code, etc).
```lua
-- TODO: implement method
local function something()
   -- FIXME: check conditions
end
```

  - Prefer LDoc comments over the function that explain what the function does than inline comments inside the function that explain how it does it. Ideally, the implementation should be simple enough so that comments aren't needed. If the function grows complex, split it into multiple functions so that their names explain what each part does.

    **[[⬆]](#TOC)**

## <a name='tables'>Tables</a>

  - Use the constructor syntax for table property creation where possible.

    ```lua
    -- bad
    local player = {}
    player.name = 'Jack'
    player.class = 'Rogue'

    -- good
    local player = {
      name = 'Jack',
      class = 'Rogue'
    }
    ```

  - Define functions externally to table definition.

    ```lua
    -- bad
    local player = {
      attack = function()
      -- ...stuff...
      end
    }

    -- good
    local function attack()
    end

    local player = {
      attack = attack
    }
    ```

  - Consider `nil` properties when selecting lengths.
    A good idea is to store an `n` property on lists that contain the length
    (as noted in [Storing Nils in Tables](http://lua-users.org/wiki/StoringNilsInTables))

    ```lua
    -- nils don't count
    local list = {}
    list[0] = nil
    list[1] = 'item'

    print(#list) -- 0
    print(select('#', list)) -- 1
    ```

  - When tables have functions, use `self` when referring to itself.

    ```lua
    -- bad
    local me = {
      fullname = function(this)
        return this.first_name + ' ' + this.last_name
      end
    }

    -- good
    local me = {
      fullname = function(self)
        return self.first_name + ' ' + self.last_name
      end
    }
    ```

    **[[⬆]](#TOC)**

## <a name='strings'>Strings</a>

  - Use single quotes `''` for strings.

    ```lua
    -- bad
    local name = "Bob Parr"

    -- good
    local name = 'Bob Parr'

    -- bad
    local fullName = "Bob " .. self.lastName

    -- good
    local fullName = 'Bob ' .. self.lastName
    ```

  - Strings longer than 80 characters should be written across multiple lines
    using concatenation. This allows you to indent nicely.

    ```lua
    -- bad
    local errorMessage = 'This is a super long error that was thrown because of Batman. When you stop to think about how Batman had anything to do with this, you would get nowhere fast.'

    -- bad
    local errorMessage = 'This is a super long error that \
    was thrown because of Batman. \
    When you stop to think about \
    how Batman had anything to do \
    with this, you would get nowhere \
    fast.'


    -- bad
    local errorMessage = [[This is a super long error that
      was thrown because of Batman.
      When you stop to think about
      how Batman had anything to do
      with this, you would get nowhere
      fast.]]

    -- good
    local errorMessage = 'This is a super long error that ' ..
      'was thrown because of Batman. ' ..
      'When you stop to think about ' ..
      'how Batman had anything to do ' ..
      'with this, you would get nowhere ' ..
      'fast.'
    ```

    **[[⬆]](#TOC)**


## <a name='functions'>Functions</a>
  - Prefer lots of small functions to large, complex functions. [Smalls Functions Are Good For The Universe](http://kikito.github.io/blog/2012/03/16/small-functions-are-good-for-the-universe/).

  - Prefer function syntax over variable syntax. This helps differentiate
    between named and anonymous functions.

    ```lua
    -- bad
    local nope = function(name, options)
      -- ...stuff...
    end

    -- good
    local function yup(name, options)
      -- ...stuff...
    end
    ```

  - Never name a parameter `arg`, this will take precendence over the `arg` object that is given to every function scope in older versions of Lua.

    ```lua
    -- bad
    local function nope(name, options, arg)
      -- ...stuff...
    end

    -- good
    local function yup(name, options, ...)
      -- ...stuff...
    end
    ```

  - Perform validation early and return as early as possible.

    ```lua
    -- bad
    local is_good_name = function(name, options, arg)
      local is_good = #name > 3
      is_good = is_good and #name < 30

      -- ...stuff...

      return is_bad
    end

    -- good
    local is_good_name = function(name, options, args)
      if #name < 3 or #name > 30 then return false end

      -- ...stuff...

      return true
    end
    ```

  **[[⬆]](#TOC)**


## <a name='properties'>Properties</a>

  - Use dot notation when accessing known properties.

    ```lua
    local luke = {
      jedi = true,
      age = 28
    }

    -- bad
    local isJedi = luke['jedi']

    -- good
    local isJedi = luke.jedi
    ```

  - Use subscript notation `[]` when accessing properties with a variable
    or if using a table as a list.

    ```lua
    local luke = {
      jedi = true,
      age = 28
    }

    local function getProp(prop)
      return luke[prop]
    end

    local isJedi = getProp('jedi')
    ```

    **[[⬆]](#TOC)**


## <a name='variables'>Variables</a>

  - Always use `local` to declare variables. Not doing so will result in
    global variables to avoid polluting the global namespace.

    ```lua
    -- bad
    superPower = SuperPower()

    -- good
    local superPower = SuperPower()
    ```

  - Assign variables at the top of their scope where possible. This makes it
    easier to check for existing variables.

    ```lua
    -- bad
    local bad = function()
      test()
      print('doing stuff..')

      //..other stuff..

      local name = getName()

      if name == 'test' then
        return false
      end

      return name
    end

    -- good
    local function good()
      local name = getName()

      test()
      print('doing stuff..')

      //..other stuff..

      if name == 'test' then
        return false
      end

      return name
    end
    ```

    **[[⬆]](#TOC)**

## <a name='variablescope'>Variable Scope</a>
  - Assign variables with the smallest possible scope.

```lua
-- bad
local function good()
   local name = get_name()

   test()
   print("doing stuff..")

   --...other stuff...

   if name == "test" then
      return false
   end

   return name
end

-- good
local bad = function()
   test()
   print("doing stuff..")

   --...other stuff...

   local name = get_name()

   if name == "test" then
      return false
   end

   return name
end
```

## <a name='conditionals'>Conditional Expressions & Equality</a>

  - False and nil are *falsy* in conditional expressions. All else is true.

    ```lua
    local str = ''

    if str then
      -- true
    end
    ```

  - Use shortcuts when you can, unless you need to know the difference between
    false and nil.

    ```lua
    -- bad
    if name ~= nil then
      -- ...stuff...
    end

    -- good
    if name then
      -- ...stuff...
    end
    ```

  - Prefer *true* statements over *false* statements where it makes sense.
    Prioritize truthy conditions when writing multiple conditions.

    ```lua
    --bad
    if not thing then
      -- ...stuff...
    else
      -- ...stuff...
    end

    --good
    if thing then
      -- ...stuff...
    else
      -- ...stuff...
    end
    ```

  - Prefer defaults to `else` statements where it makes sense. This results in
    less complex and safer code at the expense of variable reassignment, so
    situations may differ.

    ```lua
    --bad
    local function full_name(first, last)
      local name

      if first and last then
        name = first .. ' ' .. last
      else
        name = 'John Smith'
      end

      return name
    end

    --good
    local function full_name(first, last)
      local name = 'John Smith'

      if first and last then
        name = first .. ' ' .. last
      end

      return name
    end
    ```

  - Short ternaries are okay.

    ```lua
    local function default_name(name)
      -- return the default 'Waldo' if name is nil
      return name or 'Waldo'
    end

    local function brew_coffee(machine)
      return machine and machine.is_loaded and 'coffee brewing' or 'fill your water'
    end
    ```


    **[[⬆]](#TOC)**


## <a name='blocks'>Blocks</a>

  - Single line blocks are okay for *small* statements. Try to keep lines to 80 characters.
    Indent lines if they overflow past the limit.

    ```lua
    -- good
    if test then return false end

    -- good
    if test then
      return false
    end

    -- bad
    if test < 1 and do_complicated_function(test) == false or seven == 8 and nine == 10 then do_other_complicated_function()end

    -- good
    if test < 1 and do_complicated_function(test) == false or
        seven == 8 and nine == 10 then

      do_other_complicated_function()
      return false
    end
    ```

    **[[⬆]](#TOC)**


## <a name='whitespace'>Whitespace</a>

  - Use soft tabs set to 2 spaces. Tab characters and 4-space tabs result in public flogging.

    ```lua
    -- bad
    function()
    ∙∙∙∙local name
    end

    -- bad
    function()
    ∙local name
    end

    -- good
    function()
    ∙∙local name
    end
    ```

  - Place 1 space before opening and closing braces. Place no spaces around parens.

    ```lua
    -- bad
    local test = {one=1}

    -- good
    local test = { one = 1 }

    -- bad
    dog.set('attr',{
      age = '1 year',
      breed = 'Bernese Mountain Dog'
    })

    -- good
    dog.set('attr', {
      age = '1 year',
      breed = 'Bernese Mountain Dog'
    })
    ```

  - Place an empty newline at the end of the file.

    ```lua
    -- bad
    (function(global)
      -- ...stuff...
    end)(self)
    ```

    ```lua
    -- good
    (function(global)
      -- ...stuff...
    end)(self)

    ```

  - Surround operators with spaces.

    ```lua
    -- bad
    local thing=1
    thing = thing-1
    thing = thing*1
    thing = 'string'..'s'

    -- good
    local thing = 1
    thing = thing - 1
    thing = thing * 1
    thing = 'string' .. 's'
    ```

  - Use one space after commas.

    ```lua
    --bad
    local thing = {1,2,3}
    thing = {1 , 2 , 3}
    thing = {1 ,2 ,3}

    --good
    local thing = {1, 2, 3}
    ```

  - Add a line break after multiline blocks.

    ```lua
    --bad
    if thing then
      -- ...stuff...
    end
    function derp()
      -- ...stuff...
    end
    local wat = 7

    --good
    if thing then
      -- ...stuff...
    end

    function derp()
      -- ...stuff...
    end

    local wat = 7
    ```

  - Delete unnecessary whitespace at the end of lines.

    **[[⬆]](#TOC)**

## <a name='commas'>Commas</a>

  - Leading commas aren't okay. An ending comma on the last item is okay but discouraged.

    ```lua
    -- bad
    local thing = {
      once = 1
    , upon = 2
    , aTime = 3
    }

    -- good
    local thing = {
      once = 1,
      upon = 2,
      aTime = 3
    }

    -- okay
    local thing = {
      once = 1,
      upon = 2,
      aTime = 3,
    }
    ```

    **[[⬆]](#TOC)**


## <a name='semicolons'>Semicolons</a>

  - **Nope.** Separate statements onto multiple lines.

    ```lua
    -- bad
    local whatever = 'sure';
    a = 1; b = 2

    -- good
    local whatever = 'sure'
    a = 1
    b = 2
    ```

    **[[⬆]](#TOC)**


## <a name='type-coercion'>Type Casting & Coercion</a>

  - Perform type coercion at the beginning of the statement. Use the built-in functions. (`tostring`, `tonumber`, etc.)

  - Use `tostring` for strings if you need to cast without string concatenation.

    ```lua
    -- bad
    local totalScore = reviewScore .. ''

    -- good
    local totalScore = tostring(reviewScore)
    ```

  - Use `tonumber` for Numbers.

    ```lua
    local inputValue = '4'

    -- bad
    local val = inputValue * 1

    -- good
    local val = tonumber(inputValue)
    ```

    **[[⬆]](#TOC)**


## <a name='naming-conventions'>Naming Conventions</a>

  - Avoid single letter names. Be descriptive with your naming. You can get
    away with single-letter names when they are variables in loops.

    ```lua
    -- bad
    local function q()
      -- ...stuff...
    end

    -- good
    local function query()
      -- ..stuff..
    end
    ```

  - Use underscores for ignored variables in loops.

    ```lua
    --good
    for _, name in pairs(names) do
      -- ...stuff...
    end
    ```

  - Use snake_case when naming objects, functions, and instances. Tend towards
    verbosity if unsure about naming.

    ```lua
    -- bad
    local OBJEcttsssss = {}
    local thisIsMyObject = {}
    local this-is-my-object = {}

    local c = function()
      -- ...stuff...
    end

    -- good
    local this_is_my_object = {}

    local function do_that_thing()
      -- ...stuff...
    end
    ```

  - Use PascalCase for factories.

    ```lua
    -- bad
    local player = require('player')

    -- good
    local Player = require('player')
    local me = Player({ name = 'Jack' })
    ```

    **[[⬆]](#TOC)**

  - Use `is` or `has` for boolean-returning functions that are part of tables.

    ```lua
    --bad
    local function evil(alignment)
      return alignment < 100
    end

    --good
    local function is_evil(alignment)
      return alignment < 100
    end
    ```

## <a name='modules'>Modules</a>

  - The module should return a table or function.
  - The module should not use the global namespace for anything ever. The
    module should be a closure.
  - The file should be named like the module.

    ```lua
    -- thing.lua
    local thing = { }

    local meta = {
      __call = function(self, key, vars)
        print key
      end
    }


    return setmetatable(thing, meta)
    ```

  - Note that modules are [loaded as singletons](http://lua-users.org/wiki/TheEssenceOfLoadingCode)
    and therefore should usually be factories (a function returning a new instance of a table)
    unless static (like utility libraries.)

  **[[⬆]](#TOC)**
