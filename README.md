# building-test-project-tutorial

Tutorial project for Building a project from the test case.

## Test plan

### UI

- Happy Path Contact Form
- Contact Form Errors Templated Test
- Admin Menu Tour Test

### REST API

- Happy Path Contact Form
- Happy Path Admin Check Messages

### UI + REST API

- URL Navigation Test

## Core Project Checklist

- Choose Testing Tool: Robot Framework
- Choose Language (usually determined by tool): python
- Choose Dependency Manager: poetry
- Choose Core Libraries: Selenium for UI, Requests for REST API
- Choose IDE Tooling: VSCode, Robotcode

## The Variable Only Approach

### Pros

- Basic Abstraction to business language
- Somewhat maintainable

### Cons

- Too many variables can be difficult to update
- Risk of polluting scope
- Using native library keywords only is verbose and inflexible

## The First Level of Abstraction

- Change to a Keyword centric approach
- Wrap library keywords within Business Language Keywords
- simple args
- simple returns
- should be easy to update

## A Note about Page Object Model

- Switch from "Page" Object Model => "Page Object" Model
- A single "page" can contain multiple "page objects"
- Organized by functional aspects of a "page"
- Compositional style

## How to effectively use variables

- treat as objects with attributes (i.e. dictionaries)
- limit global variables
- suite scope when needing override
- test scope in tests: documentation important
- leverage variable files to manage configurations

## Two Level abstraction

- Combine business language keywords into single keyword
- single optional arguments up to 5
- var args or dict arg for 5 or more

## Utilities

- Generic keyword composed of library keywords
- No business relationship
- should be easy to port to other projects

## Folder structure

### Resources

- Common (project): Test Tooling imports, Environment Data
- Common (product)
- Common (interface)
- Product
- Interface: UI, DB, REST API, etc...
- Utilities

### Tests

- Product/Interface
- TestResources
- Suites: suffix Tests
- Tests: suffix Test

### Results

Stub out the folder with a gitkeep file.
update gitignore

### CustomLibraries

user python libraries

### Listeners

python listeners

## Resource Pattern

### Composite Pattern

In RF this works well since it is hierarchical in the way it imports Libraries, Resources, and Variables.
While not strictly a composite pattern, it embraces many of the ideas of this pattern.

#### Leaf

Small well defined keywords, mostly in the 1st abstraction.

Typical resources found at this level:

- Page Objects
- Variable Files
- API Keywords

#### Component

Mostly a place that brings together 1st abstraction keywords and other additional utility keywords.

#### Interface

A single file to collect all the leaves/components.
Can contain more complex keywords in the 2nd/3rd abstraction space.

### The Rocky River

RoboCon 2024 Tutorial - Working with Resources, Libraries and Variables: patterns and pitfalls

<https://www.youtube.com/watch?v=8wx7rJxtMBg>

A Guide to the Rocky River

<https://seddonym.me/2018/09/16/rocky-river-pattern/>
