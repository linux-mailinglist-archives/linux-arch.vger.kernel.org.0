Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E63C5A9DB2
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 19:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiIARGG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 13:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbiIARGF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 13:06:05 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A297A53C;
        Thu,  1 Sep 2022 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DpXTmzBMI1d9nQOAE/tL0hw6BC15YKZPmb8/3RR4Kdg=; b=v/MNnCmPsIZov5Yi2LFi/6twj7
        PnjsZi6QVvDxI7wVR+R2An7pZMysw8ImlS2xNj98WhcoaPIDW93N1fVpzbBSqksqYGKT9Yo4HjRGa
        WhrJr92AZqqDfSiNXI40cv+BMTiFL0JztkazbQFxvV5ELPbUTc6B992CPxF750wqDOMEPU7FB5eVB
        o+WZuEEelRVu8bmoX0CvLZCrjTTigzAa6G1skRnCN/42i7zS35HdzchkOYqcHMxPwqm/HfcNbEuVw
        ombZwB4EK7dWzcJxWydfmS/F4fNGSAb21LslFJwhopVw6H/AGIzE38Ac9Cu94CrhpafUXjzNNiQgH
        ax87e2Lg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTndh-00B2lk-1w;
        Thu, 01 Sep 2022 17:06:01 +0000
Date:   Thu, 1 Sep 2022 18:06:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] termios: uninline conversion helpers
Message-ID: <YxDmeUBHo0s/Ew8b@ZenIV>
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

From 8fac9645e1d22389a65a13f1b506356bcfbb0f14 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sat, 20 Aug 2022 19:36:09 -0400
Subject: [PATCH v3 1/6] termios: uninline conversion helpers

default go into drivers/tty/tty_ioctl.c, unusual - into
arch/*/kernel/termios.c (only alpha and sparc have those).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/termios.h   |  77 ++--------------
 arch/alpha/kernel/Makefile         |   2 +-
 arch/alpha/kernel/termios.c        |  57 ++++++++++++
 arch/ia64/include/asm/termios.h    |  41 ++-------
 arch/mips/include/asm/termios.h    |  84 ++----------------
 arch/parisc/include/asm/termios.h  |  41 ++-------
 arch/sparc/include/asm/termios.h   | 136 ++---------------------------
 arch/sparc/kernel/Makefile         |   4 +-
 arch/sparc/kernel/termios.c        | 115 ++++++++++++++++++++++++
 drivers/tty/tty_ioctl.c            |  74 ++++++++++++++++
 include/asm-generic/termios-base.h |  69 ++-------------
 include/asm-generic/termios.h      |  95 ++------------------
 12 files changed, 294 insertions(+), 501 deletions(-)
 create mode 100644 arch/alpha/kernel/termios.c
 create mode 100644 arch/sparc/kernel/termios.c

diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios.h
index b7c77bb1bfd2..bafbb0090024 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -12,76 +12,11 @@
 */
 #define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\025\001\000"
 
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-
-#define user_termio_to_kernel_termios(a_termios, u_termio)			\
-({										\
-	struct ktermios *k_termios = (a_termios);				\
-	struct termio k_termio;							\
-	int canon, ret;								\
-										\
-	ret = copy_from_user(&k_termio, u_termio, sizeof(k_termio));		\
-	if (!ret) {								\
-		/* Overwrite only the low bits.  */				\
-		*(unsigned short *)&k_termios->c_iflag = k_termio.c_iflag;	\
-		*(unsigned short *)&k_termios->c_oflag = k_termio.c_oflag;	\
-		*(unsigned short *)&k_termios->c_cflag = k_termio.c_cflag;	\
-		*(unsigned short *)&k_termios->c_lflag = k_termio.c_lflag;	\
-		canon = k_termio.c_lflag & ICANON;				\
-										\
-		k_termios->c_cc[VINTR]  = k_termio.c_cc[_VINTR];		\
-		k_termios->c_cc[VQUIT]  = k_termio.c_cc[_VQUIT];		\
-		k_termios->c_cc[VERASE] = k_termio.c_cc[_VERASE];		\
-		k_termios->c_cc[VKILL]  = k_termio.c_cc[_VKILL];		\
-		k_termios->c_cc[VEOL2]  = k_termio.c_cc[_VEOL2];		\
-		k_termios->c_cc[VSWTC]  = k_termio.c_cc[_VSWTC];		\
-		k_termios->c_cc[canon ? VEOF : VMIN]  = k_termio.c_cc[_VEOF];	\
-		k_termios->c_cc[canon ? VEOL : VTIME] = k_termio.c_cc[_VEOL];	\
-	}									\
-	ret;									\
-})
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- *
- * Note the "fun" _VMIN overloading.
- */
-#define kernel_termios_to_user_termio(u_termio, a_termios)		\
-({									\
-	struct ktermios *k_termios = (a_termios);			\
-	struct termio k_termio;						\
-	int canon;							\
-									\
-	k_termio.c_iflag = k_termios->c_iflag;				\
-	k_termio.c_oflag = k_termios->c_oflag;				\
-	k_termio.c_cflag = k_termios->c_cflag;				\
-	canon = (k_termio.c_lflag = k_termios->c_lflag) & ICANON;	\
-									\
-	k_termio.c_line = k_termios->c_line;				\
-	k_termio.c_cc[_VINTR]  = k_termios->c_cc[VINTR];		\
-	k_termio.c_cc[_VQUIT]  = k_termios->c_cc[VQUIT];		\
-	k_termio.c_cc[_VERASE] = k_termios->c_cc[VERASE];		\
-	k_termio.c_cc[_VKILL]  = k_termios->c_cc[VKILL];		\
-	k_termio.c_cc[_VEOF]   = k_termios->c_cc[canon ? VEOF : VMIN];	\
-	k_termio.c_cc[_VEOL]   = k_termios->c_cc[canon ? VEOL : VTIME];	\
-	k_termio.c_cc[_VEOL2]  = k_termios->c_cc[VEOL2];		\
-	k_termio.c_cc[_VSWTC]  = k_termios->c_cc[VSWTC];		\
-									\
-	copy_to_user(u_termio, &k_termio, sizeof(k_termio));		\
-})
-
-#define user_termios_to_kernel_termios(k, u) \
-	copy_from_user(k, u, sizeof(struct termios2))
-
-#define kernel_termios_to_user_termios(u, k) \
-	copy_to_user(u, k, sizeof(struct termios2))
-
-#define user_termios_to_kernel_termios_1(k, u) \
-	copy_from_user(k, u, sizeof(struct termios))
-
-#define kernel_termios_to_user_termios_1(u, k) \
-	copy_to_user(u, k, sizeof(struct termios))
+int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
+int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
+int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
+int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
+int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
+int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
 
 #endif	/* _ALPHA_TERMIOS_H */
diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index 5a74581bf0ee..61e3b42b8322 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -9,7 +9,7 @@ ccflags-y	:= -Wno-sign-compare
 
 obj-y    := entry.o traps.o process.o osf_sys.o irq.o \
 	    irq_alpha.o signal.o setup.o ptrace.o time.o \
-	    systbls.o err_common.o io.o bugs.o
+	    systbls.o err_common.o io.o bugs.o termios.o
 
 obj-$(CONFIG_VGA_HOSE)	+= console.o
 obj-$(CONFIG_SMP)	+= smp.o
diff --git a/arch/alpha/kernel/termios.c b/arch/alpha/kernel/termios.c
new file mode 100644
index 000000000000..1534f39cb9fe
--- /dev/null
+++ b/arch/alpha/kernel/termios.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/uaccess.h>
+#include <linux/termios.h>
+
+int user_termio_to_kernel_termios(struct ktermios *termios,
+						struct termio __user *termio)
+{
+	struct termio v;
+	bool canon;
+
+	if (copy_from_user(&v, termio, sizeof(struct termio)))
+		return -EFAULT;
+
+	termios->c_iflag = (0xffff0000 & termios->c_iflag) | v.c_iflag;
+	termios->c_oflag = (0xffff0000 & termios->c_oflag) | v.c_oflag;
+	termios->c_cflag = (0xffff0000 & termios->c_cflag) | v.c_cflag;
+	termios->c_lflag = (0xffff0000 & termios->c_lflag) | v.c_lflag;
+	termios->c_line = (0xffff0000 & termios->c_lflag) | v.c_line;
+
+	canon = v.c_lflag & ICANON;
+	termios->c_cc[VINTR]  = v.c_cc[_VINTR];
+	termios->c_cc[VQUIT]  = v.c_cc[_VQUIT];
+	termios->c_cc[VERASE] = v.c_cc[_VERASE];
+	termios->c_cc[VKILL]  = v.c_cc[_VKILL];
+	termios->c_cc[VEOL2]  = v.c_cc[_VEOL2];
+	termios->c_cc[VSWTC]  = v.c_cc[_VSWTC];
+	termios->c_cc[canon ? VEOF : VMIN]  = v.c_cc[_VEOF];
+	termios->c_cc[canon ? VEOL : VTIME] = v.c_cc[_VEOL];
+
+	return 0;
+}
+
+int kernel_termios_to_user_termio(struct termio __user *termio,
+						struct ktermios *termios)
+{
+	struct termio v;
+	bool canon;
+
+	memset(&v, 0, sizeof(struct termio));
+	v.c_iflag = termios->c_iflag;
+	v.c_oflag = termios->c_oflag;
+	v.c_cflag = termios->c_cflag;
+	v.c_lflag = termios->c_lflag;
+	v.c_line = termios->c_line;
+
+	canon = v.c_lflag & ICANON;
+	v.c_cc[_VINTR]  = termios->c_cc[VINTR];
+	v.c_cc[_VQUIT]  = termios->c_cc[VQUIT];
+	v.c_cc[_VERASE] = termios->c_cc[VERASE];
+	v.c_cc[_VKILL]  = termios->c_cc[VKILL];
+	v.c_cc[_VEOF]   = termios->c_cc[canon ? VEOF : VMIN];
+	v.c_cc[_VEOL]   = termios->c_cc[canon ? VEOL : VTIME];
+	v.c_cc[_VEOL2]  = termios->c_cc[VEOL2];
+	v.c_cc[_VSWTC]  = termios->c_cc[VSWTC];
+
+	return copy_to_user(termio, &v, sizeof(struct termio));
+}
diff --git a/arch/ia64/include/asm/termios.h b/arch/ia64/include/asm/termios.h
index 589c026444cc..e7b2654aeb6f 100644
--- a/arch/ia64/include/asm/termios.h
+++ b/arch/ia64/include/asm/termios.h
@@ -19,40 +19,11 @@
 */
 #define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
 
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-#define SET_LOW_TERMIOS_BITS(termios, termio, x) {	\
-	unsigned short __tmp;				\
-	get_user(__tmp,&(termio)->x);			\
-	*(unsigned short *) &(termios)->x = __tmp;	\
-}
-
-#define user_termio_to_kernel_termios(termios, termio)		\
-({								\
-	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag);		\
-	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag);		\
-	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag);		\
-	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag);		\
-	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC);	\
-})
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-#define kernel_termios_to_user_termio(termio, termios)		\
-({								\
-	put_user((termios)->c_iflag, &(termio)->c_iflag);	\
-	put_user((termios)->c_oflag, &(termio)->c_oflag);	\
-	put_user((termios)->c_cflag, &(termio)->c_cflag);	\
-	put_user((termios)->c_lflag, &(termio)->c_lflag);	\
-	put_user((termios)->c_line,  &(termio)->c_line);	\
-	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC);	\
-})
-
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
-#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios))
+int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
+int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
+int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
+int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
+int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
+int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
 
 #endif /* _ASM_IA64_TERMIOS_H */
diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index bc29eeacc55a..5e8c9d137dee 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -23,83 +23,11 @@
 
 #include <linux/string.h>
 
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-static inline int user_termio_to_kernel_termios(struct ktermios *termios,
-	struct termio __user *termio)
-{
-	unsigned short iflag, oflag, cflag, lflag;
-	unsigned int err;
-
-	if (!access_ok(termio, sizeof(struct termio)))
-		return -EFAULT;
-
-	err = __get_user(iflag, &termio->c_iflag);
-	termios->c_iflag = (termios->c_iflag & 0xffff0000) | iflag;
-	err |=__get_user(oflag, &termio->c_oflag);
-	termios->c_oflag = (termios->c_oflag & 0xffff0000) | oflag;
-	err |=__get_user(cflag, &termio->c_cflag);
-	termios->c_cflag = (termios->c_cflag & 0xffff0000) | cflag;
-	err |=__get_user(lflag, &termio->c_lflag);
-	termios->c_lflag = (termios->c_lflag & 0xffff0000) | lflag;
-	err |=__get_user(termios->c_line, &termio->c_line);
-	if (err)
-		return -EFAULT;
-
-	if (__copy_from_user(termios->c_cc, termio->c_cc, NCC))
-		return -EFAULT;
-
-	return 0;
-}
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-static inline int kernel_termios_to_user_termio(struct termio __user *termio,
-	struct ktermios *termios)
-{
-	int err;
-
-	if (!access_ok(termio, sizeof(struct termio)))
-		return -EFAULT;
-
-	err = __put_user(termios->c_iflag, &termio->c_iflag);
-	err |= __put_user(termios->c_oflag, &termio->c_oflag);
-	err |= __put_user(termios->c_cflag, &termio->c_cflag);
-	err |= __put_user(termios->c_lflag, &termio->c_lflag);
-	err |= __put_user(termios->c_line, &termio->c_line);
-	if (err)
-		return -EFAULT;
-
-	if (__copy_to_user(termio->c_cc, termios->c_cc, NCC))
-		return -EFAULT;
-
-	return 0;
-}
-
-static inline int user_termios_to_kernel_termios(struct ktermios __user *k,
-	struct termios2 *u)
-{
-	return copy_from_user(k, u, sizeof(struct termios2)) ? -EFAULT : 0;
-}
-
-static inline int kernel_termios_to_user_termios(struct termios2 __user *u,
-	struct ktermios *k)
-{
-	return copy_to_user(u, k, sizeof(struct termios2)) ? -EFAULT : 0;
-}
-
-static inline int user_termios_to_kernel_termios_1(struct ktermios *k,
-	struct termios __user *u)
-{
-	return copy_from_user(k, u, sizeof(struct termios)) ? -EFAULT : 0;
-}
-
-static inline int kernel_termios_to_user_termios_1(struct termios __user *u,
-	struct ktermios *k)
-{
-	return copy_to_user(u, k, sizeof(struct termios)) ? -EFAULT : 0;
-}
+int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
+int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
+int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
+int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
+int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
+int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
 
 #endif /* _ASM_TERMIOS_H */
diff --git a/arch/parisc/include/asm/termios.h b/arch/parisc/include/asm/termios.h
index cded9dc90c1b..fe21bad7d2b1 100644
--- a/arch/parisc/include/asm/termios.h
+++ b/arch/parisc/include/asm/termios.h
@@ -13,40 +13,11 @@
 */
 #define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
 
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-#define SET_LOW_TERMIOS_BITS(termios, termio, x) { \
-	unsigned short __tmp; \
-	get_user(__tmp,&(termio)->x); \
-	*(unsigned short *) &(termios)->x = __tmp; \
-}
-
-#define user_termio_to_kernel_termios(termios, termio) \
-({ \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag); \
-	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
-})
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-#define kernel_termios_to_user_termio(termio, termios) \
-({ \
-	put_user((termios)->c_iflag, &(termio)->c_iflag); \
-	put_user((termios)->c_oflag, &(termio)->c_oflag); \
-	put_user((termios)->c_cflag, &(termio)->c_cflag); \
-	put_user((termios)->c_lflag, &(termio)->c_lflag); \
-	put_user((termios)->c_line,  &(termio)->c_line); \
-	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
-})
-
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
-#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios))
+int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
+int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
+int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
+int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
+int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
+int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
 
 #endif	/* _PARISC_TERMIOS_H */
diff --git a/arch/sparc/include/asm/termios.h b/arch/sparc/include/asm/termios.h
index 4a558efdfa93..03bcb6e6abe8 100644
--- a/arch/sparc/include/asm/termios.h
+++ b/arch/sparc/include/asm/termios.h
@@ -5,17 +5,6 @@
 #include <uapi/asm/termios.h>
 
 
-/*
- * c_cc characters in the termio structure.  Oh, how I love being
- * backwardly compatible.  Notice that character 4 and 5 are
- * interpreted differently depending on whether ICANON is set in
- * c_lflag.  If it's set, they are used as _VEOF and _VEOL, otherwise
- * as _VMIN and V_TIME.  This is for compatibility with OSF/1 (which
- * is compatible with sysV)...
- */
-#define _VMIN	4
-#define _VTIME	5
-
 /*	intr=^C		quit=^\		erase=del	kill=^U
 	eof=^D		eol=\0		eol2=\0		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		dsusp=^Y
@@ -24,124 +13,11 @@
 */
 #define INIT_C_CC "\003\034\177\025\004\000\000\000\021\023\032\031\022\025\027\026\001"
 
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-#define user_termio_to_kernel_termios(termios, termio) \
-({ \
-	unsigned short tmp; \
-	int err; \
-	err = get_user(tmp, &(termio)->c_iflag); \
-	(termios)->c_iflag = (0xffff0000 & ((termios)->c_iflag)) | tmp; \
-	err |= get_user(tmp, &(termio)->c_oflag); \
-	(termios)->c_oflag = (0xffff0000 & ((termios)->c_oflag)) | tmp; \
-	err |= get_user(tmp, &(termio)->c_cflag); \
-	(termios)->c_cflag = (0xffff0000 & ((termios)->c_cflag)) | tmp; \
-	err |= get_user(tmp, &(termio)->c_lflag); \
-	(termios)->c_lflag = (0xffff0000 & ((termios)->c_lflag)) | tmp; \
-	err |= copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
-	err; \
-})
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- *
- * Note the "fun" _VMIN overloading.
- */
-#define kernel_termios_to_user_termio(termio, termios) \
-({ \
-	int err; \
-	err  = put_user((termios)->c_iflag, &(termio)->c_iflag); \
-	err |= put_user((termios)->c_oflag, &(termio)->c_oflag); \
-	err |= put_user((termios)->c_cflag, &(termio)->c_cflag); \
-	err |= put_user((termios)->c_lflag, &(termio)->c_lflag); \
-	err |= put_user((termios)->c_line,  &(termio)->c_line); \
-	err |= copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
-	if (!((termios)->c_lflag & ICANON)) { \
-		err |= put_user((termios)->c_cc[VMIN], &(termio)->c_cc[_VMIN]); \
-		err |= put_user((termios)->c_cc[VTIME], &(termio)->c_cc[_VTIME]); \
-	} \
-	err; \
-})
-
-#define user_termios_to_kernel_termios(k, u) \
-({ \
-	int err; \
-	err  = get_user((k)->c_iflag, &(u)->c_iflag); \
-	err |= get_user((k)->c_oflag, &(u)->c_oflag); \
-	err |= get_user((k)->c_cflag, &(u)->c_cflag); \
-	err |= get_user((k)->c_lflag, &(u)->c_lflag); \
-	err |= get_user((k)->c_line,  &(u)->c_line); \
-	err |= copy_from_user((k)->c_cc, (u)->c_cc, NCCS); \
-	if ((k)->c_lflag & ICANON) { \
-		err |= get_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		err |= get_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
-	} else { \
-		err |= get_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		err |= get_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
-	} \
-	err |= get_user((k)->c_ispeed,  &(u)->c_ispeed); \
-	err |= get_user((k)->c_ospeed,  &(u)->c_ospeed); \
-	err; \
-})
-
-#define kernel_termios_to_user_termios(u, k) \
-({ \
-	int err; \
-	err  = put_user((k)->c_iflag, &(u)->c_iflag); \
-	err |= put_user((k)->c_oflag, &(u)->c_oflag); \
-	err |= put_user((k)->c_cflag, &(u)->c_cflag); \
-	err |= put_user((k)->c_lflag, &(u)->c_lflag); \
-	err |= put_user((k)->c_line, &(u)->c_line); \
-	err |= copy_to_user((u)->c_cc, (k)->c_cc, NCCS); \
-	if (!((k)->c_lflag & ICANON)) { \
-		err |= put_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		err |= put_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
-	} else { \
-		err |= put_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		err |= put_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
-	} \
-	err |= put_user((k)->c_ispeed, &(u)->c_ispeed); \
-	err |= put_user((k)->c_ospeed, &(u)->c_ospeed); \
-	err; \
-})
-
-#define user_termios_to_kernel_termios_1(k, u) \
-({ \
-	int err; \
-	err  = get_user((k)->c_iflag, &(u)->c_iflag); \
-	err |= get_user((k)->c_oflag, &(u)->c_oflag); \
-	err |= get_user((k)->c_cflag, &(u)->c_cflag); \
-	err |= get_user((k)->c_lflag, &(u)->c_lflag); \
-	err |= get_user((k)->c_line,  &(u)->c_line); \
-	err |= copy_from_user((k)->c_cc, (u)->c_cc, NCCS); \
-	if ((k)->c_lflag & ICANON) { \
-		err |= get_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		err |= get_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
-	} else { \
-		err |= get_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		err |= get_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
-	} \
-	err; \
-})
-
-#define kernel_termios_to_user_termios_1(u, k) \
-({ \
-	int err; \
-	err  = put_user((k)->c_iflag, &(u)->c_iflag); \
-	err |= put_user((k)->c_oflag, &(u)->c_oflag); \
-	err |= put_user((k)->c_cflag, &(u)->c_cflag); \
-	err |= put_user((k)->c_lflag, &(u)->c_lflag); \
-	err |= put_user((k)->c_line, &(u)->c_line); \
-	err |= copy_to_user((u)->c_cc, (k)->c_cc, NCCS); \
-	if (!((k)->c_lflag & ICANON)) { \
-		err |= put_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		err |= put_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
-	} else { \
-		err |= put_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		err |= put_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
-	} \
-	err; \
-})
+int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
+int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
+int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
+int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
+int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
+int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
 
 #endif /* _SPARC_TERMIOS_H */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index d3a0e072ebe8..620c0c5b749b 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -87,12 +87,13 @@ obj-$(CONFIG_SPARC64_SMP) += hvtramp.o
 obj-y                     += auxio_$(BITS).o
 obj-$(CONFIG_SUN_PM)      += apc.o pmc.o
 
+obj-y                     += termios.o
+
 obj-$(CONFIG_MODULES)     += module.o
 obj-$(CONFIG_MODULES)     += sparc_ksyms.o
 obj-$(CONFIG_SPARC_LED)   += led.o
 obj-$(CONFIG_KGDB)        += kgdb_$(BITS).o
 
-
 obj-$(CONFIG_DYNAMIC_FTRACE) += ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o
 
@@ -104,6 +105,7 @@ obj-$(CONFIG_SPARC64_PCI)    += pci_psycho.o pci_sabre.o pci_schizo.o
 obj-$(CONFIG_SPARC64_PCI)    += pci_sun4v.o pci_sun4v_asm.o pci_fire.o
 obj-$(CONFIG_SPARC64_PCI_MSI) += pci_msi.o
 
+
 obj-$(CONFIG_COMPAT)         += sys32.o sys_sparc32.o signal32.o
 
 obj-$(CONFIG_US3_MC)    += chmc.o
diff --git a/arch/sparc/kernel/termios.c b/arch/sparc/kernel/termios.c
new file mode 100644
index 000000000000..97e23d4ae2e2
--- /dev/null
+++ b/arch/sparc/kernel/termios.c
@@ -0,0 +1,115 @@
+#include <linux/uaccess.h>
+#include <linux/termios.h>
+
+/*
+ * c_cc characters in the termio structure.  Oh, how I love being
+ * backwardly compatible.  Notice that character 4 and 5 are
+ * interpreted differently depending on whether ICANON is set in
+ * c_lflag.  If it's set, they are used as _VEOF and _VEOL, otherwise
+ * as _VMIN and V_TIME.  This is for compatibility with OSF/1 (which
+ * is compatible with sysV)...
+ */
+#define _VMIN	4
+#define _VTIME	5
+
+int kernel_termios_to_user_termio(struct termio __user *termio,
+						struct ktermios *termios)
+{
+	struct termio v;
+	memset(&v, 0, sizeof(struct termio));
+	v.c_iflag = termios->c_iflag;
+	v.c_oflag = termios->c_oflag;
+	v.c_cflag = termios->c_cflag;
+	v.c_lflag = termios->c_lflag;
+	v.c_line = termios->c_line;
+	memcpy(v.c_cc, termios->c_cc, NCC);
+	if (!(v.c_lflag & ICANON)) {
+		v.c_cc[_VMIN] = termios->c_cc[VMIN];
+		v.c_cc[_VTIME] = termios->c_cc[VTIME];
+	}
+	return copy_to_user(termio, &v, sizeof(struct termio));
+}
+
+int user_termios_to_kernel_termios(struct ktermios *k,
+						 struct termios2 __user *u)
+{
+	int err;
+	err  = get_user(k->c_iflag, &u->c_iflag);
+	err |= get_user(k->c_oflag, &u->c_oflag);
+	err |= get_user(k->c_cflag, &u->c_cflag);
+	err |= get_user(k->c_lflag, &u->c_lflag);
+	err |= get_user(k->c_line,  &u->c_line);
+	err |= copy_from_user(k->c_cc, u->c_cc, NCCS);
+	if (k->c_lflag & ICANON) {
+		err |= get_user(k->c_cc[VEOF], &u->c_cc[VEOF]);
+		err |= get_user(k->c_cc[VEOL], &u->c_cc[VEOL]);
+	} else {
+		err |= get_user(k->c_cc[VMIN],  &u->c_cc[_VMIN]);
+		err |= get_user(k->c_cc[VTIME], &u->c_cc[_VTIME]);
+	}
+	err |= get_user(k->c_ispeed,  &u->c_ispeed);
+	err |= get_user(k->c_ospeed,  &u->c_ospeed);
+	return err;
+}
+
+int kernel_termios_to_user_termios(struct termios2 __user *u,
+						 struct ktermios *k)
+{
+	int err;
+	err  = put_user(k->c_iflag, &u->c_iflag);
+	err |= put_user(k->c_oflag, &u->c_oflag);
+	err |= put_user(k->c_cflag, &u->c_cflag);
+	err |= put_user(k->c_lflag, &u->c_lflag);
+	err |= put_user(k->c_line, &u->c_line);
+	err |= copy_to_user(u->c_cc, k->c_cc, NCCS);
+	if (!(k->c_lflag & ICANON)) {
+		err |= put_user(k->c_cc[VMIN],  &u->c_cc[_VMIN]);
+		err |= put_user(k->c_cc[VTIME], &u->c_cc[_VTIME]);
+	} else {
+		err |= put_user(k->c_cc[VEOF], &u->c_cc[VEOF]);
+		err |= put_user(k->c_cc[VEOL], &u->c_cc[VEOL]);
+	}
+	err |= put_user(k->c_ispeed, &u->c_ispeed);
+	err |= put_user(k->c_ospeed, &u->c_ospeed);
+	return err;
+}
+
+int user_termios_to_kernel_termios_1(struct ktermios *k,
+						 struct termios __user *u)
+{
+	int err;
+	err  = get_user(k->c_iflag, &u->c_iflag);
+	err |= get_user(k->c_oflag, &u->c_oflag);
+	err |= get_user(k->c_cflag, &u->c_cflag);
+	err |= get_user(k->c_lflag, &u->c_lflag);
+	err |= get_user(k->c_line,  &u->c_line);
+	err |= copy_from_user(k->c_cc, u->c_cc, NCCS);
+	if (k->c_lflag & ICANON) {
+		err |= get_user(k->c_cc[VEOF], &u->c_cc[VEOF]);
+		err |= get_user(k->c_cc[VEOL], &u->c_cc[VEOL]);
+	} else {
+		err |= get_user(k->c_cc[VMIN],  &u->c_cc[_VMIN]);
+		err |= get_user(k->c_cc[VTIME], &u->c_cc[_VTIME]);
+	}
+	return err;
+}
+
+int kernel_termios_to_user_termios_1(struct termios __user *u,
+						 struct ktermios *k)
+{
+	int err;
+	err  = put_user(k->c_iflag, &u->c_iflag);
+	err |= put_user(k->c_oflag, &u->c_oflag);
+	err |= put_user(k->c_cflag, &u->c_cflag);
+	err |= put_user(k->c_lflag, &u->c_lflag);
+	err |= put_user(k->c_line, &u->c_line);
+	err |= copy_to_user(u->c_cc, k->c_cc, NCCS);
+	if (!(k->c_lflag & ICANON)) {
+		err |= put_user(k->c_cc[VMIN],  &u->c_cc[_VMIN]);
+		err |= put_user(k->c_cc[VTIME], &u->c_cc[_VTIME]);
+	} else {
+		err |= put_user(k->c_cc[VEOF], &u->c_cc[VEOF]);
+		err |= put_user(k->c_cc[VEOL], &u->c_cc[VEOL]);
+	}
+	return err;
+}
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 31d11230e778..026429276637 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -374,6 +374,80 @@ int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 }
 EXPORT_SYMBOL_GPL(tty_set_termios);
 
+
+/*
+ * Translate a "termio" structure into a "termios". Ugh.
+ */
+__weak int user_termio_to_kernel_termios(struct ktermios *termios,
+						struct termio __user *termio)
+{
+	struct termio v;
+
+	if (copy_from_user(&v, termio, sizeof(struct termio)))
+		return -EFAULT;
+
+	termios->c_iflag = (0xffff0000 & termios->c_iflag) | v.c_iflag;
+	termios->c_oflag = (0xffff0000 & termios->c_oflag) | v.c_oflag;
+	termios->c_cflag = (0xffff0000 & termios->c_cflag) | v.c_cflag;
+	termios->c_lflag = (0xffff0000 & termios->c_lflag) | v.c_lflag;
+	termios->c_line = (0xffff0000 & termios->c_lflag) | v.c_line;
+	memcpy(termios->c_cc, v.c_cc, NCC);
+	return 0;
+}
+
+/*
+ * Translate a "termios" structure into a "termio". Ugh.
+ */
+__weak int kernel_termios_to_user_termio(struct termio __user *termio,
+						struct ktermios *termios)
+{
+	struct termio v;
+	memset(&v, 0, sizeof(struct termio));
+	v.c_iflag = termios->c_iflag;
+	v.c_oflag = termios->c_oflag;
+	v.c_cflag = termios->c_cflag;
+	v.c_lflag = termios->c_lflag;
+	v.c_line = termios->c_line;
+	memcpy(v.c_cc, termios->c_cc, NCC);
+	return copy_to_user(termio, &v, sizeof(struct termio));
+}
+
+#ifdef TCGETS2
+__weak int user_termios_to_kernel_termios(struct ktermios *k,
+						 struct termios2 __user *u)
+{
+	return copy_from_user(k, u, sizeof(struct termios2));
+}
+__weak int kernel_termios_to_user_termios(struct termios2 __user *u,
+						 struct ktermios *k)
+{
+	return copy_to_user(u, k, sizeof(struct termios2));
+}
+__weak int user_termios_to_kernel_termios_1(struct ktermios *k,
+						   struct termios __user *u)
+{
+	return copy_from_user(k, u, sizeof(struct termios));
+}
+__weak int kernel_termios_to_user_termios_1(struct termios __user *u,
+						   struct ktermios *k)
+{
+	return copy_to_user(u, k, sizeof(struct termios));
+}
+
+#else
+
+__weak int user_termios_to_kernel_termios(struct ktermios *k,
+						 struct termios __user *u)
+{
+	return copy_from_user(k, u, sizeof(struct termios));
+}
+__weak int kernel_termios_to_user_termios(struct termios __user *u,
+						 struct ktermios *k)
+{
+	return copy_to_user(u, k, sizeof(struct termios));
+}
+#endif /* TCGETS2 */
+
 /**
  *	set_termios		-	set termios values for a tty
  *	@tty: terminal device
diff --git a/include/asm-generic/termios-base.h b/include/asm-generic/termios-base.h
index 59c5a3bd4a6e..d6536b2214ae 100644
--- a/include/asm-generic/termios-base.h
+++ b/include/asm-generic/termios-base.h
@@ -9,69 +9,12 @@
 
 #ifndef __ARCH_TERMIO_GETPUT
 
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-static inline int user_termio_to_kernel_termios(struct ktermios *termios,
-						struct termio __user *termio)
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
-#ifndef user_termios_to_kernel_termios
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
-#endif
-
-#ifndef kernel_termios_to_user_termios
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
-#endif
-
-#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios))
+int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
+int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
+int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
+int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
+int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
+int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
 
 #endif	/* __ARCH_TERMIO_GETPUT */
 
diff --git a/include/asm-generic/termios.h b/include/asm-generic/termios.h
index b1398d0d4a1d..61b07d9ce8d0 100644
--- a/include/asm-generic/termios.h
+++ b/include/asm-generic/termios.h
@@ -14,95 +14,16 @@
 */
 #define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
 
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
+int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
+int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
 #ifdef TCGETS2
-static inline int user_termios_to_kernel_termios(struct ktermios *k,
-						 struct termios2 __user *u)
-{
-	return copy_from_user(k, u, sizeof(struct termios2));
-}
-
-static inline int kernel_termios_to_user_termios(struct termios2 __user *u,
-						 struct ktermios *k)
-{
-	return copy_to_user(u, k, sizeof(struct termios2));
-}
-
-static inline int user_termios_to_kernel_termios_1(struct ktermios *k,
-						   struct termios __user *u)
-{
-	return copy_from_user(k, u, sizeof(struct termios));
-}
-
-static inline int kernel_termios_to_user_termios_1(struct termios __user *u,
-						   struct ktermios *k)
-{
-	return copy_to_user(u, k, sizeof(struct termios));
-}
+int user_termios_to_kernel_termios(struct ktermios *, struct termios2 __user *);
+int kernel_termios_to_user_termios(struct termios2 __user *, struct ktermios *);
+int user_termios_to_kernel_termios_1(struct ktermios *, struct termios __user *);
+int kernel_termios_to_user_termios_1(struct termios __user *, struct ktermios *);
 #else /* TCGETS2 */
-static inline int user_termios_to_kernel_termios(struct ktermios *k,
-						 struct termios __user *u)
-{
-	return copy_from_user(k, u, sizeof(struct termios));
-}
-
-static inline int kernel_termios_to_user_termios(struct termios __user *u,
-						 struct ktermios *k)
-{
-	return copy_to_user(u, k, sizeof(struct termios));
-}
+int user_termios_to_kernel_termios(struct ktermios *, struct termios __user *);
+int kernel_termios_to_user_termios(struct termios __user *, struct ktermios *);
 #endif /* TCGETS2 */
 
 #endif /* _ASM_GENERIC_TERMIOS_H */
-- 
2.30.2

