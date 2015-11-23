*&---------------------------------------------------------------------*
*&  Practical Object-Oriented Design in ABAP
*&    based on POODR:  Chapter 2;  Page 18
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter2_page18.

START-OF-SELECTION.

  DATA(gv_chainring) = 52.                  " number of teeth
  DATA(gv_cog)       = 11.
  DATA(gv_ratio)     = gv_chainring / CONV f( gv_cog ).
  cl_demo_output=>display( gv_ratio ).      " -> 4.7272727272727275

  gv_chainring = 30.
  gv_cog       = 27.
  gv_ratio     = gv_chainring / CONV f( gv_cog ).
  cl_demo_output=>display( gv_ratio ).      " -> 1.1111111111111112

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 19
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter2_page19.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i,
      ratio
        RETURNING VALUE(rv_ratio) TYPE f,
      chainring
        RETURNING VALUE(rv_chainring) TYPE i,
      cog
        RETURNING VALUE(rv_cog) TYPE i.

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i.
ENDCLASS.

CLASS lcl_gear IMPLEMENTATION.
  METHOD constructor.
    mv_chainring = iv_chainring.
    mv_cog       = iv_cog.
  ENDMETHOD.

  METHOD ratio.
    rv_ratio = chainring( ) / CONV f( cog( ) ).
  ENDMETHOD.

  METHOD chainring.
    rv_chainring = mv_chainring.
  ENDMETHOD.

  METHOD cog.
    rv_cog = mv_cog.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA(go_gear) = NEW lcl_gear( iv_chainring = 52
                                iv_cog       = 11 ).
  cl_demo_output=>display( go_gear->ratio( ) ).
  " -> 4.7272727272727275

  go_gear = NEW lcl_gear( iv_chainring = 30
                          iv_cog       = 27 ).
  cl_demo_output=>display( go_gear->ratio( ) ).
  " -> 1.1111111111111112

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 20
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter2_page20.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i
                  iv_rim       TYPE i
                  iv_tire      TYPE f,
      ratio
        RETURNING VALUE(rv_ratio) TYPE f,
      gear_inches
        RETURNING VALUE(rv_gear_inches) TYPE f,
      chainring
        RETURNING VALUE(rv_chainring) TYPE i,
      cog
        RETURNING VALUE(rv_cog) TYPE i,
      rim
        RETURNING VALUE(rv_rim) TYPE i,
      tire
        RETURNING VALUE(rv_tire) TYPE f.

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i,
      mv_rim       TYPE i,
      mv_tire      TYPE f.
ENDCLASS.

CLASS lcl_gear IMPLEMENTATION.
  METHOD constructor.
    mv_chainring = iv_chainring.
    mv_cog       = iv_cog.
    mv_rim       = iv_rim.
    mv_tire      = iv_tire.
  ENDMETHOD.

  METHOD ratio.
    rv_ratio = chainring( ) / CONV f( cog( ) ).
  ENDMETHOD.

  METHOD gear_inches.
    " tire goes around rim twice for diameter
    rv_gear_inches = ratio( ) * ( rim( ) + ( tire( ) * 2 ) ).
  ENDMETHOD.

  METHOD chainring.
    rv_chainring = mv_chainring.
  ENDMETHOD.

  METHOD cog.
    rv_cog = mv_cog.
  ENDMETHOD.

  METHOD rim.
    rv_rim = mv_rim.
  ENDMETHOD.

  METHOD tire.
    rv_tire = mv_tire.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA(go_gear) = NEW lcl_gear( iv_chainring = 52
                                iv_cog       = 11
                                iv_rim       = 26
                                iv_tire      = '1.5' ).
  cl_demo_output=>display( go_gear->gear_inches( ) ).
  " -> 137.09090909090909

  go_gear = NEW lcl_gear( iv_chainring = 52
                          iv_cog       = 11
                          iv_rim       = 24
                          iv_tire      = '1.25' ).
  cl_demo_output=>display( go_gear->gear_inches( ) ).
  " -> 125.27272727272728


*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 20
*&---------------------------------------------------------------------*
START-OF-SELECTION.

  " didn't this used to work?
  DATA(go_gear) = NEW lcl_gear( iv_chainring = 52
                                iv_cog       = 11 ).
  cl_demo_output=>display( go_gear->ratio( ) ).
  " Error: Line 95: Program YY_PAO_CHAPTER2_PAGE20
  " The obligatory parameter "IV_RIM" had no value assigned to it.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 24
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter2_page24.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i,
      ratio
        RETURNING VALUE(rv_ratio) TYPE f.

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i.
ENDCLASS.

CLASS lcl_gear IMPLEMENTATION.
  METHOD constructor.
    mv_chainring = iv_chainring.
    mv_cog       = iv_cog.
  ENDMETHOD.

  METHOD ratio.
    rv_ratio = mv_chainring / CONV f( mv_cog ).  " <-- road to ruin
  ENDMETHOD.
ENDCLASS.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 25
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter2_page25.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i,
      ratio
        RETURNING VALUE(rv_ratio) TYPE f,
      chainring
        RETURNING VALUE(rv_chainring) TYPE i,    " <-------
      cog
        RETURNING VALUE(rv_cog) TYPE i.          " <-------

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i.
ENDCLASS.

CLASS lcl_gear IMPLEMENTATION.
  METHOD constructor.
    mv_chainring = iv_chainring.
    mv_cog       = iv_cog.
  ENDMETHOD.

  METHOD chainring.
    rv_chainring = mv_chainring.
  ENDMETHOD.

  METHOD cog.
    " default implementation for attribute cog
    rv_cog = mv_cog.
  ENDMETHOD.

  METHOD ratio.
    rv_ratio = chainring( ) / CONV f( cog( ) ).  " <-------
  ENDMETHOD.
ENDCLASS.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 25
*&---------------------------------------------------------------------*

  METHOD cog.
    " a simple reimplementation of cog
    rv_cog = mv_cog * unanticipated_adjustment_factor( ).
  ENDMETHOD.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 25
*&---------------------------------------------------------------------*

  METHOD cog.
    " a more complex one
    rv_cog = mv_cog * COND #( WHEN is_foo( )
                              THEN bar_adjustment( )
                              ELSE baz_adjustment( ) ).
  ENDMETHOD.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 26
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter2_page26.

CLASS lcl_obscuring_references DEFINITION.
  PUBLIC SECTION.
    TYPES:
      tt_data TYPE STANDARD TABLE OF integers WITH EMPTY KEY.
    METHODS:
      constructor
        IMPORTING it_data TYPE tt_data,
      diameters
        RETURNING VALUE(rt_diameters) TYPE integers,
      data
        RETURNING VALUE(rt_data) TYPE tt_data.

  PRIVATE SECTION.
    DATA:
      mt_data TYPE tt_data.
ENDCLASS.

CLASS lcl_obscuring_references IMPLEMENTATION.
  METHOD constructor.
    mt_data = it_data.
  ENDMETHOD.

  METHOD diameters.
    " 0 is rim, 1 is tire
    rt_diameters = VALUE #( FOR cell IN data( )
                            ( cell[ 1 ] + cell[ 2 ] * 2 ) ).
  ENDMETHOD.
  " ... many other methods that index into the array

  METHOD data.
    rt_data = mt_data.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  " rim and tire sizes (now in milimeters!) in a deep table
  DATA(go_example) = NEW lcl_obscuring_references( VALUE #( ( VALUE integers( ( 622 ) ( 20 ) ) )
                                                            ( VALUE integers( ( 622 ) ( 23 ) ) )
                                                            ( VALUE integers( ( 559 ) ( 30 ) ) )
                                                            ( VALUE integers( ( 559 ) ( 40 ) ) ) ) ).
  cl_demo_output=>display( go_example->diameters( ) ).
  " -> 662, 668, 619, 639

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 28
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter2_page28.

CLASS lcl_wheel DEFINITION DEFERRED.

CLASS lcl_revealing_references DEFINITION.
  PUBLIC SECTION.
    TYPES:
      tt_data   TYPE STANDARD TABLE OF integers WITH EMPTY KEY,
      tt_wheels TYPE STANDARD TABLE OF REF TO lcl_wheel WITH EMPTY KEY.
    METHODS:
      constructor
        IMPORTING it_data TYPE tt_data,
      diameters
        RETURNING VALUE(rt_diameters) TYPE integers,
      wheelify
        IMPORTING it_data          TYPE tt_data
        RETURNING VALUE(rt_wheels) TYPE tt_wheels,
      wheels
        RETURNING VALUE(rt_wheels) TYPE tt_wheels.

  PRIVATE SECTION.
    DATA:
      mt_wheels TYPE tt_wheels.
ENDCLASS.

CLASS lcl_wheel DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_rim  TYPE i
                  iv_tire TYPE i,
      rim
        RETURNING VALUE(rv_rim) TYPE i,
      tire
        RETURNING VALUE(rv_tire) TYPE i.

  PRIVATE SECTION.
    DATA:
      mv_rim  TYPE i,
      mv_tire TYPE i.
ENDCLASS.

CLASS lcl_revealing_references IMPLEMENTATION.
  METHOD constructor.
    mt_wheels = wheelify( it_data ).
  ENDMETHOD.

  METHOD diameters.
    rt_diameters = VALUE #( FOR wheel IN wheels( )
                            ( wheel->rim( ) + ( wheel->tire( ) * 2 ) ) ).
  ENDMETHOD.
  " ... now everyone can send rim( ) & tire( ) to wheel

  METHOD wheelify.
    rt_wheels = VALUE #( FOR cell IN it_data
                         ( NEW lcl_wheel( iv_rim  = cell[ 1 ]
                                          iv_tire = cell[ 2 ] ) ) ).
  ENDMETHOD.

  METHOD wheels.
    rt_wheels = mt_wheels.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_wheel IMPLEMENTATION.
  METHOD constructor.
    mv_rim  = iv_rim.
    mv_tire = iv_tire.
  ENDMETHOD.

  METHOD rim.
    rv_rim = mv_rim.
  ENDMETHOD.

  METHOD tire.
    rv_tire = mv_tire.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA(go_example) = NEW lcl_revealing_references( VALUE #( ( VALUE integers( ( 622 ) ( 20 ) ) )
                                                            ( VALUE integers( ( 622 ) ( 23 ) ) )
                                                            ( VALUE integers( ( 559 ) ( 30 ) ) )
                                                            ( VALUE integers( ( 559 ) ( 40 ) ) ) ) ).
  cl_demo_output=>display( go_example->diameters( ) ).
  " -> 662, 668, 619, 639

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 29
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter2_page29.

CLASS lcl_revealing_references DEFINITION.
  PUBLIC SECTION.
    METHODS:
      diameters
        RETURNING VALUE(rt_diameters) TYPE integers.
      "...

ENDCLASS.

CLASS lcl_revealing_references IMPLEMENTATION.
  METHOD diameters.
    rt_diameters = VALUE #( FOR wheel IN wheels( )
                            ( wheel->rim( ) + ( wheel->tire( ) * 2 ) ) ).
  ENDMETHOD.

  "...
ENDCLASS.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 29
*&---------------------------------------------------------------------*

CLASS lcl_revealing_references DEFINITION.
  PUBLIC SECTION.
    METHODS:
      diameters
        RETURNING VALUE(rt_diameters) TYPE integers,
      diameter
        IMPORTING io_wheel           TYPE REF TO lcl_wheel
        RETURNING VALUE(rv_diameter) TYPE i.
      "...

ENDCLASS.

CLASS lcl_revealing_references IMPLEMENTATION.
  METHOD diameters.
    " first - iterate over the table
    rt_diameters = VALUE #( FOR wheel IN wheels( )
                            ( diameter( wheel ) ) ).
  ENDMETHOD.

  METHOD diameter.
    " second - calculate diameter of ONE wheel
    rv_diameter = io_wheel->rim( ) + ( io_wheel->tire( ) * 2 ).
  ENDMETHOD.

  "...
ENDCLASS.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 30
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter2_page30.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i
                  iv_rim       TYPE i
                  iv_tire      TYPE f,
      ratio
        RETURNING VALUE(rv_ratio) TYPE f,
      gear_inches
        RETURNING VALUE(rv_gear_inches) TYPE f,
      diameter
        RETURNING VALUE(rv_diameter) TYPE f.
      "...

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i,
      mv_rim       TYPE i,
      mv_tire      TYPE f.
ENDCLASS.

CLASS lcl_gear IMPLEMENTATION.
  METHOD constructor.
    mv_chainring = iv_chainring.
    mv_cog       = iv_cog.
    mv_rim       = iv_rim.
    mv_tire      = iv_tire.
  ENDMETHOD.

  METHOD ratio.
    rv_ratio = chainring( ) / CONV f( cog( ) ).
  ENDMETHOD.

  METHOD gear_inches.
    rv_gear_inches = ratio( ) * diameter( ).
  ENDMETHOD.

  METHOD diameter.
    rv_diameter = rim( ) + ( tire( ) * 2 ).
  ENDMETHOD.

  "...
ENDCLASS.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 32
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter2_page32.

CLASS lcl_wheel DEFINITION DEFERRED.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i
                  iv_rim       TYPE i
                  iv_tire      TYPE f,
      ratio
        RETURNING VALUE(rv_ratio) TYPE f,
      gear_inches
        RETURNING VALUE(rv_gear_inches) TYPE f.
      "...

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i,
      mo_wheel     TYPE REF TO lcl_wheel.
ENDCLASS.

CLASS lcl_wheel DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_rim  TYPE i
                  iv_tire TYPE f,
      diameter
        RETURNING VALUE(rv_diameter) TYPE f.
      "...

  PRIVATE SECTION.
    DATA:
      mv_rim  TYPE i,
      mv_tire TYPE f.
ENDCLASS.

CLASS lcl_gear IMPLEMENTATION.
  METHOD constructor.
    mv_chainring = iv_chainring.
    mv_cog       = iv_cog.
    mo_wheel     = NEW #( iv_rim  = iv_rim
                          iv_tire = iv_tire ).
  ENDMETHOD.

  METHOD ratio.
    rv_ratio = chainring( ) / CONV f( cog( ) ).
  ENDMETHOD.

  METHOD gear_inches.
    rv_gear_inches = ratio( ) * wheel( )->diameter( ).
  ENDMETHOD.

  "...
ENDCLASS.

CLASS lcl_wheel IMPLEMENTATION.
  METHOD constructor.
    mv_rim  = iv_rim.
    mv_tire = iv_tire.
  ENDMETHOD.

  METHOD diameter.
    rv_diameter = rim( ) + ( tire( ) * 2 ).
  ENDMETHOD.

  "...
ENDCLASS.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 2;  Page 33
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter2_page33.

CLASS lcl_wheel DEFINITION DEFERRED.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i
                  io_wheel     TYPE REF TO lcl_wheel OPTIONAL,
      ratio
        RETURNING VALUE(rv_ratio) TYPE f,
      gear_inches
        RETURNING VALUE(rv_gear_inches) TYPE f,
      chainring
        RETURNING VALUE(rv_chainring) TYPE i,
      cog
        RETURNING VALUE(rv_cog) TYPE i,
      wheel
        RETURNING VALUE(ro_wheel) TYPE REF TO lcl_wheel.

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i,
      mo_wheel     TYPE REF TO lcl_wheel.
ENDCLASS.

CLASS lcl_wheel DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_rim  TYPE i
                  iv_tire TYPE f,
      diameter
        RETURNING VALUE(rv_diameter) TYPE f,
      circumference
        RETURNING VALUE(rv_circumference) TYPE f,
      rim
        RETURNING VALUE(rv_rim) TYPE i,
      tire
        RETURNING VALUE(rv_tire) TYPE f.

  PRIVATE SECTION.
    CONSTANTS pi TYPE decfloat34
                 VALUE '3.141592653589793238462643383279503'.
    DATA:
      mv_rim  TYPE i,
      mv_tire TYPE f.
ENDCLASS.

CLASS lcl_gear IMPLEMENTATION.
  METHOD constructor.
    mv_chainring = iv_chainring.
    mv_cog       = iv_cog.
    mo_wheel     = io_wheel.
  ENDMETHOD.

  METHOD ratio.
    rv_ratio = chainring( ) / CONV f( cog( ) ).
  ENDMETHOD.

  METHOD gear_inches.
    rv_gear_inches = ratio( ) * wheel( )->diameter( ).
  ENDMETHOD.

  METHOD chainring.
    rv_chainring = mv_chainring.
  ENDMETHOD.

  METHOD cog.
    rv_cog = mv_cog.
  ENDMETHOD.

  METHOD wheel.
    ro_wheel = mo_wheel.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_wheel IMPLEMENTATION.
  METHOD constructor.
    mv_rim  = iv_rim.
    mv_tire = iv_tire.
  ENDMETHOD.

  METHOD diameter.
    rv_diameter = rim( ) + ( tire( ) * 2 ).
  ENDMETHOD.

  METHOD circumference.
    rv_circumference = diameter( ) * pi.
  ENDMETHOD.

  METHOD rim.
    rv_rim = mv_rim.
  ENDMETHOD.

  METHOD tire.
    rv_tire = mv_tire.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA(go_wheel) = NEW lcl_wheel( iv_rim  = 26
                                  iv_tire = '1.5' ).
  cl_demo_output=>display( go_wheel->circumference( ) ).
  " -> 91.106186954104004

  DATA(go_gear) = NEW lcl_gear( iv_chainring = 52
                                iv_cog       = 11
                                io_wheel     = go_wheel ).
  cl_demo_output=>display( go_gear->gear_inches( ) ).
  " -> 137.09090909090909

  go_gear = NEW lcl_gear( iv_chainring = 52
                          iv_cog       = 11 ).
  cl_demo_output=>display( go_gear->ratio( ) ).
  " -> 4.7272727272727275
