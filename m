Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE76D59AAFE
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 05:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242748AbiHTDhh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 23:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239546AbiHTDhf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 23:37:35 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C98A79EFF;
        Fri, 19 Aug 2022 20:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QoUdxktipGdd7CFAPVb6l0ymzy8zQ57/2mTbVkBGCwo=; b=RqtNfQ3Srxh3wjlhZjP7ZDEJmX
        S5s3SBV9WRcAQhWe8TAjgqx5FI9+OLOavT71+FZIItqu3fPWdnOeVKYjn9rreUg2U7bxykk0qUTZe
        nFwvEL7emBW0r7552HTz47xl/Y4IoGTCksgEL+DUPf2LJY2LKsgBKoTJaQhoq0DJuX7flshTs3nmB
        weHsem9M3pEn1/6zPD19/pII1jZ/QGKmV2vItDsZNlAu2atQAijWC9hZwedZTt/iBwVAeClIxNLHV
        U/7i8L4naqDN2zpFyxCdZAAkkYzAMPplr4rq1lJZSuluTH+k3IRzUMH2EcV1s0qnD8ZCI9pQpI93g
        9+uX+Abg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPFIh-006Hnp-4I;
        Sat, 20 Aug 2022 03:37:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/7] start unifying INIT_C_CC and termios convertors
Date:   Sat, 20 Aug 2022 04:37:26 +0100
Message-Id: <20220820033730.1498392-3-viro@zeniv.linux.org.uk>
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

* new header (linut/termios_internal.h), pulled by the users of those
suckers
* defaults for INIT_C_CC and conversion helpers moved over there
* remove termios-base.h (empty now)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/termios.h   | 110 +++++++--------
 arch/ia64/include/asm/termios.h    |  45 ------
 arch/mips/include/asm/termios.h    |  81 -----------
 arch/parisc/include/asm/termios.h  |  45 ------
 arch/powerpc/include/asm/termios.h |   2 -
 arch/s390/include/asm/termios.h    |  14 --
 arch/sparc/include/asm/termios.h   | 217 ++++++++++++++---------------
 drivers/tty/hvc/hvcs.c             |   1 +
 drivers/tty/tty_io.c               |   2 +-
 drivers/tty/tty_ioctl.c            |   1 +
 drivers/tty/vcc.c                  |   1 +
 include/asm-generic/termios-base.h |  78 -----------
 include/asm-generic/termios.h      |  99 -------------
 include/linux/termios_internal.h   | 109 +++++++++++++++
 14 files changed, 272 insertions(+), 533 deletions(-)
 delete mode 100644 include/asm-generic/termios-base.h
 create mode 100644 include/linux/termios_internal.h

diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios.h
index b7c77bb1bfd2..63e1ffc8f719 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -2,6 +2,7 @@
 #ifndef _ALPHA_TERMIOS_H
 #define _ALPHA_TERMIOS_H
 
+#include <linux/uaccess.h>
 #include <uapi/asm/termios.h>
 
 /*	eof=^D		eol=\0		eol2=\0		erase=del
@@ -16,72 +17,65 @@
  * Translate a "termio" structure into a "termios". Ugh.
  */
 
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
+static inline int user_termio_to_kernel_termios(struct ktermios *termios,
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
+#define user_termio_to_kernel_termios user_termio_to_kernel_termios
 
 /*
  * Translate a "termios" structure into a "termio". Ugh.
  *
  * Note the "fun" _VMIN overloading.
  */
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
+static inline int kernel_termios_to_user_termio(struct termio __user *termio,
+						struct ktermios *termios)
+{
+	struct termio v;
+	bool canon;
 
-#define kernel_termios_to_user_termios(u, k) \
-	copy_to_user(u, k, sizeof(struct termios2))
+	memset(&v, 0, sizeof(struct termio));
+	v.c_iflag = termios->c_iflag;
+	v.c_oflag = termios->c_oflag;
+	v.c_cflag = termios->c_cflag;
+	v.c_lflag = termios->c_lflag;
+	v.c_line = termios->c_line;
 
-#define user_termios_to_kernel_termios_1(k, u) \
-	copy_from_user(k, u, sizeof(struct termios))
+	canon = v.c_lflag & ICANON;
+	v.c_cc[_VINTR]  = termios->c_cc[VINTR];
+	v.c_cc[_VQUIT]  = termios->c_cc[VQUIT];
+	v.c_cc[_VERASE] = termios->c_cc[VERASE];
+	v.c_cc[_VKILL]  = termios->c_cc[VKILL];
+	v.c_cc[_VEOF]   = termios->c_cc[canon ? VEOF : VMIN];
+	v.c_cc[_VEOL]   = termios->c_cc[canon ? VEOL : VTIME];
+	v.c_cc[_VEOL2]  = termios->c_cc[VEOL2];
+	v.c_cc[_VSWTC]  = termios->c_cc[VSWTC];
 
-#define kernel_termios_to_user_termios_1(u, k) \
-	copy_to_user(u, k, sizeof(struct termios))
+	return copy_to_user(termio, &v, sizeof(struct termio));
+}
+#define kernel_termios_to_user_termio kernel_termios_to_user_termio
 
 #endif	/* _ALPHA_TERMIOS_H */
diff --git a/arch/ia64/include/asm/termios.h b/arch/ia64/include/asm/termios.h
index 589c026444cc..1cef02701401 100644
--- a/arch/ia64/include/asm/termios.h
+++ b/arch/ia64/include/asm/termios.h
@@ -10,49 +10,4 @@
 
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
-
 #endif /* _ASM_IA64_TERMIOS_H */
diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index bc29eeacc55a..dbb62330b7a4 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -21,85 +21,4 @@
  */
 #define INIT_C_CC "\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0"
 
-#include <linux/string.h>
-
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
-
 #endif /* _ASM_TERMIOS_H */
diff --git a/arch/parisc/include/asm/termios.h b/arch/parisc/include/asm/termios.h
index cded9dc90c1b..1850a90befb3 100644
--- a/arch/parisc/include/asm/termios.h
+++ b/arch/parisc/include/asm/termios.h
@@ -4,49 +4,4 @@
 
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
index 4a558efdfa93..0652f870bb1a 100644
--- a/arch/sparc/include/asm/termios.h
+++ b/arch/sparc/include/asm/termios.h
@@ -3,6 +3,7 @@
 #define _SPARC_TERMIOS_H
 
 #include <uapi/asm/termios.h>
+#include <linux/uaccess.h>
 
 
 /*
@@ -24,124 +25,120 @@
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
 /*
  * Translate a "termios" structure into a "termio". Ugh.
  *
  * Note the "fun" _VMIN overloading.
  */
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
+static inline int kernel_termios_to_user_termio(struct termio __user *termio,
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
+#define kernel_termios_to_user_termio kernel_termios_to_user_termio
+
+static inline int user_termios_to_kernel_termios(struct ktermios *k,
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
+#define user_termios_to_kernel_termios user_termios_to_kernel_termios
+
+static inline int kernel_termios_to_user_termios(struct termios2 __user *u,
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
+#define kernel_termios_to_user_termios kernel_termios_to_user_termios
 
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
+static inline int user_termios_to_kernel_termios_1(struct ktermios *k,
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
+#define user_termios_to_kernel_termios_1 user_termios_to_kernel_termios_1
 
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
+static inline int kernel_termios_to_user_termios_1(struct termios __user *u,
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
+#define kernel_termios_to_user_termios_1 kernel_termios_to_user_termios_1
 
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
index 2a76b330e108..a9cb37d9e701 100644
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
index 59c5a3bd4a6e..000000000000
--- a/include/asm-generic/termios-base.h
+++ /dev/null
@@ -1,78 +0,0 @@
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
-
-#endif	/* __ARCH_TERMIO_GETPUT */
-
-#endif /* _ASM_GENERIC_TERMIOS_BASE_H */
diff --git a/include/asm-generic/termios.h b/include/asm-generic/termios.h
index b1398d0d4a1d..da3b0fe25442 100644
--- a/include/asm-generic/termios.h
+++ b/include/asm-generic/termios.h
@@ -6,103 +6,4 @@
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
-#ifdef TCGETS2
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
-#else /* TCGETS2 */
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
-#endif /* TCGETS2 */
-
 #endif /* _ASM_GENERIC_TERMIOS_H */
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
new file mode 100644
index 000000000000..a77fd8df783e
--- /dev/null
+++ b/include/linux/termios_internal.h
@@ -0,0 +1,109 @@
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
+#ifndef user_termio_to_kernel_termios
+/*
+ * Translate a "termio" structure into a "termios". Ugh.
+ */
+static inline int user_termio_to_kernel_termios(struct ktermios *termios,
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
+#endif
+
+#ifndef kernel_termios_to_user_termio
+/*
+ * Translate a "termios" structure into a "termio". Ugh.
+ */
+static inline int kernel_termios_to_user_termio(struct termio __user *termio,
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
+#endif
+
+#ifdef TCGETS2
+#ifndef user_termios_to_kernel_termios
+static inline int user_termios_to_kernel_termios(struct ktermios *k,
+						 struct termios2 __user *u)
+{
+	return copy_from_user(k, u, sizeof(struct termios2));
+}
+#endif
+#ifndef kernel_termios_to_user_termios
+static inline int kernel_termios_to_user_termios(struct termios2 __user *u,
+						 struct ktermios *k)
+{
+	return copy_to_user(u, k, sizeof(struct termios2));
+}
+#endif
+#ifndef user_termios_to_kernel_termios_1
+static inline int user_termios_to_kernel_termios_1(struct ktermios *k,
+						   struct termios __user *u)
+{
+	return copy_from_user(k, u, sizeof(struct termios));
+}
+#endif
+
+#ifndef kernel_termios_to_user_termios_1
+static inline int kernel_termios_to_user_termios_1(struct termios __user *u,
+						   struct ktermios *k)
+{
+	return copy_to_user(u, k, sizeof(struct termios));
+}
+#endif
+
+#else
+
+#ifndef user_termios_to_kernel_termios
+static inline int user_termios_to_kernel_termios(struct ktermios *k,
+						 struct termios __user *u)
+{
+	return copy_from_user(k, u, sizeof(struct termios));
+}
+#endif
+#ifndef kernel_termios_to_user_termios
+static inline int kernel_termios_to_user_termios(struct termios __user *u,
+						 struct ktermios *k)
+{
+	return copy_to_user(u, k, sizeof(struct termios));
+}
+#endif
+
+#endif /* TCGETS2 */
+
+#endif /* _LINUX_TERMIOS_CONV_H */
-- 
2.30.2

