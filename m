Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496063C8A03
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 19:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhGNRsD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jul 2021 13:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhGNRsD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jul 2021 13:48:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402D0C06175F;
        Wed, 14 Jul 2021 10:45:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h8so4283532eds.4;
        Wed, 14 Jul 2021 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7kKquISYHicDtSbcUKgpEyWu8aMQWPZhSquVGhDWzRs=;
        b=dVGZCXZ8/2qImy60b4rlEtItaMIu6e6stG9JqBr74jaMmv2xMlOMpLFVj4uoAzZe+c
         4zHLfSol608CKrQ1EPT6SFrR48i9exr/hBdTr7I038nekt1l844zCTf7yAunaX2lSSpI
         YdUTyYe709Ufo6AC5STvUiu6+RFnF8gflig96xmvL7DEjdyBMFN9eCXn2FpJHudXB6Yq
         DMt0isKaOJJgo0uQNoCpNN3oedXGoXnX8SztCDR0jv2L//fUO0OrjgGqjOmmUPoC79BJ
         wrAE6FN7Hzy+tVJWaAzQH4w1dsSMFB9vpL3LWZjRCs9L3CXO/zi9rfkBJyLM+s0Yu4QY
         fxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7kKquISYHicDtSbcUKgpEyWu8aMQWPZhSquVGhDWzRs=;
        b=KQ4e8JPaXwkJype3OwnGeYSWQZPXsDbP80X+98IFyYm830i7RHdtGrAJtYyIqPE7LJ
         Vv45GsiR0Ti66XsygtpD4w2kfOVv7fIhYEddlHzv5aFE7SGDVC53mnRDnL5mBS0lUcix
         J4XdmQlQ9Wa7FwLPyCFPLg4c8IinnxJvL2Qsi/ffMxgSzbapfDJ97l5B6VfD5jLvoZaA
         Cawfai4/Pk1zvHiwTBDvx8mJiYR1kQ8MPrn8HheOGBx51K9wy7NQeAOiV4la+RFBt8Ts
         XVseFScJBf2iNO9qAd5uZdGLho822Z4tO3zRMAQPKcosQS9GGrpSEhQVm6yj5akPVaM6
         NIhA==
X-Gm-Message-State: AOAM532XD3SCYyEJ+Og3VTQ5a5np9lZsEAoUWQEVN1lBSQ+dJzXekx92
        GkRrIFGWk2MBTihojUt9Kg==
X-Google-Smtp-Source: ABdhPJxVAyHi0rSKfFEz/ag4yXB3ARUbyBzUizwt292Q/e4kla6SNDMmr6rBMG1G6hfNlkXvM3+TyA==
X-Received: by 2002:aa7:da06:: with SMTP id r6mr15502650eds.38.1626284709702;
        Wed, 14 Jul 2021 10:45:09 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.115])
        by smtp.gmail.com with ESMTPSA id m8sm1321240eds.10.2021.07.14.10.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:45:09 -0700 (PDT)
Date:   Wed, 14 Jul 2021 20:45:07 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, masahiroy@kernel.org,
        hch@infradead.org
Subject: [PATCH v2] Decouple build from userspace headers
Message-ID: <YO8ioz4sHwcUAkdt@localhost.localdomain>
References: <YO3txvw87MjKfdpq@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO3txvw87MjKfdpq@localhost.localdomain>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

First, userspace headers can be under incompatible license.

Second, kernel doesn't require userspace to operate and should not
require anything from userspace to be built other than compiler.
We would use -ffreestanding too if not builtin function shenanigans.

To decouple:

* ship minimal stdarg.h as <linux/stdarg.h>,
	1 type, 4 macros

GPL 2 version of <stdarg.h> can be extracted from
http://archive.debian.org/debian/pool/main/g/gcc-4.2/gcc-4.2_4.2.4.orig.tar.gz

* delete "-isystem" from command line arguments,
	this is what enables header leakage

* fixup/delete include directives where necessary.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Makefile                                                                 |    2 -
 arch/arm/kernel/process.c                                                |    2 -
 arch/arm/mach-bcm/bcm_kona_smc.c                                         |    2 -
 arch/arm64/kernel/process.c                                              |    3 --
 arch/openrisc/kernel/process.c                                           |    2 -
 arch/parisc/kernel/firmware.c                                            |    2 -
 arch/parisc/kernel/process.c                                             |    3 --
 arch/powerpc/kernel/prom.c                                               |    1 
 arch/powerpc/kernel/prom_init.c                                          |    2 -
 arch/powerpc/kernel/rtas.c                                               |    2 -
 arch/powerpc/kernel/udbg.c                                               |    2 -
 arch/s390/boot/pgm_check_info.c                                          |    2 -
 arch/sparc/kernel/process_32.c                                           |    3 --
 arch/sparc/kernel/process_64.c                                           |    3 --
 arch/um/include/shared/irq_user.h                                        |    1 
 arch/um/include/shared/os.h                                              |    1 
 arch/um/os-Linux/signal.c                                                |    2 -
 arch/um/os-Linux/util.c                                                  |    1 
 arch/x86/boot/boot.h                                                     |    2 -
 crypto/aegis128-neon-inner.c                                             |    2 -
 drivers/block/xen-blkback/xenbus.c                                       |    1 
 drivers/firmware/efi/libstub/efi-stub-helper.c                           |    2 -
 drivers/firmware/efi/libstub/vsprintf.c                                  |    2 -
 drivers/gpu/drm/amd/display/dc/dc_helper.c                               |    2 -
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h                          |    1 
 drivers/gpu/drm/drm_print.c                                              |    2 -
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.h                             |    1 
 drivers/isdn/capi/capiutil.c                                             |    2 -
 drivers/macintosh/macio-adb.c                                            |    1 
 drivers/macintosh/via-cuda.c                                             |    2 -
 drivers/macintosh/via-macii.c                                            |    2 -
 drivers/macintosh/via-pmu.c                                              |    2 -
 drivers/net/wireless/intersil/orinoco/hermes.c                           |    1 
 drivers/net/wwan/iosm/iosm_ipc_imem.h                                    |    1 
 drivers/pinctrl/aspeed/pinmux-aspeed.h                                   |    1 
 drivers/scsi/elx/efct/efct_driver.h                                      |    1 
 drivers/staging/media/atomisp/pci/hive_isp_css_common/host/isp_local.h   |    2 -
 drivers/staging/media/atomisp/pci/hive_isp_css_include/print_support.h   |    2 -
 drivers/staging/media/atomisp/pci/ia_css_env.h                           |    2 -
 drivers/staging/media/atomisp/pci/runtime/debug/interface/ia_css_debug.h |    2 -
 drivers/staging/media/atomisp/pci/sh_css_internal.h                      |    2 -
 drivers/xen/xen-scsiback.c                                               |    2 -
 fs/befs/debug.c                                                          |    2 -
 fs/reiserfs/prints.c                                                     |    2 -
 fs/ufs/super.c                                                           |    2 -
 include/acpi/platform/acgcc.h                                            |    2 -
 include/linux/filter.h                                                   |    2 -
 include/linux/kernel.h                                                   |    2 -
 include/linux/mISDNif.h                                                  |    1 
 include/linux/printk.h                                                   |    2 -
 include/linux/stdarg.h                                                   |   11 ++++++++++
 include/linux/string.h                                                   |    2 -
 kernel/debug/kdb/kdb_support.c                                           |    1 
 lib/debug_info.c                                                         |    3 --
 lib/kasprintf.c                                                          |    2 -
 lib/kunit/string-stream.h                                                |    2 -
 lib/vsprintf.c                                                           |    2 -
 mm/kfence/report.c                                                       |    2 -
 net/batman-adv/log.c                                                     |    2 -
 sound/aoa/codecs/onyx.h                                                  |    1 
 sound/aoa/codecs/tas.c                                                   |    1 
 sound/core/info.c                                                        |    1 
 62 files changed, 44 insertions(+), 77 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -978,7 +978,7 @@ KBUILD_CFLAGS += -falign-functions=64
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
-NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
+NOSTDINC_FLAGS += -nostdinc
 
 # warn about C99 declaration after statement
 KBUILD_CFLAGS += -Wdeclaration-after-statement
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
--- a/arch/parisc/kernel/firmware.c
+++ b/arch/parisc/kernel/firmware.c
@@ -51,7 +51,7 @@
  *					prumpf	991016	
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include <linux/delay.h>
 #include <linux/init.h>
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
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -11,7 +11,6 @@
 
 #undef DEBUG
 
-#include <stdarg.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -14,7 +14,7 @@
 /* we cannot use FORTIFY as it brings in new symbols */
 #define __NO_FORTIFY
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2001 IBM.
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/spinlock.h>
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -5,7 +5,7 @@
  * c 2001 PPC 64 Team, IBM Corp
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/console.h>
--- a/arch/s390/boot/pgm_check_info.c
+++ b/arch/s390/boot/pgm_check_info.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
+#include <linux/stdarg.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <asm/stacktrace.h>
@@ -8,7 +9,6 @@
 #include <asm/setup.h>
 #include <asm/sclp.h>
 #include <asm/uv.h>
-#include <stdarg.h>
 #include "boot.h"
 
 const char hex_asc[] = "0123456789abcdef";
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
--- a/arch/um/include/shared/irq_user.h
+++ b/arch/um/include/shared/irq_user.h
@@ -7,7 +7,6 @@
 #define __IRQ_USER_H__
 
 #include <sysdep/ptrace.h>
-#include <stdbool.h>
 
 enum um_irq_type {
 	IRQ_READ,
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -8,7 +8,6 @@
 #ifndef __OS_H__
 #define __OS_H__
 
-#include <stdarg.h>
 #include <irq_user.h>
 #include <longjmp.h>
 #include <mm_id.h>
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
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -18,7 +18,7 @@
 
 #ifndef __ASSEMBLY__
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 #include <linux/edd.h>
 #include <asm/setup.h>
--- a/crypto/aegis128-neon-inner.c
+++ b/crypto/aegis128-neon-inner.c
@@ -15,8 +15,6 @@
 
 #define AEGIS_BLOCK_SIZE	16
 
-#include <stddef.h>
-
 extern int aegis128_have_aes_insn;
 
 void *memcpy(void *dest, const void *src, size_t n);
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -8,7 +8,6 @@
 
 #define pr_fmt(fmt) "xen-blkback: " fmt
 
-#include <stdarg.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <xen/events.h>
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -7,7 +7,7 @@
  * Copyright 2011 Intel Corporation; author Matt Fleming
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include <linux/ctype.h>
 #include <linux/efi.h>
--- a/drivers/firmware/efi/libstub/vsprintf.c
+++ b/drivers/firmware/efi/libstub/vsprintf.c
@@ -10,7 +10,7 @@
  * Oh, it's a waste of space, but oh-so-yummy for debugging.
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include <linux/compiler.h>
 #include <linux/ctype.h>
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -28,9 +28,9 @@
  */
 
 #include <linux/delay.h>
+#include <linux/stdarg.h>
 
 #include "dm_services.h"
-#include <stdarg.h>
 
 #include "dc.h"
 #include "dc_dmub_srv.h"
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -39,7 +39,6 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/delay.h>
-#include <stdarg.h>
 
 #include "atomfirmware.h"
 
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -25,7 +25,7 @@
 
 #define DEBUG /* for pr_debug() */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include <linux/io.h>
 #include <linux/moduleparam.h>
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
@@ -25,7 +25,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/kthread.h>
 #include <linux/devcoredump.h>
-#include <stdarg.h>
 #include "msm_kms.h"
 
 #define MSM_DISP_SNAPSHOT_MAX_BLKS		10
--- a/drivers/isdn/capi/capiutil.c
+++ b/drivers/isdn/capi/capiutil.c
@@ -379,7 +379,7 @@ static char *pnames[] =
 	/*2f */ "Useruserdata"
 };
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 /*-------------------------------------------------------*/
 static _cdebbuf *bufprint(_cdebbuf *cdb, char *fmt, ...)
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
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -9,7 +9,7 @@
  *
  * Copyright (C) 1996 Paul Mackerras.
  */
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
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
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -18,7 +18,7 @@
  *    a sleep or a freq. switch
  *
  */
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/errno.h>
--- a/drivers/net/wireless/intersil/orinoco/hermes.c
+++ b/drivers/net/wireless/intersil/orinoco/hermes.c
@@ -79,7 +79,6 @@
 
 #undef HERMES_DEBUG
 #ifdef HERMES_DEBUG
-#include <stdarg.h>
 
 #define DEBUG(lvl, stuff...) if ((lvl) <= HERMES_DEBUG) DMSG(stuff)
 
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.h
@@ -7,7 +7,6 @@
 #define IOSM_IPC_IMEM_H
 
 #include <linux/skbuff.h>
-#include <stdbool.h>
 
 #include "iosm_ipc_mmio.h"
 #include "iosm_ipc_pcie.h"
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
@@ -5,7 +5,6 @@
 #define ASPEED_PINMUX_H
 
 #include <linux/regmap.h>
-#include <stdbool.h>
 
 /*
  * The ASPEED SoCs provide typically more than 200 pins for GPIO and other
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
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/isp_local.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/isp_local.h
@@ -16,8 +16,6 @@
 #ifndef __ISP_LOCAL_H_INCLUDED__
 #define __ISP_LOCAL_H_INCLUDED__
 
-#include <stdbool.h>
-
 #include "isp_global.h"
 
 #include <isp2400_support.h>
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/print_support.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/print_support.h
@@ -16,7 +16,7 @@
 #ifndef __PRINT_SUPPORT_H_INCLUDED__
 #define __PRINT_SUPPORT_H_INCLUDED__
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 extern int (*sh_css_printf)(const char *fmt, va_list args);
 /* depends on host supplied print function in ia_css_init() */
--- a/drivers/staging/media/atomisp/pci/ia_css_env.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_env.h
@@ -17,7 +17,7 @@
 #define __IA_CSS_ENV_H
 
 #include <type_support.h>
-#include <stdarg.h> /* va_list */
+#include <linux/stdarg.h> /* va_list */
 #include "ia_css_types.h"
 #include "ia_css_acc_types.h"
 
--- a/drivers/staging/media/atomisp/pci/runtime/debug/interface/ia_css_debug.h
+++ b/drivers/staging/media/atomisp/pci/runtime/debug/interface/ia_css_debug.h
@@ -19,7 +19,7 @@
 /*! \file */
 
 #include <type_support.h>
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include "ia_css_types.h"
 #include "ia_css_binary.h"
 #include "ia_css_frame_public.h"
--- a/drivers/staging/media/atomisp/pci/sh_css_internal.h
+++ b/drivers/staging/media/atomisp/pci/sh_css_internal.h
@@ -20,7 +20,7 @@
 #include <math_support.h>
 #include <type_support.h>
 #include <platform_support.h>
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #if !defined(ISP2401)
 #include "input_formatter.h"
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -33,8 +33,6 @@
 
 #define pr_fmt(fmt) "xen-pvscsi: " fmt
 
-#include <stdarg.h>
-
 #include <linux/module.h>
 #include <linux/utsname.h>
 #include <linux/interrupt.h>
--- a/fs/befs/debug.c
+++ b/fs/befs/debug.c
@@ -14,7 +14,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #ifdef __KERNEL__
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
--- a/fs/reiserfs/prints.c
+++ b/fs/reiserfs/prints.c
@@ -8,7 +8,7 @@
 #include <linux/string.h>
 #include <linux/buffer_head.h>
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 static char error_buf[1024];
 static char fmt_buf[1024];
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -70,7 +70,7 @@
 #include <linux/module.h>
 #include <linux/bitops.h>
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include <linux/uaccess.h>
 
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -22,7 +22,7 @@ typedef __builtin_va_list va_list;
 #define va_arg(v, l)            __builtin_va_arg(v, l)
 #define va_copy(d, s)           __builtin_va_copy(d, s)
 #else
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #endif
 #endif
 
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
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_KERNEL_H
 #define _LINUX_KERNEL_H
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/align.h>
 #include <linux/limits.h>
 #include <linux/linkage.h>
--- a/include/linux/mISDNif.h
+++ b/include/linux/mISDNif.h
@@ -18,7 +18,6 @@
 #ifndef mISDNIF_H
 #define mISDNIF_H
 
-#include <stdarg.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/socket.h>
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -2,7 +2,7 @@
 #ifndef __KERNEL_PRINTK__
 #define __KERNEL_PRINTK__
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/init.h>
 #include <linux/kern_levels.h>
 #include <linux/linkage.h>
new file mode 100644
--- /dev/null
+++ b/include/linux/stdarg.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#ifndef _LINUX_STDARG_H
+#define _LINUX_STDARG_H
+
+typedef __builtin_va_list va_list;
+#define va_start(v, l)	__builtin_va_start(v, l)
+#define va_end(v)	__builtin_va_end(v)
+#define va_arg(v, T)	__builtin_va_arg(v, T)
+#define va_copy(d, s)	__builtin_va_copy(d, s)
+
+#endif
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -6,7 +6,7 @@
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
 #include <linux/errno.h>	/* for E2BIG */
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
 extern char *strndup_user(const char __user *, long);
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -10,7 +10,6 @@
  * 03/02/13    added new 2.5 kallsyms <xavier.bru@bull.net>
  */
 
-#include <stdarg.h>
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
--- a/lib/debug_info.c
+++ b/lib/debug_info.c
@@ -5,8 +5,6 @@
  * CONFIG_DEBUG_INFO_REDUCED. Please do not add actual code. However,
  * adding appropriate #includes is fine.
  */
-#include <stdarg.h>
-
 #include <linux/cred.h>
 #include <linux/crypto.h>
 #include <linux/dcache.h>
@@ -22,6 +20,7 @@
 #include <linux/net.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 #include <net/addrconf.h>
 #include <net/sock.h>
--- a/lib/kasprintf.c
+++ b/lib/kasprintf.c
@@ -5,7 +5,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/types.h>
--- a/lib/kunit/string-stream.h
+++ b/lib/kunit/string-stream.h
@@ -11,7 +11,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/types.h>
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 struct string_stream_fragment {
 	struct kunit *test;
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -17,7 +17,7 @@
  * - scnprintf and vscnprintf
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 #include <linux/build_bug.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2020, Google LLC.
  */
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include <linux/kernel.h>
 #include <linux/lockdep.h>
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -7,7 +7,7 @@
 #include "log.h"
 #include "main.h"
 
-#include <stdarg.h>
+#include <linux/stdarg.h>
 
 #include "trace.h"
 
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
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -16,7 +16,6 @@
 #include <linux/utsname.h>
 #include <linux/proc_fs.h>
 #include <linux/mutex.h>
-#include <stdarg.h>
 
 int snd_info_check_reserved_words(const char *str)
 {
