

# Multi page input app

- This app is designed to distribute the input fields across multiple pages so the user doesn't feel overwhelmed.


* Abstract

- Define a single entity class for storing the state of input fields.
- Depending on the fields categorise them.
- Create forms based on these categories.
- Create UI for all the forms and link state of entity to each form.
- Link each form in a proper sequence so that user can navigate between forms.
- Show the entered data to the user on the last page.


* Excercise 

1. Create a system for collecting farm related data from farmers. The data should contain information about the farmer, farmland, crops grown by the farmer, allied businesses operated by the farmer, farming techniques used by farmer (it should also include use of modern technologies which are used and owned by farmer).

-->

    1. Information about farmer.
        - name
        - address
        - education
        - background of parents
        - Career inception in farming
        - career span in farming
    
    2. farmland.
        - no. of farm properties at different locations

        --- collect below details for each farm property seperately 
        - area of farmland
        - location

    3. Crops grown by farmer.
        Aim: aim is to collect the last 2 years data for the crops grown per acre in a single year.

        - Name of Crop
        - Crop plantation date
        - Crop harvest date
        - Yield
        - Area of plantation
        - Cost accrued
        - labour cost
        - fertilizers cost
        - pesticides cost
        - Farm tools and services costs
        - plantation material cost
        - type of plantation material (seeds, saplings, plants)

    4. Allied businesses operated by farmer.
        - No. of businesses
        - Name of business
        - income (can be yearly, half yearly, quaterly, monthly)
        - people employed
        - farm tools used 
        - natural resource requirements (land, water, electricity, plants)

    5. Farming techniques used by farmer.

        -- No. of tools used and categorise them
    
        - Tools used (simple machine tools)
        - modern technologies used
        - diesel, petrol, eletricity or other requirements for those modern tools
        - people employed

    