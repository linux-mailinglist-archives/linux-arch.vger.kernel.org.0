Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5D359B130
	for <lists+linux-arch@lfdr.de>; Sun, 21 Aug 2022 03:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiHUBCr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 21:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiHUBCn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 21:02:43 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D9622B14;
        Sat, 20 Aug 2022 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yJuQuJnDg9CKTWuqBiJsz5frQI73KsGrrNtstHLKktI=; b=q+WgTZfM5/F0PRnx9doW7Jr+Qs
        Yo78gAEspnAR7V8GuqOZ6s+fShMzNnQ60q38kqX9j0pDYm4QnPWZL+yvXyEGv+reutTP9R/tsBHEC
        OcG+phI+ZgFCEhYPr0cJLbojHreAUJFfygAo62LsPAf1OwbkYhcII3EIbVEwiN9Um8+lj6JPFwG6F
        Vm+8/TR9lPbuu9tUnqMtmu39kXOiKh0UstWDgoJ5/CpecbME7oMS8JkVN1hKRWo2y5I99net1iYrb
        1YE370IiPZ4dmDPCyHmdVh+C80befqH6a46Jxgx4qyG2vW6jE0T8sj316xRWzb5g7Z60bgIEnF2Ki
        mvadL5vw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPZMN-006WIw-VC;
        Sun, 21 Aug 2022 01:02:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 4/8] termios: start unifying non-UAPI parts of asm/termios.h
Date:   Sun, 21 Aug 2022 02:02:35 +0100
Message-Id: <20220821010239.1554132-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821010239.1554132-1-viro@zeniv.linux.org.uk>
References: <YwF8vibZ2/Xz7a/g@ZenIV>
 <20220821010239.1554132-1-viro@zeniv.linux.org.uk>
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

* new header (linut/termios_internal.h), pulled by the users of those
suckers
* defaults for INIT_C_CC and externs for conversion helpers moved over
there
* remove termios-base.h (empty now)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/termios.h   |  8 +---
 arch/ia64/include/asm/termios.h    | 16 -------
 arch/mips/include/asm/termios.h    |  9 ----
 arch/parisc/include/asm/termios.h  | 16 -------
 arch/powerpc/include/asm/termios.h |  2 -
 arch/s390/include/asm/termios.h    | 14 ------
 arch/sparc/include/asm/termios.h   |  8 +---
 drivers/tty/hvc/hvcs.c             |  1 +
 drivers/tty/tty_io.c               |  2 +-
 drivers/tty/tty_ioctl.c            |  1 +
 drivers/tty/vcc.c                  |  1 +
 include/asm-generic/termios-base.h | 21 ---------
 include/asm-generic/termios.h      | 73 ------------------------------
 include/linux/termios_internal.h   | 30 ++++++++++++
 14 files changed, 36 insertions(+), 166 deletions(-)
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
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 9b7e8246a464..8b8a2c04c140 100644
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
index ba515f7d69a7..4abb60e1e10d 100644
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
index d1d1ce65aa87..da3b0fe25442 100644
--- a/include/asm-generic/termios.h
+++ b/include/asm-generic/termios.h
@@ -6,77 +6,4 @@
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
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-static inline int user_termio_to_kernel_termios(struct ktermios *termios,
-						const struct termio __user *termio)
-{
-	unsigned short tmp;
-
-	if (get_user(tmp, &termio->c_iflag) < 0)
-		goto fault;
-	termios->c_iflag = (0xffff0000 & termios->c_iflag) | tmp;
-
-	if (get_user(tmp, &termio->c_oflag) < 0)
-		goto fault;
-	termios->c_oflag = (0xffff0000 & termios->c_oflag) | tmp;
-
-	if (get_user(tmp, &termio->c_cflag) < 0)
-		goto fault;
-	termios->c_cflag = (0xffff0000 & termios->c_cflag) | tmp;
-
-	if (get_user(tmp, &termio->c_lflag) < 0)
-		goto fault;
-	termios->c_lflag = (0xffff0000 & termios->c_lflag) | tmp;
-
-	if (get_user(termios->c_line, &termio->c_line) < 0)
-		goto fault;
-
-	if (copy_from_user(termios->c_cc, termio->c_cc, NCC) != 0)
-		goto fault;
-
-	return 0;
-
- fault:
-	return -EFAULT;
-}
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-static inline int kernel_termios_to_user_termio(struct termio __user *termio,
-						struct ktermios *termios)
-{
-	if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
-	    put_user(termios->c_oflag, &termio->c_oflag) < 0 ||
-	    put_user(termios->c_cflag, &termio->c_cflag) < 0 ||
-	    put_user(termios->c_lflag, &termio->c_lflag) < 0 ||
-	    put_user(termios->c_line,  &termio->c_line) < 0 ||
-	    copy_to_user(termio->c_cc, termios->c_cc, NCC) != 0)
-		return -EFAULT;
-
-	return 0;
-}
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

