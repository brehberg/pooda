*&---------------------------------------------------------------------*
*&  Practical Object-Oriented Design in ABAP
*&    based on POODR:  Chapter 3;  Page 36
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter3_page36.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i
                  iv_rim       TYPE i
                  iv_tire      TYPE f,
      gear_inches
        RETURNING VALUE(rv_gear_inches) TYPE f,
      ratio
        RETURNING VALUE(rv_ratio) TYPE f,
      chainring
        RETURNING VALUE(rv_chainring) TYPE i,
      cog
        RETURNING VALUE(rv_cog) TYPE i,
      rim
        RETURNING VALUE(rv_rim) TYPE i,
      tire
        RETURNING VALUE(rv_tire) TYPE f.
    "...

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i,
      mv_rim       TYPE i,
      mv_tire      TYPE f.
ENDCLASS.

CLASS lcl_wheel DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_rim  TYPE i
                  iv_tire TYPE f,
      diameter
        RETURNING VALUE(rv_diameter) TYPE f,
      rim
        RETURNING VALUE(rv_rim) TYPE i,
      tire
        RETURNING VALUE(rv_tire) TYPE f.
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
    mv_rim       = iv_rim.
    mv_tire      = iv_tire.
  ENDMETHOD.

  METHOD gear_inches.
    rv_gear_inches = ratio( ) * NEW lcl_wheel( iv_rim  = rim( )
                                               iv_tire = tire( ) )->diameter( ).
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

  METHOD rim.
    rv_rim = mv_rim.
  ENDMETHOD.

  METHOD tire.
    rv_tire = mv_tire.
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

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 3;  Page 39
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter3_page39.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i
                  iv_rim       TYPE i
                  iv_tire      TYPE f,
      gear_inches
        RETURNING VALUE(rv_gear_inches) TYPE f.
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

  METHOD gear_inches.
    rv_gear_inches = ratio( ) * NEW lcl_wheel( iv_rim  = rim( )
                                               iv_tire = tire( ) )->diameter( ).
  ENDMETHOD.

  "...
ENDCLASS.


START-OF-SELECTION.

  DATA(go_gear) = NEW lcl_gear( iv_chainring = 52
                                iv_cog       = 11
                                iv_rim       = 26
                                iv_tire      = '1.5' ).

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 3;  Page 41
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter3_page41.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i
                  io_wheel     TYPE REF TO object,
      gear_inches
        RETURNING VALUE(rv_gear_inches) TYPE f,
      diameter
        RETURNING VALUE(rv_diameter) TYPE f.
    "...

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i,
      mo_wheel     TYPE REF TO object.
ENDCLASS.

CLASS lcl_gear IMPLEMENTATION.
  METHOD constructor.
    mv_chainring = iv_chainring.
    mv_cog       = iv_cog.
    mo_wheel     = io_wheel.
  ENDMETHOD.

  METHOD gear_inches.
    rv_gear_inches = ratio( ) * diameter( ).
  ENDMETHOD.

  METHOD diameter.
    DATA(lo_wheel) = wheel( ).
    DATA(lv_method) = |DIAMETER|.
    CALL METHOD lo_wheel->(lv_method)
      RECEIVING rv_diameter = rv_diameter.
  ENDMETHOD.

  "...
ENDCLASS.


START-OF-SELECTION.

  " Gear expects a 'Duck' that knows 'diameter'
  DATA(go_gear) = NEW lcl_gear( iv_chainring = 52
                                iv_cog       = 11
                                io_wheel     = NEW lcl_wheel( iv_rim  = 26
                                                              iv_tire = '1.5' ) ).

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 3;  Page 43
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter3_page43a.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i
                  iv_rim       TYPE i
                  iv_tire      TYPE f,
      gear_inches
        RETURNING VALUE(rv_gear_inches) TYPE f.
    "...

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i,
      mv_rim       TYPE i,
      mv_tire      TYPE f,
      mo_wheel     TYPE REF TO lcl_wheel.
ENDCLASS.

CLASS lcl_gear IMPLEMENTATION.
  METHOD constructor.
    mv_chainring = iv_chainring.
    mv_cog       = iv_cog.
    mv_rim       = iv_rim.
    mv_tire      = iv_tire.
    mo_wheel     = NEW #( iv_rim  = iv_rim
                          iv_tire = iv_tire ).
  ENDMETHOD.

  METHOD gear_inches.
    rv_gear_inches = ratio( ) * wheel( )->diameter( ).
  ENDMETHOD.

  "...
ENDCLASS.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 3;  Page 43
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter3_page43b.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i
                  iv_rim       TYPE i
                  iv_tire      TYPE f,
      gear_inches
        RETURNING VALUE(rv_gear_inches) TYPE f.
    "...

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i,
      mv_rim       TYPE i,
      mv_tire      TYPE f,
      mo_wheel     TYPE REF TO lcl_wheel.
ENDCLASS.

CLASS lcl_gear IMPLEMENTATION.
  METHOD constructor.
    mv_chainring = iv_chainring.
    mv_cog       = iv_cog.
    mv_rim       = iv_rim.
    mv_tire      = iv_tire.
  ENDMETHOD.

  METHOD gear_inches.
    rv_gear_inches = ratio( ) * wheel( )->diameter( ).
  ENDMETHOD.

  METHOD wheel.
    IF mo_wheel IS NOT BOUND.
      mo_wheel = NEW #( iv_rim  = rim( )
                        iv_tire = tire( ) ).
    ENDIF.
    ro_wheel = mo_wheel.
  ENDMETHOD.

  "...
ENDCLASS.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 3;  Page 44
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter3_page44.


  METHOD gear_inches.
    rv_gear_inches = ratio( ) * wheel( )->diameter( ).
  ENDMETHOD.


  METHOD gear_inches.
    "... a few lines of scary math
    DATA(lv_foo) = some_intermediate_result( ) * wheel( )->diameter( ).
    "... more lines of scary math
  ENDMETHOD.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 3;  Page 45
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter3_page45.


  METHOD gear_inches.
    "... a few lines of scary math
    DATA(lv_foo) = some_intermediate_result( ) * diameter( ).
    "... more lines of scary math
  ENDMETHOD.


  METHOD diameter.
    rv_diameter = wheel( )->diameter( ).
  ENDMETHOD.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 3;  Page 46
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter3_page46.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i
                  io_wheel     TYPE REF TO lcl_wheel.
    "...

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i,
      mo_wheel     TYPE REF TO lcl_wheel.
ENDCLASS.

CLASS lcl_gear IMPLEMENTATION.
  METHOD constructor.
    mv_chainring = iv_chainring.
    mv_cog       = iv_cog.
    mo_wheel     = io_wheel.
  ENDMETHOD.

  "...
ENDCLASS.

  DATA(go_gear) = NEW lcl_gear( iv_chainring = 52
                                iv_cog       = 11
                                io_wheel     = NEW #( iv_rim  = 26
                                                      iv_tire = '1.5' ) ).

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 3;  Page 47
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter3_page47.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    TYPES:
      BEGIN OF ts_arg,
        key  TYPE string,
        dref TYPE REF TO data,
        oref TYPE REF TO object,
      END OF ts_arg,
      tt_arg TYPE SORTED TABLE OF ts_arg WITH UNIQUE KEY key.
    METHODS:
      constructor
        IMPORTING it_args TYPE tt_arg.
    "...

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i,
      mo_wheel     TYPE REF TO lcl_wheel.
ENDCLASS.

CLASS lcl_gear IMPLEMENTATION.
  METHOD constructor.
    mv_chainring = CAST i( it_args[ key = |chainring| ]-dref )->*.
    mv_cog       = CAST i( it_args[ key = |cog| ]-dref )->*.
    mo_wheel     = CAST #( it_args[ key = |wheel| ]-oref ).
  ENDMETHOD.

  "...
ENDCLASS.


START-OF-SELECTION.

  DATA(go_gear) = NEW lcl_gear( VALUE #( ( VALUE #( key  = |chainring|
                                                    dref = REF i( 52 ) ) )
                                         ( VALUE #( key  = |cog|
                                                    dref = REF i( 11 ) ) )
                                         ( VALUE #( key  = |wheel|
                                                    oref = NEW lcl_wheel( iv_rim  = 26
                                                                          iv_tire = '1.5' ) ) ) ) ).

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 3;  Page 48
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter3_page48.

  " specifying defaults using COND( ) & line_exists( )
  METHOD constructor.
    mv_chainring = COND #( WHEN line_exists( it_args[ key = |chainring| ] )
                           THEN CAST i( it_args[ key = |chainring| ]-dref )->*
                           ELSE 40 ).
    mv_cog       = COND #( WHEN line_exists( it_args[ key = |cog| ] )
                           THEN CAST i( it_args[ key = |cog| ]-dref )->*
                           ELSE 18 ).
    mo_wheel     = CAST #( it_args[ key = |wheel| ]-oref ).
  ENDMETHOD.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 3;  Page 49
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter3_page49a.

  " specifying defaults using VALUE( ) & DEFAULT
  METHOD constructor.
    DATA(lr_chainring) = VALUE #( it_args[ key = |chainring| ]-dref
                                  DEFAULT REF i( 40 ) ).
    DATA(lr_cog)       = VALUE #( it_args[ key = |cog| ]-dref
                                  DEFAULT REF i( 18 ) ).
    mv_chainring = CAST i( lr_chainring )->*.
    mv_cog       = CAST i( lr_cog )->*.
    mo_wheel     = CAST #( it_args[ key = |wheel| ]-oref ).
  ENDMETHOD.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 3;  Page 49
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter3_page49b.

  " specifying defaults by filtering a defaults table
  METHOD constructor.
    DATA(lt_args) = VALUE #( BASE it_args
                             FOR arg IN
                               FILTER tt_arg( defaults( )
                                              EXCEPT IN it_args
                                              WHERE key = key )
                             ( arg ) ).
    mv_chainring = CAST i( lt_args[ key = |chainring| ]-dref )->*.
    mv_cog       = CAST i( lt_args[ key = |cog| ]-dref )->*.
    mo_wheel     = CAST #( lt_args[ key = |wheel| ]-oref ).
  ENDMETHOD.

  METHOD defaults.
    rt_args = VALUE #( ( VALUE #( key  = |chainring|
                                  dref = REF i( 20 ) ) )
                       ( VALUE #( key  = |cog|
                                  dref = REF i( 11 ) ) ) ).
  ENDMETHOD.

*&---------------------------------------------------------------------*
*&    based on POODR:  Chapter 3;  Page 52
*&---------------------------------------------------------------------*
REPORT yy_pao_chapter3_page52.

CLASS lcl_gear DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_chainring TYPE i
                  iv_cog       TYPE i,
      gear_inches
        IMPORTING iv_diameter           TYPE f
        RETURNING VALUE(rv_gear_inches) TYPE f,
      ratio
        RETURNING VALUE(rv_ratio) TYPE f.
    "...

  PRIVATE SECTION.
    DATA:
      mv_chainring TYPE i,
      mv_cog       TYPE i.
ENDCLASS.

CLASS lcl_wheel DEFINITION.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING iv_rim       TYPE i
                  iv_tire      TYPE f
                  iv_chainring TYPE i
                  iv_cog       TYPE i,
      diameter
        RETURNING VALUE(rv_diameter) TYPE f,
      gear_inches
        RETURNING VALUE(rv_gear_inches) TYPE f.
    "...

  PRIVATE SECTION.
    DATA:
      mv_rim  TYPE i,
      mv_tire TYPE f,
      mo_gear TYPE REF TO lcl_gear.
ENDCLASS.

CLASS lcl_gear IMPLEMENTATION.
  METHOD constructor.
    mv_chainring = iv_chainring.
    mv_cog       = iv_cog.
  ENDMETHOD.

  METHOD gear_inches.
    rv_gear_inches = ratio( ) * iv_diameter.
  ENDMETHOD.

  METHOD ratio.
    rv_ratio = chainring( ) / CONV f( cog( ) ).
  ENDMETHOD.

  "...
ENDCLASS.

CLASS lcl_wheel IMPLEMENTATION.
  METHOD constructor.
    mv_rim  = iv_rim.
    mv_tire = iv_tire.
    mo_gear = NEW #( iv_chainring = iv_chainring
                     iv_cog       = iv_cog ).
  ENDMETHOD.

  METHOD diameter.
    rv_diameter = rim( ) + ( tire( ) * 2 ).
  ENDMETHOD.

  METHOD gear_inches.
    rv_gear_inches = gear( )->gear_inches( diameter( ) ).
  ENDMETHOD.

  "...
ENDCLASS.


START-OF-SELECTION.

  DATA(go_wheel) = NEW lcl_wheel( iv_rim       = 26
                                  iv_tire      = '1.5'
                                  iv_chainring = 52
                                  iv_cog       = 11 ).
