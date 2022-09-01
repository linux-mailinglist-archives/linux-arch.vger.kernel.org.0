Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B7E5A9DB6
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 19:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiIARGu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 13:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiIARGt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 13:06:49 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667FB7F243;
        Thu,  1 Sep 2022 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MGaaXi6hTnAmUwcWWAZxbdBSr37a5Mj7hWsypfKc2+I=; b=v5e7yyM2LZ/b7nI0DLq6BRsOCe
        YezUXCvjXsfq/BiJy1mhO44fZ/jHL24Afddx/JwBwk+c5HbGC7snB65dzVuHz7D6Onb3rRZ8WuEvG
        3nlBkR80r88h11QoVR3V+teX2bBpu7IBUteUahBQ1KforFvyff9zOZ2Urs74EnfEYLtM0eh6BnvPO
        rvvBlJVs+u+HalzvPns7/B0dS9+tziv78bUxi2nCKGkz2cfHxXcG8qSG4/dAMfxWI20x2x1QWwpJF
        BYGGDWkE0v7mT5cRaf5k9WlpMu4TdWCejVvJHT1YRfNiwK3WES4g5RS9xwK45x+xleKTmHKpY0JxY
        oFsXIVhg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTneQ-00B2n9-T2;
        Thu, 01 Sep 2022 17:06:47 +0000
Date:   Thu, 1 Sep 2022 18:06:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] termios: start unifying non-UAPI parts of
 asm/termios.h
Message-ID: <YxDmptU7dNGZ+/Hn@ZenIV>
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

From 73e0c06d136dff9b5f7be354b1c46c45fb581a9d Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Thu, 16 Aug 2018 11:47:53 -0400
Subject: [PATCH v3 2/6] termios: start unifying non-UAPI parts of
 asm/termios.h

* new header (linut/termios_internal.h), pulled by the users of those
suckers
* defaults for INIT_C_CC and externs for conversion helpers moved over
there
* remove termios-base.h (empty now)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/termios.h   |  8 +-------
 arch/alpha/kernel/termios.c        |  3 +--
 arch/ia64/include/asm/termios.h    | 16 ----------------
 arch/mips/include/asm/termios.h    |  9 ---------
 arch/parisc/include/asm/termios.h  | 16 ----------------
 arch/powerpc/include/asm/termios.h |  2 --
 arch/s390/include/asm/termios.h    | 14 --------------
 arch/sparc/include/asm/termios.h   |  8 +-------
 arch/sparc/kernel/termios.c        |  4 ++--
 drivers/tty/hvc/hvcs.c             |  1 +
 drivers/tty/tty_io.c               |  2 +-
 drivers/tty/tty_ioctl.c            |  1 +
 drivers/tty/vcc.c                  |  1 +
 include/asm-generic/termios-base.h | 21 ---------------------
 include/asm-generic/termios.h      | 20 --------------------
 include/linux/termios_internal.h   | 30 ++++++++++++++++++++++++++++++
 16 files changed, 39 insertions(+), 117 deletions(-)
 delete mode 100644 include/asm-generic/termios-base.h
 create mode 100644 include/linux/termios_internal.h

diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios.h
index bafbb0090024..17b109859e05 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -2,6 +2,7 @@
 #ifndef _ALPHA_TERMIOS_H
 #define _ALPHA_TERMIOS_H
 
+#include <linux/uaccess.h>
 #include <uapi/asm/termios.h>
 
 /*	eof=^D		eol=\0		eol2=\0		erase=del
@@ -12,11 +13,4 @@
 */
 #define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\025\001\000"
 
-int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
-int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
-int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
-int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
-int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
-int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
-
 #endif	/* _ALPHA_TERMIOS_H */
diff --git a/arch/alpha/kernel/termios.c b/arch/alpha/kernel/termios.c
index 1534f39cb9fe..a4c29a22edf7 100644
--- a/arch/alpha/kernel/termios.c
+++ b/arch/alpha/kernel/termios.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/uaccess.h>
-#include <linux/termios.h>
+#include <linux/termios_internal.h>
 
 int user_termio_to_kernel_termios(struct ktermios *termios,
 						struct termio __user *termio)
diff --git a/arch/ia64/include/asm/termios.h b/arch/ia64/include/asm/termios.h
index e7b2654aeb6f..1cef02701401 100644
--- a/arch/ia64/include/asm/termios.h
+++ b/arch/ia64/include/asm/termios.h
@@ -10,20 +10,4 @@
 
 #include <uapi/asm/termios.h>
 
-
-/*	intr=^C		quit=^\		erase=del	kill=^U
-	eof=^D		vtime=\0	vmin=\1		sxtc=\0
-	start=^Q	stop=^S		susp=^Z		eol=\0
-	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
-*/
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
-
-int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
-int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
-int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
-int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
-int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
-int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
-
 #endif /* _ASM_IA64_TERMIOS_H */
diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index 5e8c9d137dee..dbb62330b7a4 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -21,13 +21,4 @@
  */
 #define INIT_C_CC "\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0"
 
-#include <linux/string.h>
-
-int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
-int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
-int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
-int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
-int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
-int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
-
 #endif /* _ASM_TERMIOS_H */
diff --git a/arch/parisc/include/asm/termios.h b/arch/parisc/include/asm/termios.h
index fe21bad7d2b1..1850a90befb3 100644
--- a/arch/parisc/include/asm/termios.h
+++ b/arch/parisc/include/asm/termios.h
@@ -4,20 +4,4 @@
 
 #include <uapi/asm/termios.h>
 
-
-/*	intr=^C		quit=^\		erase=del	kill=^U
-	eof=^D		vtime=\0	vmin=\1		sxtc=\0
-	start=^Q	stop=^S		susp=^Z		eol=\0
-	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
-*/
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
-
-int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
-int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
-int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
-int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
-int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
-int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
-
 #endif	/* _PARISC_TERMIOS_H */
diff --git a/arch/powerpc/include/asm/termios.h b/arch/powerpc/include/asm/termios.h
index 205de8f8a9d3..5c003322fe29 100644
--- a/arch/powerpc/include/asm/termios.h
+++ b/arch/powerpc/include/asm/termios.h
@@ -13,6 +13,4 @@
 /*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^U  */
 #define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\025" 
 
-#include <asm-generic/termios-base.h>
-
 #endif	/* _ASM_POWERPC_TERMIOS_H */
diff --git a/arch/s390/include/asm/termios.h b/arch/s390/include/asm/termios.h
index 46fa3020b41e..0e26fe97b0d4 100644
--- a/arch/s390/include/asm/termios.h
+++ b/arch/s390/include/asm/termios.h
@@ -9,18 +9,4 @@
 
 #include <uapi/asm/termios.h>
 
-
-/*	intr=^C		quit=^\		erase=del	kill=^U
-	eof=^D		vtime=\0	vmin=\1		sxtc=\0
-	start=^Q	stop=^S		susp=^Z		eol=\0
-	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
-*/
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
-
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
-
-#include <asm-generic/termios-base.h>
-
 #endif	/* _S390_TERMIOS_H */
diff --git a/arch/sparc/include/asm/termios.h b/arch/sparc/include/asm/termios.h
index 03bcb6e6abe8..bafd7768f309 100644
--- a/arch/sparc/include/asm/termios.h
+++ b/arch/sparc/include/asm/termios.h
@@ -3,6 +3,7 @@
 #define _SPARC_TERMIOS_H
 
 #include <uapi/asm/termios.h>
+#include <linux/uaccess.h>
 
 
 /*	intr=^C		quit=^\		erase=del	kill=^U
@@ -13,11 +14,4 @@
 */
 #define INIT_C_CC "\003\034\177\025\004\000\000\000\021\023\032\031\022\025\027\026\001"
 
-int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
-int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
-int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
-int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
-int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
-int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
-
 #endif /* _SPARC_TERMIOS_H */
diff --git a/arch/sparc/kernel/termios.c b/arch/sparc/kernel/termios.c
index 97e23d4ae2e2..ee64965c27cd 100644
--- a/arch/sparc/kernel/termios.c
+++ b/arch/sparc/kernel/termios.c
@@ -1,5 +1,5 @@
-#include <linux/uaccess.h>
-#include <linux/termios.h>
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/termios_internal.h>
 
 /*
  * c_cc characters in the termio structure.  Oh, how I love being
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index b79ce8d34f11..4ba24963685e 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -69,6 +69,7 @@
 #include <asm/hvconsole.h>
 #include <asm/hvcserver.h>
 #include <linux/uaccess.h>
+#include <linux/termios_internal.h>
 #include <asm/vio.h>
 
 /*
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 82a8855981f7..571c94c81477 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -99,8 +99,8 @@
 #include <linux/serial.h>
 #include <linux/ratelimit.h>
 #include <linux/compat.h>
-
 #include <linux/uaccess.h>
+#include <linux/termios_internal.h>
 
 #include <linux/kbd_kern.h>
 #include <linux/vt_kern.h>
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 026429276637..ce511557b98b 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -21,6 +21,7 @@
 #include <linux/bitops.h>
 #include <linux/mutex.h>
 #include <linux/compat.h>
+#include <linux/termios_internal.h>
 #include "tty.h"
 
 #include <asm/io.h>
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index e11383ae1e7e..34ba6e54789a 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -11,6 +11,7 @@
 #include <linux/sysfs.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/termios_internal.h>
 #include <asm/vio.h>
 #include <asm/ldc.h>
 
diff --git a/include/asm-generic/termios-base.h b/include/asm-generic/termios-base.h
deleted file mode 100644
index d6536b2214ae..000000000000
--- a/include/asm-generic/termios-base.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* termios.h: generic termios/termio user copying/translation
- */
-
-#ifndef _ASM_GENERIC_TERMIOS_BASE_H
-#define _ASM_GENERIC_TERMIOS_BASE_H
-
-#include <linux/uaccess.h>
-
-#ifndef __ARCH_TERMIO_GETPUT
-
-int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
-int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
-int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
-int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
-int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
-int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
-
-#endif	/* __ARCH_TERMIO_GETPUT */
-
-#endif /* _ASM_GENERIC_TERMIOS_BASE_H */
diff --git a/include/asm-generic/termios.h b/include/asm-generic/termios.h
index 61b07d9ce8d0..da3b0fe25442 100644
--- a/include/asm-generic/termios.h
+++ b/include/asm-generic/termios.h
@@ -6,24 +6,4 @@
 #include <linux/uaccess.h>
 #include <uapi/asm-generic/termios.h>
 
-/*	intr=^C		quit=^\		erase=del	kill=^U
-	eof=^D		vtime=\0	vmin=\1		sxtc=\0
-	start=^Q	stop=^S		susp=^Z		eol=\0
-	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
-*/
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
-
-int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
-int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
-#ifdef TCGETS2
-int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
-int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
-int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
-int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
-#else /* TCGETS2 */
-int user_termios_to_kernel_termios(struct ktermios *, struct termios __user *);
-int kernel_termios_to_user_termios(struct termios __user *, struct ktermios *);
-#endif /* TCGETS2 */
-
 #endif /* _ASM_GENERIC_TERMIOS_H */
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
new file mode 100644
index 000000000000..103ca0370948
--- /dev/null
+++ b/include/linux/termios_internal.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TERMIOS_CONV_H
+#define _LINUX_TERMIOS_CONV_H
+
+#include <linux/uaccess.h>
+#include <asm/termios.h>
+
+#ifndef INIT_C_CC
+/*	intr=^C		quit=^\		erase=del	kill=^U
+	eof=^D		vtime=\0	vmin=\1		sxtc=\0
+	start=^Q	stop=^S		susp=^Z		eol=\0
+	reprint=^R	discard=^U	werase=^W	lnext=^V
+	eol2=\0
+*/
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#endif
+
+int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
+int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
+#ifdef TCGETS2
+int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
+int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
+int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
+int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
+#else /* TCGETS2 */
+int user_termios_to_kernel_termios(struct ktermios *, struct termios __user *);
+int kernel_termios_to_user_termios(struct termios __user *, struct ktermios *);
+#endif /* TCGETS2 */
+
+#endif /* _LINUX_TERMIOS_CONV_H */
-- 
2.30.2

