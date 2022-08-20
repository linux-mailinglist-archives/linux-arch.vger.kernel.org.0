Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46A059AAF5
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 05:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiHTDhj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 23:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240454AbiHTDhf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 23:37:35 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5177677A;
        Fri, 19 Aug 2022 20:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=10j/9OeU8m3HSPUgBlu/yrtq6aWcRpBTJxa6CmehtY8=; b=CSxdMfzDqJQJuOSzQum6ThvfF7
        iMVIbogDlC1xjwpbj/w8LyFs+MwihG24sSLTx5Q4oTXMlTP/kn/wcyK80AnsIpgdRNeSYlhour8kI
        //vIENiX09WcNGuFufcQX4NYfMDjRD0Vz1hHvcAKrhKhMm0l9nnH+SyU3K3fKPwmP9btgtWLOze//
        u0rVFd5/aK/pRvJgxQGMjF45PU+MPRMj75PZLiEuBPhJvdPn2NbWlZImt/O8jykIshPwFz5Mfp6o+
        S7uwt7ff8VOTaNXn30Da+H2OZaNHTzCrz64+uY4c5bjru89tOX1QkBYLwhiNTwZsTR+mW0h4hUJy7
        igwvWmlg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPFIi-006Ho6-0A;
        Sat, 20 Aug 2022 03:37:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7/7] termios: get rid of non-UAPI asm/termios.h
Date:   Sat, 20 Aug 2022 04:37:30 +0100
Message-Id: <20220820033730.1498392-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820033730.1498392-1-viro@zeniv.linux.org.uk>
References: <YwBWJYU9BjnGBy2c@ZenIV>
 <20220820033730.1498392-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

	There are exactly two places where we include <asm/termios.h> -
include/uapi/linux/termios.h and include/linux/termios-internal.h.
The latter cares about the conversion functions; the former does
not.

	So take those into asm/termios-internal.h and have
linux/termios-internal.h include that in addition to asm/termios.h
(conditional upon the config symbol selected by the both architectures
where such non-default functions exist - alpha and sparc, that is).

	That would leave non-UAPI asm/termios.h consisting of include
of its UAPI counterpart and possibly an include of linux/uaccess.h.

	The latter can't be simply removed, even though nothing in
linux/termios.h doesn't depend upon it anymore - there are several
places that rely upon that indirect chain of includes to pull
linux/uaccess.h.  So the include needs to be lifted out of there -
we lift into tty_driver.h, serdev.h and places that pull asm/termios.h,
but none of
	* linux/uaccess.h (obvious)
	* net/sock.h (pulls uaccess.h)
	* linux/{tty,tty_driver,serdev}.h (tty.h pulls tty_driver.h)

That leaves us just with the include of UAPI asm/termios.h, which is
what <asm/termios.h> will resolve to if we simply remove non-UAPI header.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/Kconfig                                      |  3 +++
 arch/alpha/Kconfig                                |  1 +
 .../include/asm/{termios.h => termios-internal.h} |  3 ---
 arch/arm/mach-ep93xx/core.c                       |  1 +
 arch/arm/mach-versatile/integrator_ap.c           |  1 +
 arch/ia64/include/asm/termios.h                   | 13 -------------
 arch/mips/include/asm/termios.h                   | 15 ---------------
 arch/parisc/include/asm/termios.h                 |  7 -------
 arch/powerpc/include/asm/termios.h                | 13 -------------
 arch/s390/include/asm/termios.h                   | 12 ------------
 arch/sparc/Kconfig                                |  1 +
 .../include/asm/{termios.h => termios-internal.h} |  4 ----
 drivers/net/wwan/wwan_core.c                      |  1 +
 include/asm-generic/termios.h                     |  9 ---------
 include/linux/serdev.h                            |  1 +
 include/linux/termios_internal.h                  |  3 +++
 include/linux/tty_driver.h                        |  1 +
 17 files changed, 13 insertions(+), 76 deletions(-)
 rename arch/alpha/include/asm/{termios.h => termios-internal.h} (97%)
 delete mode 100644 arch/ia64/include/asm/termios.h
 delete mode 100644 arch/mips/include/asm/termios.h
 delete mode 100644 arch/parisc/include/asm/termios.h
 delete mode 100644 arch/powerpc/include/asm/termios.h
 delete mode 100644 arch/s390/include/asm/termios.h
 rename arch/sparc/include/asm/{termios.h => termios-internal.h} (98%)
 delete mode 100644 include/asm-generic/termios.h

diff --git a/arch/Kconfig b/arch/Kconfig
index f330410da63a..c9e1387d1194 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1416,6 +1416,9 @@ config DYNAMIC_SIGFRAME
 config HAVE_ARCH_NODE_DEV_GROUP
 	bool
 
+config ARCH_HAS_TERMIOS_INTERNAL
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 97fce7386b00..4b9d2941760e 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -35,6 +35,7 @@ config ALPHA
 	select MMU_GATHER_NO_RANGE
 	select SPARSEMEM_EXTREME if SPARSEMEM
 	select ZONE_DMA
+	select ARCH_HAS_TERMIOS_INTERNAL
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios-internal.h
similarity index 97%
rename from arch/alpha/include/asm/termios.h
rename to arch/alpha/include/asm/termios-internal.h
index c676067a1da7..c73cc96f96a3 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios-internal.h
@@ -2,9 +2,6 @@
 #ifndef _ALPHA_TERMIOS_H
 #define _ALPHA_TERMIOS_H
 
-#include <linux/uaccess.h>
-#include <uapi/asm/termios.h>
-
 /*
  * Translate a "termio" structure into a "termios". Ugh.
  */
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 2d58e273c96d..95e731676cea 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
+#include <linux/uaccess.h>
 #include <linux/termios.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/serial.h>
diff --git a/arch/arm/mach-versatile/integrator_ap.c b/arch/arm/mach-versatile/integrator_ap.c
index e216fac917d0..4bd6712e9f52 100644
--- a/arch/arm/mach-versatile/integrator_ap.c
+++ b/arch/arm/mach-versatile/integrator_ap.c
@@ -11,6 +11,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/uaccess.h>
 #include <linux/termios.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
diff --git a/arch/ia64/include/asm/termios.h b/arch/ia64/include/asm/termios.h
deleted file mode 100644
index 1cef02701401..000000000000
--- a/arch/ia64/include/asm/termios.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Modified 1999
- *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
- *
- * 99/01/28	Added N_IRDA and N_SMSBLOCK
- */
-#ifndef _ASM_IA64_TERMIOS_H
-#define _ASM_IA64_TERMIOS_H
-
-#include <uapi/asm/termios.h>
-
-#endif /* _ASM_IA64_TERMIOS_H */
diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
deleted file mode 100644
index 12bc56857bf1..000000000000
--- a/arch/mips/include/asm/termios.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1995, 1996, 2000, 2001 by Ralf Baechle
- * Copyright (C) 2000, 2001 Silicon Graphics, Inc.
- */
-#ifndef _ASM_TERMIOS_H
-#define _ASM_TERMIOS_H
-
-#include <linux/uaccess.h>
-#include <uapi/asm/termios.h>
-
-#endif /* _ASM_TERMIOS_H */
diff --git a/arch/parisc/include/asm/termios.h b/arch/parisc/include/asm/termios.h
deleted file mode 100644
index 1850a90befb3..000000000000
--- a/arch/parisc/include/asm/termios.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _PARISC_TERMIOS_H
-#define _PARISC_TERMIOS_H
-
-#include <uapi/asm/termios.h>
-
-#endif	/* _PARISC_TERMIOS_H */
diff --git a/arch/powerpc/include/asm/termios.h b/arch/powerpc/include/asm/termios.h
deleted file mode 100644
index 83794533f607..000000000000
--- a/arch/powerpc/include/asm/termios.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Liberally adapted from alpha/termios.h.  In particular, the c_cc[]
- * fields have been reordered so that termio & termios share the
- * common subset in the same order (for brain dead programs that don't
- * know or care about the differences).
- */
-#ifndef _ASM_POWERPC_TERMIOS_H
-#define _ASM_POWERPC_TERMIOS_H
-
-#include <uapi/asm/termios.h>
-
-#endif	/* _ASM_POWERPC_TERMIOS_H */
diff --git a/arch/s390/include/asm/termios.h b/arch/s390/include/asm/termios.h
deleted file mode 100644
index 0e26fe97b0d4..000000000000
--- a/arch/s390/include/asm/termios.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  S390 version
- *
- *  Derived from "include/asm-i386/termios.h"
- */
-#ifndef _S390_TERMIOS_H
-#define _S390_TERMIOS_H
-
-#include <uapi/asm/termios.h>
-
-#endif	/* _S390_TERMIOS_H */
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 1c852bb530ec..9aaf980b5bff 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -47,6 +47,7 @@ config SPARC
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 	select TRACE_IRQFLAGS_SUPPORT
+	select ARCH_HAS_TERMIOS_INTERNAL
 
 config SPARC32
 	def_bool !64BIT
diff --git a/arch/sparc/include/asm/termios.h b/arch/sparc/include/asm/termios-internal.h
similarity index 98%
rename from arch/sparc/include/asm/termios.h
rename to arch/sparc/include/asm/termios-internal.h
index ba4b7517a3bb..9d14a4bc40cf 100644
--- a/arch/sparc/include/asm/termios.h
+++ b/arch/sparc/include/asm/termios-internal.h
@@ -2,10 +2,6 @@
 #ifndef _SPARC_TERMIOS_H
 #define _SPARC_TERMIOS_H
 
-#include <uapi/asm/termios.h>
-#include <linux/uaccess.h>
-
-
 /*
  * c_cc characters in the termio structure.  Oh, how I love being
  * backwardly compatible.  Notice that character 4 and 5 are
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index b8c7843730ed..62e9f7d6c9fe 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -13,6 +13,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/uaccess.h>
 #include <linux/termios.h>
 #include <linux/wwan.h>
 #include <net/rtnetlink.h>
diff --git a/include/asm-generic/termios.h b/include/asm-generic/termios.h
deleted file mode 100644
index da3b0fe25442..000000000000
--- a/include/asm-generic/termios.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_GENERIC_TERMIOS_H
-#define _ASM_GENERIC_TERMIOS_H
-
-
-#include <linux/uaccess.h>
-#include <uapi/asm-generic/termios.h>
-
-#endif /* _ASM_GENERIC_TERMIOS_H */
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 3368c261ab62..66f624fc618c 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -7,6 +7,7 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/uaccess.h>
 #include <linux/termios.h>
 #include <linux/delay.h>
 
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
index 7c92d64a7989..60e9a8efc5b8 100644
--- a/include/linux/termios_internal.h
+++ b/include/linux/termios_internal.h
@@ -4,6 +4,9 @@
 
 #include <linux/uaccess.h>
 #include <asm/termios.h>
+#ifdef CONFIG_ARCH_HAS_TERMIOS_INTERNAL
+#include <asm/termios-internal.h>
+#endif
 
 /*	intr=^C		quit=^\		erase=del	kill=^U
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 4841d8069c07..fbbec811859f 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -7,6 +7,7 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/cdev.h>
+#include <linux/uaccess.h>
 #include <linux/termios.h>
 #include <linux/seq_file.h>
 
-- 
2.30.2

