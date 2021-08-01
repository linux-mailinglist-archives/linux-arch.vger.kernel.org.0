Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EBB3DCD98
	for <lists+linux-arch@lfdr.de>; Sun,  1 Aug 2021 22:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhHAUN6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 Aug 2021 16:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhHAUN6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 Aug 2021 16:13:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE6C06175F;
        Sun,  1 Aug 2021 13:13:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z4so18950547wrv.11;
        Sun, 01 Aug 2021 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPNrVI+piyp1+F5TyG0u9gD/+ztVAtgjAz0YpEIS5fA=;
        b=T64iPY3qfzq2QXZURYmB1toTDSSQ7b5rGRqClSrPyYLEdX0FyGspkBkbZ0kf/np3/8
         FdzWjU0li32295Lx8W13/kV6hUepXMsBv5JfSNWj0X5NJ8GssRd5UNG5k3BTE4NHDW+A
         52HDIqVABzbFbiSjXfbEI7coQOZJxch3c1kIM7umWWivVaRdr4/M6OOcPx8zVUP8SdlW
         MPPyrip92DxPCL1MUBOSJQOlkfcgDJZok6Pmguqau6mk2RfFs7uWN0xPPggnk5SNGCw7
         9voPzPpxEweUm8qTZdV7qiL1Y1m9IOV8ssNbGQ5144ikC9XlvU+1CQ9ZaitsVenRTB1h
         25NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPNrVI+piyp1+F5TyG0u9gD/+ztVAtgjAz0YpEIS5fA=;
        b=px7hWhQDP4udB93FSlsbCUqIc8Z0GfXbde5OHF9+81hFAWe3WSILRhUa0+v43lk85f
         Be8XnDHWAZXQcJdzUj3X/WeUfoq/g+dfp/Gh40igRsiyNMZvwUaiseFs9192dU9lg9lQ
         r6AiGfdUsLmj0qs/TTbOPM5l37wvlu9OwktqY1GIWDPsDfvXUx+KhfWd5oPfxuwrlvD0
         GtmectZkNVbSWHZdSMXgx5msQlXiwN/ljPvAAoM1/8fn3btMeEdZUo8g9uNgoA4fuOZT
         3mikQHXS0ewekCC7ikcpflwcwjZ+xz4P2T/PHukOhYJ4+kOU1Bszbu+ogvMofBhInH8b
         6kiw==
X-Gm-Message-State: AOAM530jHAD6GuAbMxvi3AuhaXLnE2s0GgpAGoi0QgA9+0vLm8J28Wak
        7Z/ub6Iy21jOIR6GLKPIBQ==
X-Google-Smtp-Source: ABdhPJxWo+FSPUOhxVFX4cfilVu4bW82DYcErm5cRxuLFWI383wj6v4Lt9o6b8CYQY3og5ONgvCAyw==
X-Received: by 2002:adf:e3d2:: with SMTP id k18mr13736851wrm.212.1627848828510;
        Sun, 01 Aug 2021 13:13:48 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.172])
        by smtp.gmail.com with ESMTPSA id k6sm8738686wrm.10.2021.08.01.13.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 13:13:48 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        masahiroy@kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: [PATCH 1/3] isystem: trim/fixup stdarg.h and other headers
Date:   Sun,  1 Aug 2021 23:13:34 +0300
Message-Id: <20210801201336.2224111-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Delete/fixup few includes in anticipation of global -isystem compile
option removal.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/arm/kernel/process.c                                      | 2 --
 arch/arm/mach-bcm/bcm_kona_smc.c                               | 2 --
 arch/arm64/kernel/process.c                                    | 3 ---
 arch/openrisc/kernel/process.c                                 | 2 --
 arch/parisc/kernel/process.c                                   | 3 ---
 arch/powerpc/kernel/prom.c                                     | 1 -
 arch/sparc/kernel/process_32.c                                 | 3 ---
 arch/sparc/kernel/process_64.c                                 | 3 ---
 arch/um/drivers/rtc_user.c                                     | 1 +
 arch/um/drivers/vector_user.c                                  | 1 +
 arch/um/include/shared/irq_user.h                              | 1 -
 arch/um/include/shared/os.h                                    | 1 -
 arch/um/os-Linux/signal.c                                      | 2 +-
 arch/um/os-Linux/util.c                                        | 1 +
 crypto/aegis128-neon-inner.c                                   | 2 +-
 drivers/block/xen-blkback/xenbus.c                             | 1 -
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h                | 1 -
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.h                   | 1 -
 drivers/macintosh/macio-adb.c                                  | 1 -
 drivers/macintosh/via-macii.c                                  | 2 --
 drivers/net/wireless/intersil/orinoco/hermes.c                 | 1 -
 drivers/net/wwan/iosm/iosm_ipc_imem.h                          | 1 -
 drivers/pinctrl/aspeed/pinmux-aspeed.h                         | 1 -
 drivers/scsi/elx/efct/efct_driver.h                            | 1 -
 .../media/atomisp/pci/hive_isp_css_common/host/isp_local.h     | 2 --
 drivers/xen/xen-scsiback.c                                     | 2 --
 include/linux/filter.h                                         | 2 --
 include/linux/mISDNif.h                                        | 1 -
 kernel/debug/kdb/kdb_support.c                                 | 1 -
 sound/aoa/codecs/onyx.h                                        | 1 -
 sound/aoa/codecs/tas.c                                         | 1 -
 sound/core/info.c                                              | 1 -
 32 files changed, 5 insertions(+), 44 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index fc9e8b37eaa8..bb5ad8a6a4c3 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -5,8 +5,6 @@
  *  Copyright (C) 1996-2000 Russell King - Converted to ARM.
  *  Original Copyright (C) 1995  Linus Torvalds
  */
-#include <stdarg.h>
-
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
index 43a16f922b53..43829e49ad93 100644
--- a/arch/arm/mach-bcm/bcm_kona_smc.c
+++ b/arch/arm/mach-bcm/bcm_kona_smc.c
@@ -10,8 +10,6 @@
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-
-#include <stdarg.h>
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c8989b999250..5f7ac9a0f9a3 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -6,9 +6,6 @@
  * Copyright (C) 1996-2000 Russell King - Converted to ARM.
  * Copyright (C) 2012 ARM Ltd.
  */
-
-#include <stdarg.h>
-
 #include <linux/compat.h>
 #include <linux/efi.h>
 #include <linux/elf.h>
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index eb62429681fc..b0698d9ce14f 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -14,8 +14,6 @@
  */
 
 #define __KERNEL_SYSCALLS__
-#include <stdarg.h>
-
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index 184ec3c1eae4..38ec4ae81239 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -17,9 +17,6 @@
  *    Copyright (C) 2001-2014 Helge Deller <deller@gmx.de>
  *    Copyright (C) 2002 Randolph Chung <tausq with parisc-linux.org>
  */
-
-#include <stdarg.h>
-
 #include <linux/elf.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f620e04dc9bf..a1e7ba0fad09 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -11,7 +11,6 @@
 
 #undef DEBUG
 
-#include <stdarg.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 93983d6d431d..bbbe0cfef746 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -8,9 +8,6 @@
 /*
  * This file handles the architecture-dependent parts of process handling..
  */
-
-#include <stdarg.h>
-
 #include <linux/elfcore.h>
 #include <linux/errno.h>
 #include <linux/module.h>
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index d33c58a58d4f..0cabcdfb23fd 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -9,9 +9,6 @@
 /*
  * This file handles the architecture-dependent parts of process handling..
  */
-
-#include <stdarg.h>
-
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/sched.h>
diff --git a/arch/um/drivers/rtc_user.c b/arch/um/drivers/rtc_user.c
index 4016bc1d577e..7c3cec4c68cf 100644
--- a/arch/um/drivers/rtc_user.c
+++ b/arch/um/drivers/rtc_user.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2020 Intel Corporation
  * Author: Johannes Berg <johannes@sipsolutions.net>
  */
+#include <stdbool.h>
 #include <os.h>
 #include <errno.h>
 #include <sched.h>
diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index bae53220ce26..e4ffeb9a1fa4 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <stdbool.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <stdarg.h>
diff --git a/arch/um/include/shared/irq_user.h b/arch/um/include/shared/irq_user.h
index 065829f443ae..86a8a573b65c 100644
--- a/arch/um/include/shared/irq_user.h
+++ b/arch/um/include/shared/irq_user.h
@@ -7,7 +7,6 @@
 #define __IRQ_USER_H__
 
 #include <sysdep/ptrace.h>
-#include <stdbool.h>
 
 enum um_irq_type {
 	IRQ_READ,
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 60b84edc8a68..96d400387c93 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -8,7 +8,6 @@
 #ifndef __OS_H__
 #define __OS_H__
 
-#include <stdarg.h>
 #include <irq_user.h>
 #include <longjmp.h>
 #include <mm_id.h>
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 6de99bb16113..6cf098c23a39 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -67,7 +67,7 @@ int signals_enabled;
 #ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
 static int signals_blocked;
 #else
-#define signals_blocked false
+#define signals_blocked 0
 #endif
 static unsigned int signals_pending;
 static unsigned int signals_active = 0;
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 07327425d06e..41297ec404bf 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/crypto/aegis128-neon-inner.c b/crypto/aegis128-neon-inner.c
index 7de485907d81..371caf295eb5 100644
--- a/crypto/aegis128-neon-inner.c
+++ b/crypto/aegis128-neon-inner.c
@@ -15,7 +15,7 @@
 
 #define AEGIS_BLOCK_SIZE	16
 
-#include <stddef.h>
+#include <linux/types.h>
 
 extern int aegis128_have_aes_insn;
 
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 125b22205d38..33eba3df4dd9 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -8,7 +8,6 @@
 
 #define pr_fmt(fmt) "xen-blkback: " fmt
 
-#include <stdarg.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <xen/events.h>
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7c4734f905d9..68fd451aca23 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -39,7 +39,6 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/delay.h>
-#include <stdarg.h>
 
 #include "atomfirmware.h"
 
diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
index c92a9508c8d3..0f9a5364cd86 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
@@ -25,7 +25,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/kthread.h>
 #include <linux/devcoredump.h>
-#include <stdarg.h>
 #include "msm_kms.h"
 
 #define MSM_DISP_SNAPSHOT_MAX_BLKS		10
diff --git a/drivers/macintosh/macio-adb.c b/drivers/macintosh/macio-adb.c
index d4759db002c6..dc634c2932fd 100644
--- a/drivers/macintosh/macio-adb.c
+++ b/drivers/macintosh/macio-adb.c
@@ -2,7 +2,6 @@
 /*
  * Driver for the ADB controller in the Mac I/O (Hydra) chip.
  */
-#include <stdarg.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index 060e03f2264b..db9270da5b8e 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -23,8 +23,6 @@
  * Apple's "ADB Analyzer" bus sniffer is invaluable:
  *   ftp://ftp.apple.com/developer/Tool_Chest/Devices_-_Hardware/Apple_Desktop_Bus/
  */
-
-#include <stdarg.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff --git a/drivers/net/wireless/intersil/orinoco/hermes.c b/drivers/net/wireless/intersil/orinoco/hermes.c
index 6d4b7f64efcf..256946552742 100644
--- a/drivers/net/wireless/intersil/orinoco/hermes.c
+++ b/drivers/net/wireless/intersil/orinoco/hermes.c
@@ -79,7 +79,6 @@
 
 #undef HERMES_DEBUG
 #ifdef HERMES_DEBUG
-#include <stdarg.h>
 
 #define DEBUG(lvl, stuff...) if ((lvl) <= HERMES_DEBUG) DMSG(stuff)
 
diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.h b/drivers/net/wwan/iosm/iosm_ipc_imem.h
index 0d2f10e4cbc8..dc65b0712261 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.h
@@ -7,7 +7,6 @@
 #define IOSM_IPC_IMEM_H
 
 #include <linux/skbuff.h>
-#include <stdbool.h>
 
 #include "iosm_ipc_mmio.h"
 #include "iosm_ipc_pcie.h"
diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.h b/drivers/pinctrl/aspeed/pinmux-aspeed.h
index b69ba6b360a2..4d7548686f39 100644
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
@@ -5,7 +5,6 @@
 #define ASPEED_PINMUX_H
 
 #include <linux/regmap.h>
-#include <stdbool.h>
 
 /*
  * The ASPEED SoCs provide typically more than 200 pins for GPIO and other
diff --git a/drivers/scsi/elx/efct/efct_driver.h b/drivers/scsi/elx/efct/efct_driver.h
index dab8eac4f243..0e3c931db7c2 100644
--- a/drivers/scsi/elx/efct/efct_driver.h
+++ b/drivers/scsi/elx/efct/efct_driver.h
@@ -10,7 +10,6 @@
 /***************************************************************************
  * OS specific includes
  */
-#include <stdarg.h>
 #include <linux/module.h>
 #include <linux/debugfs.h>
 #include <linux/firmware.h>
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/isp_local.h b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/isp_local.h
index eceeb5d160ad..4dbec4063b3d 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/isp_local.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/isp_local.h
@@ -16,8 +16,6 @@
 #ifndef __ISP_LOCAL_H_INCLUDED__
 #define __ISP_LOCAL_H_INCLUDED__
 
-#include <stdbool.h>
-
 #include "isp_global.h"
 
 #include <isp2400_support.h>
diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 61ce0d142eea..0c5e565aa8cf 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -33,8 +33,6 @@
 
 #define pr_fmt(fmt) "xen-pvscsi: " fmt
 
-#include <stdarg.h>
-
 #include <linux/module.h>
 #include <linux/utsname.h>
 #include <linux/interrupt.h>
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 472f97074da0..45785fc231a8 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -5,8 +5,6 @@
 #ifndef __LINUX_FILTER_H__
 #define __LINUX_FILTER_H__
 
-#include <stdarg.h>
-
 #include <linux/atomic.h>
 #include <linux/refcount.h>
 #include <linux/compat.h>
diff --git a/include/linux/mISDNif.h b/include/linux/mISDNif.h
index a7330eb3ec64..7dd1f01ec4f9 100644
--- a/include/linux/mISDNif.h
+++ b/include/linux/mISDNif.h
@@ -18,7 +18,6 @@
 #ifndef mISDNIF_H
 #define mISDNIF_H
 
-#include <stdarg.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/socket.h>
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 9f50d22d68e6..4f9950678e7b 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -10,7 +10,6 @@
  * 03/02/13    added new 2.5 kallsyms <xavier.bru@bull.net>
  */
 
-#include <stdarg.h>
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
diff --git a/sound/aoa/codecs/onyx.h b/sound/aoa/codecs/onyx.h
index 8a32c3c3d716..6c31b7373b78 100644
--- a/sound/aoa/codecs/onyx.h
+++ b/sound/aoa/codecs/onyx.h
@@ -6,7 +6,6 @@
  */
 #ifndef __SND_AOA_CODEC_ONYX_H
 #define __SND_AOA_CODEC_ONYX_H
-#include <stddef.h>
 #include <linux/i2c.h>
 #include <asm/pmac_low_i2c.h>
 #include <asm/prom.h>
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index ac246dd3ab49..ab19a37e2a68 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -58,7 +58,6 @@
  *    and up to the hardware designer to not wire
  *    them up in some weird unusable way.
  */
-#include <stddef.h>
 #include <linux/i2c.h>
 #include <asm/pmac_low_i2c.h>
 #include <asm/prom.h>
diff --git a/sound/core/info.c b/sound/core/info.c
index 9fec3070f8ba..a451b24199c3 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -16,7 +16,6 @@
 #include <linux/utsname.h>
 #include <linux/proc_fs.h>
 #include <linux/mutex.h>
-#include <stdarg.h>
 
 int snd_info_check_reserved_words(const char *str)
 {
-- 
2.31.1

