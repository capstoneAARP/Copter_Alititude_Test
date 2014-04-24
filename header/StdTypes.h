#ifndef _STDTYPES_H_
#define _STDTYPES_H_

typedef unsigned char                 uint8;
typedef signed char                 int8;
typedef unsigned int                 uint16;
typedef signed int                 int16;
typedef unsigned long                 uint32;
typedef signed long                 int32;
typedef unsigned long long         uint64;
typedef signed long long         int64;

typedef unsigned char       uint8_t;
typedef unsigned int        uint16_t;
typedef unsigned long       uint32_t;

typedef unsigned char                 boolean;

#define true                          0
#define false                         1

#define ONE_EIGHTY_DIVIDED_PI   57.29577951308
#define PI_DIVIDED_180          0.017453292519943

typedef enum 
{
        NORTH = 0,
        SOUTH,
        EAST,
        WEST,
        MAX_DIRECTION
} direction;

typedef enum
{
        BEACON_MODE = 0,
        OBSTACLE_MODE,
        ALL_STOP_MODE,
        FOUND_THAT_SHIT_MODE,
        MAX_MODE
} mode;

#endif // _STDTYPES_H_