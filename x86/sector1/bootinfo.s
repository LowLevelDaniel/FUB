.code16
bootsector:
 iOEM:          .ascii "FUB      "    # OEM String
 iSectSize:     .word  0             # bytes per sector
 iClustSize:    .byte  0             # sectors per cluster
 iResSect:      .word  0             # #of reserved sectors
 iFatCnt:       .byte  0             # #of FAT copies
 iRootSize:     .word  0             # size of root directory
 iTotalSect:    .word  0             # total # of sectors if over 32 MB
 iMedia:        .byte  0             # media Descriptor
 iFatSize:      .word  0             # size of each FAT
 iTrackSect:    .word  0             # sectors per track
 iHeadCnt:      .word  0             # number of read-write heads
 iHiddenSect:   .int   0             # number of hidden sectors
 iSect32:       .int   0             # # sectors for over 32 MB
 iBootDrive:    .byte  0             # holds drive that the boot sector came from
 iReserved:     .byte  0             # reserved, empty
 iBootSign:     .byte  0             # extended boot sector signature
 iVolID:        .ascii "    "        # disk serial
 acVolumeLabel: .ascii "           " # volume label
 acFSType:      .ascii "        "    # file system type
