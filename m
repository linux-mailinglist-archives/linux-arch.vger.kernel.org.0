Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717795A9DC2
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiIARJB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 13:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiIARJA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 13:09:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EADA9A6A4;
        Thu,  1 Sep 2022 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uDGIDOXwRXWczvdK15IGrMK74IbHZ9GblB4IcPzsBtQ=; b=mmqIHZoOZvkorPCP0491LA0nDR
        3MdseR8L7m/uCE3asK/vvNxhX/7uuPJD/MS7aLYHYW3ooTQ+osoefxJnx/pGQsNP6tGuM4J729N+A
        9Sdm2269T6EKSbfnUtNNFPRrtuYkeU84QauaxZeVASDSjRQHSXisuoczw9idTYzjRuhHTfLTHAWgT
        GxJoXpSdRdfzHU9MtNyW51KTz81jYg0mRgR0Z5jd+xS3laZjoyDoxK9MOoNeM0fmK0rmwHISCkRn6
        xEU34PGkjHnA8ajRPGJnejkXFg/dpVtHFAdRLNtMAbW5erHe6ScMtaxjCupP5yIpfbALjLeZnFSO5
        YCvJOPfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTngY-00B2p0-4S;
        Thu, 01 Sep 2022 17:08:58 +0000
Date:   Thu, 1 Sep 2022 18:08:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] termios: get rid of non-UAPI asm/termios.h
Message-ID: <YxDnKvYCHn/ogBUv@ZenIV>
References: <YwF8vibZ2/Xz7a/g@ZenIV>
 <20220821010239.1554132-1-viro@zeniv.linux.org.uk>
 <20220821010239.1554132-3-viro@zeniv.linux.org.uk>
 <Yw4B6IU9WWKhN+1H@kroah.com>
 <YxDlyBneTC/zBx4S@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxDlyBneTC/zBx4S@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From 4290f5a9c37a3c7eeafcab26ef9a56a026c2f782 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 9 Aug 2022 19:41:40 -0400
Subject: [PATCH v3 6/6] termios: get rid of non-UAPI asm/termios.h

	All non-UAPI asm/termios.h consist of include of UAPI counterpart
and, possibly, include of linux/uaccess.h

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
 arch/alpha/include/asm/termios.h        |  8 --------
 arch/arm/mach-ep93xx/core.c             |  1 +
 arch/arm/mach-versatile/integrator_ap.c |  1 +
 arch/ia64/include/asm/termios.h         | 13 -------------
 arch/mips/include/asm/termios.h         | 15 ---------------
 arch/parisc/include/asm/termios.h       |  7 -------
 arch/powerpc/include/asm/termios.h      | 13 -------------
 arch/s390/include/asm/termios.h         | 12 ------------
 arch/sparc/include/asm/termios.h        |  8 --------
 drivers/net/wwan/wwan_core.c            |  1 +
 include/asm-generic/termios.h           |  9 ---------
 include/linux/serdev.h                  |  1 +
 include/linux/tty_driver.h              |  1 +
 13 files changed, 5 insertions(+), 85 deletions(-)
 delete mode 100644 arch/alpha/include/asm/termios.h
 delete mode 100644 arch/ia64/include/asm/termios.h
 delete mode 100644 arch/mips/include/asm/termios.h
 delete mode 100644 arch/parisc/include/asm/termios.h
 delete mode 100644 arch/powerpc/include/asm/termios.h
 delete mode 100644 arch/s390/include/asm/termios.h
 delete mode 100644 arch/sparc/include/asm/termios.h
 delete mode 100644 include/asm-generic/termios.h

diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios.h
deleted file mode 100644
index 3894fd92c508..000000000000
--- a/arch/alpha/include/asm/termios.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ALPHA_TERMIOS_H
-#define _ALPHA_TERMIOS_H
-
-#include <linux/uaccess.h>
-#include <uapi/asm/termios.h>
-
-#endif	/* _ALPHA_TERMIOS_H */
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
diff --git a/arch/sparc/include/asm/termios.h b/arch/sparc/include/asm/termios.h
deleted file mode 100644
index 1b85721f4e6b..000000000000
--- a/arch/sparc/include/asm/termios.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _SPARC_TERMIOS_H
-#define _SPARC_TERMIOS_H
-
-#include <uapi/asm/termios.h>
-#include <linux/uaccess.h>
-
-#endif /* _SPARC_TERMIOS_H */
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
 
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index b2456b545ba0..f961164a5274 100644
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

