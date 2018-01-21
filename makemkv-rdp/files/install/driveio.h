/*
    libDriveIo - MMC drive interrogation library

    Copyright (C) 2007-2017 GuinpinSoft inc <libdriveio@makemkv.com>

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

*/
#ifndef LIBRIVEIO_DRIVEIO_H_INCLUDED
#define LIBRIVEIO_DRIVEIO_H_INCLUDED

#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include "scsicmd.h"

#define LIBDRIVEIO_VERSION "1.03"

//
// All values in enums below are fixed, new values may be added
// but none may be renamed or removed.
//
typedef enum _DriveInfoCategory {
    dicat_Invalid=0,
    dicat_DriveStandard=1,
    dicat_DriveSpecific=2,
    dicat_DiscStandard=3,
    dicat_DiscSpecific=4,
    dicat_UserPrivate=5,
    dicat_MaxValue
} DriveInfoCategory;

//
// DriveInfoId is a 4-byte integer
//
// 31......24 23..16 16.0
// [Category] [Type] [Id]
//
typedef enum _DriveInfoId
{
    // dicat_Invalid
    diid_InvalidValue=0,
    diid_DriveioTag=(dicat_Invalid<<24) + (1<<16),
    //diid_DriveioPad=(dicat_Invalid<<24) + (2<<16),

    // dicat_DriveStandard
    diid_InquiryData=(dicat_DriveStandard<<24)+(0<<16),
    diid_FeatureDescriptor=(dicat_DriveStandard<<24)+(1<<16),
    diid_FeatureDescriptor_DriveSerialNumber=(dicat_DriveStandard<<24)+(1<<16)+0x108,
    diid_FeatureDescriptor_FirmwareInformation=(dicat_DriveStandard<<24)+(1<<16)+0x10c,
    diid_FeatureDescriptor_AACS=(dicat_DriveStandard<<24)+(1<<16)+0x10d,
    diid_CurrentProfile=(dicat_DriveStandard<<24)+(2<<16)+0,
    diid_DriveCert=(dicat_DriveStandard<<24)+(3<<16)+0x38,

    // dicat_DriveSpecific
    diid_FirmwareDetailsString=(dicat_DriveSpecific<<24)+0+1,
    diid_FirmwarePlatform=(dicat_DriveSpecific<<24)+0+1,
    diid_FirmwareVendorSpecificInfo=(dicat_DriveSpecific<<24)+0+2,
    diid_FirmwareFlashImage=(dicat_DriveSpecific<<24)+0+3,

    // dicat_DiscStandard
    diid_DiscStructure=(dicat_DiscStandard<<24)+(0<<16),
    diid_DiscStructure_DVD_PhysicalFormat=(dicat_DiscStandard<<24)+(0<<16)+0x000,
    diid_DiscStructure_DVD_CopyrightInformation=(dicat_DiscStandard<<24)+(0<<16)+0x001,
    diid_DiscStructure_BD_DiscInformation=(dicat_DiscStandard<<24)+(0<<16)+0x100,
    diid_TOC=(dicat_DiscStandard<<24)+(1<<16),
    diid_DiscInformation=(dicat_DiscStandard<<24)+(2<<16),
    diid_DiscCapacity=(dicat_DiscStandard<<24)+(3<<16),

    // dicat_DiscSpecific
    diid_Aacs=(dicat_DiscSpecific<<24)+(0<<16),
    diid_Aacs_VID=(dicat_DiscSpecific<<24)+(0<<16)+0x80,
    diid_Aacs_KCD=(dicat_DiscSpecific<<24)+(0<<16)+0x7f,
    diid_Aacs_PMSN=(dicat_DiscSpecific<<24)+(0<<16)+0x81,
    diid_Aacs_MID=(dicat_DiscSpecific<<24)+(0<<16)+0x82,
    diid_Aacs_DataKeys=(dicat_DiscSpecific<<24)+(0<<16)+0x84,
    diid_Aacs_BEExtents=(dicat_DiscSpecific<<24)+(0<<16)+0x85,
    diid_Aacs_BindingNonce=(dicat_DiscSpecific<<24)+(0<<16)+0x7e,

    diidMaxValue
} DriveInfoId;

typedef enum _DriveIoQueryType
{
    // query
    diq_QueryAllInfo=0,
    diq_QueryDriveInfo=1,
    diq_QueryDiscInfo=2,
    diq_QueryTotalDriveInfo=3,

    // perform action
    dia_UnlockMediaAccess=100,

    diq_MaxValue
} DriveIoQueryType;

//
// Structs
//
typedef struct _DriveInfoItem
{
    DriveInfoId     Id;
    const uint8_t*  Data;
    size_t          Size;
} DriveInfoItem;

//
// Opaque types
//
struct _DriveInfoList;
typedef struct _DriveInfoList* DIO_INFOLIST;

#ifdef __cplusplus
extern "C" {
#endif

//
// Defenitions
//

//
// All functions that return int follow unix API convention
// zero on return means success
// non-zero means failure
//
#if defined(_WIN32) || defined(_MSC_VER)
#define         DIO_CDECL   __cdecl
#else
#define         DIO_CDECL
#endif

typedef int (DIO_CDECL *DriveIoExecScsiCmdFunc)(void *Context,const ScsiCmd* Cmd,ScsiCmdResponse *CmdResult);


//
// DriveInfoList manipulation
//
DIO_INFOLIST    DIO_CDECL   DriveInfoList_Create();
void            DIO_CDECL   DriveInfoList_Destroy(DIO_INFOLIST List);
size_t          DIO_CDECL   DriveInfoList_GetCount(DIO_INFOLIST List);
void            DIO_CDECL   DriveInfoList_GetItem(DIO_INFOLIST List,size_t Index,DriveInfoItem *Item);
int             DIO_CDECL   DriveInfoList_GetItemById(DIO_INFOLIST List,DriveInfoId Id,DriveInfoItem *Item);
int             DIO_CDECL   DriveInfoList_AddItem(DIO_INFOLIST List,DriveInfoId Id,const void* Data,size_t Size);
int             DIO_CDECL   DriveInfoList_AddOrUpdateItem(DIO_INFOLIST List, DriveInfoId Id, const void* Data, size_t Size);
size_t          DIO_CDECL   DriveInfoList_Serialize(DIO_INFOLIST List, void* Buffer, size_t BufferSize);
DIO_INFOLIST    DIO_CDECL   DriveInfoList_Deserialize(const void* Buffer,size_t BufferSize);
size_t          DIO_CDECL   DriveInfoList_GetSerializedChunkSize(const void* Buffer);
void            DIO_CDECL   DriveInfoList_GetSerializedChunkInfo(const void* Buffer,DriveInfoItem *Item);

//
// Query API
//
int             DIO_CDECL   DriveIoQuery(DriveIoExecScsiCmdFunc ScsiProc,void* ScsiContext,DriveIoQueryType QueryType,DIO_INFOLIST* InfoList);


//
// TIPS - Trivial IP SCSI tunneling.
//
int             DIO_CDECL   TIPS_ClientConnect(const char* ServerAddress,DriveIoExecScsiCmdFunc* ScsiProc,void** ScsiContext);
void            DIO_CDECL   TIPS_ClientDestroy(void* ScsiContext);
int             DIO_CDECL   TIPS_ServerRun(FILE* fLog,const char* BindAddress,DriveIoExecScsiCmdFunc ScsiProc,void* ScsiContext);

#ifdef __cplusplus
};
#endif

//
// C++ wrappers. All functions are inline, and interaction to library
// is only via calling of C functions
//
#if defined(__cplusplus) && (!defined(LIBDRIVEIO_NO_CPP))

//
// C++ wrapper API
//
static inline int DIO_CDECL DriveIoSimpleScsiWrapperExecScsiCmdFunc(void *Context,const ScsiCmd* Cmd,ScsiCmdResponse *CmdResult)
{
    return ((ISimpleScsiTarget*)Context)->Exec(Cmd,CmdResult);
}

static inline int DriveIoQuery(ISimpleScsiTarget* ScsiTarget,DriveIoQueryType QueryType,DIO_INFOLIST* InfoList)
{
    return DriveIoQuery(&DriveIoSimpleScsiWrapperExecScsiCmdFunc,(void*)ScsiTarget,QueryType,InfoList);
}

//
// C++ wrapper classes
//
class CDriveInfoList
{
private:
    DIO_INFOLIST    m_list;
public:
    inline CDriveInfoList(DIO_INFOLIST List) : m_list(NULL)
    {
    }
    inline void Destroy()
    {
        if (NULL!=m_list)
        {
            DriveInfoList_Destroy(m_list);
            m_list=NULL;
        }
    }
    inline bool Create()
    {
        Destroy();
        m_list = DriveInfoList_Create();
        return (NULL!=m_list);
    }
};

#endif

#endif // LIBRIVEIO_DRIVEIO_H_INCLUDED

