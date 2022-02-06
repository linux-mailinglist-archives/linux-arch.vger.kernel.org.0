Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A294AB08F
	for <lists+linux-arch@lfdr.de>; Sun,  6 Feb 2022 17:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244645AbiBFQBE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Feb 2022 11:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244510AbiBFQA5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Feb 2022 11:00:57 -0500
Received: from talisker.home.drummond.us (drummond.us [74.95.14.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD6C043185
        for <linux-arch@vger.kernel.org>; Sun,  6 Feb 2022 08:00:55 -0800 (PST)
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 216FnFcx2355991;
        Sun, 6 Feb 2022 07:49:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1644162555;
        bh=7WjDICKhQyle4ios60Wujz51yzrHyAgGXW0FdAX5LKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jEHR7t9I6Z01rIBKHMFEJWOPInp2qdkBjHW1DWmjQygEelBTBWuPBCSnJs4uhZQGC
         w9Ai5svPwtB0yRjx0J2JPpVMDyL+X2gFzBKvRapq8hHpXcOL/CWvvgXCfraKpEmyyx
         nwTQz6rkeMIHqv2Pc2iYwX6IZv9Q4iDVqnPR2dLowtQOfdkXjT4KqUXTj8+wJKEhvu
         HNjK8gCoPfULPg+ThGLUeRdpGIlidb5BvoTp48/Uu3cEKz3cDN18Axadfg5XShRIDJ
         asSxyOTKLtSibtgW4tHTnYrELjLANpK/naXJKJJTSn8lgpXXsmqwvzSUeS6g1H+zEH
         eNXFdrgf6RU0A==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 216FnEuN2355990;
        Sun, 6 Feb 2022 07:49:14 -0800
From:   Walt Drummond <walt@drummond.us>
To:     agordeev@linux.ibm.com, arnd@arndb.de, benh@kernel.crashing.org,
        borntraeger@de.ibm.com, chris@zankel.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, hca@linux.ibm.com, deller@gmx.de,
        ink@jurassic.park.msu.ru, James.Bottomley@HansenPartnership.com,
        jirislaby@kernel.org, mattst88@gmail.com, jcmvbkbc@gmail.com,
        mpe@ellerman.id.au, paulus@samba.org, rth@twiddle.net,
        dalias@libc.org, tsbogend@alpha.franken.de, gor@linux.ibm.com,
        ysato@users.osdn.me
Cc:     linux-kernel@vger.kernel.org, ar@cs.msu.ru, walt@drummond.us,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v2 2/3] status: Add user space API definitions for VSTATUS, NOKERNINFO and TIOCSTAT
Date:   Sun,  6 Feb 2022 07:48:53 -0800
Message-Id: <20220206154856.2355838-3-walt@drummond.us>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206154856.2355838-1-walt@drummond.us>
References: <20220206154856.2355838-1-walt@drummond.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add definitions for the VSTATUS control character, and the NOKERNINFO
local control flag in the termios struct, and add an ioctl number for
the ioctl TIOCSTAT.  Also add a default VSTATUS character (Ctrl-T)
default valuses in termios.c_cc.  Do this for all architectures.

Signed-off-by: Walt Drummond <walt@drummond.us>
---
 arch/alpha/include/asm/termios.h         | 4 ++--
 arch/alpha/include/uapi/asm/ioctls.h     | 1 +
 arch/alpha/include/uapi/asm/termbits.h   | 2 ++
 arch/ia64/include/asm/termios.h          | 4 ++--
 arch/ia64/include/uapi/asm/termbits.h    | 2 ++
 arch/mips/include/asm/termios.h          | 4 ++--
 arch/mips/include/uapi/asm/ioctls.h      | 1 +
 arch/mips/include/uapi/asm/termbits.h    | 2 ++
 arch/parisc/include/asm/termios.h        | 4 ++--
 arch/parisc/include/uapi/asm/ioctls.h    | 1 +
 arch/parisc/include/uapi/asm/termbits.h  | 2 ++
 arch/powerpc/include/asm/termios.h       | 4 ++--
 arch/powerpc/include/uapi/asm/ioctls.h   | 2 ++
 arch/powerpc/include/uapi/asm/termbits.h | 2 ++
 arch/s390/include/asm/termios.h          | 4 ++--
 arch/sh/include/uapi/asm/ioctls.h        | 1 +
 arch/sparc/include/uapi/asm/ioctls.h     | 1 +
 arch/sparc/include/uapi/asm/termbits.h   | 2 ++
 arch/xtensa/include/uapi/asm/ioctls.h    | 1 +
 include/asm-generic/termios.h            | 4 ++--
 include/uapi/asm-generic/ioctls.h        | 1 +
 include/uapi/asm-generic/termbits.h      | 2 ++
 22 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios.h
index b7c77bb1bfd2..d28ddc649286 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -8,9 +8,9 @@
 	werase=^W	kill=^U		reprint=^R	sxtc=\0
 	intr=^C		quit=^\		susp=^Z		<OSF/1 VDSUSP>
 	start=^Q	stop=^S		lnext=^V	discard=^U
-	vmin=\1		vtime=\0
+	vmin=\1		vtime=\0        status=^T
 */
-#define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\025\001\000"
+#define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\025\001\000\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/uapi/asm/ioctls.h
index 971311605288..70fdeab2b5f2 100644
--- a/arch/alpha/include/uapi/asm/ioctls.h
+++ b/arch/alpha/include/uapi/asm/ioctls.h
@@ -124,5 +124,6 @@
 
 #define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
+#define TIOCSTAT	_IO('T', 0x5E)	/* display process group stats on tty */
 
 #endif /* _ASM_ALPHA_IOCTLS_H */
diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/uapi/asm/termbits.h
index 4575ba34a0ea..9a1b9aa92d29 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -70,6 +70,7 @@ struct ktermios {
 #define VDISCARD 15
 #define VMIN 16
 #define VTIME 17
+#define VSTATUS 18
 
 /* c_iflag bits */
 #define IGNBRK	0000001
@@ -203,6 +204,7 @@ struct ktermios {
 #define PENDIN	0x20000000
 #define IEXTEN	0x00000400
 #define EXTPROC	0x10000000
+#define NOKERNINFO 0x40000000
 
 /* Values for the ACTION argument to `tcflow'.  */
 #define	TCOOFF		0
diff --git a/arch/ia64/include/asm/termios.h b/arch/ia64/include/asm/termios.h
index 589c026444cc..40e83f9b6ead 100644
--- a/arch/ia64/include/asm/termios.h
+++ b/arch/ia64/include/asm/termios.h
@@ -15,9 +15,9 @@
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
+	eol2=\0         status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/arch/ia64/include/uapi/asm/termbits.h b/arch/ia64/include/uapi/asm/termbits.h
index 000a1a297c75..0b5fea00343b 100644
--- a/arch/ia64/include/uapi/asm/termbits.h
+++ b/arch/ia64/include/uapi/asm/termbits.h
@@ -67,6 +67,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 /* c_iflag bits */
 #define IGNBRK	0000001
@@ -189,6 +190,7 @@ struct ktermios {
 #define PENDIN	0040000
 #define IEXTEN	0100000
 #define EXTPROC	0200000
+#define NOKERNINFO 0400000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index bc29eeacc55a..04729018d882 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -17,9 +17,9 @@
  *	vmin=\1		vtime=\0	eol2=\0		swtc=\0
  *	start=^Q	stop=^S		susp=^Z		vdsusp=
  *	reprint=^R	discard=^U	werase=^W	lnext=^V
- *	eof=^D		eol=\0
+ *	eof=^D		eol=\0          status=^T
  */
-#define INIT_C_CC "\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0"
+#define INIT_C_CC "\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0\024"
 
 #include <linux/string.h>
 
diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
index 16aa8a766aec..f9ec28ac38db 100644
--- a/arch/mips/include/uapi/asm/ioctls.h
+++ b/arch/mips/include/uapi/asm/ioctls.h
@@ -115,5 +115,6 @@
 #define TIOCSERSETMULTI 0x5490 /* Set multiport config */
 #define TIOCMIWAIT	0x5491 /* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x5492 /* read serial port inline interrupt counts */
+#define TIOCSTAT	_IO('T', 0x93) /* display process group stats on tty */
 
 #endif /* __ASM_IOCTLS_H */
diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
index dfeffba729b7..a10be13a6f7b 100644
--- a/arch/mips/include/uapi/asm/termbits.h
+++ b/arch/mips/include/uapi/asm/termbits.h
@@ -78,6 +78,7 @@ struct ktermios {
 #define VLNEXT		15		/* Literal-next character [IEXTEN].  */
 #define VEOF		16		/* End-of-file character [ICANON].  */
 #define VEOL		17		/* End-of-line character [ICANON].  */
+#define VSTATUS         18
 
 /* c_iflag bits */
 #define IGNBRK	0000001		/* Ignore break condition.  */
@@ -205,6 +206,7 @@ struct ktermios {
 #define TOSTOP	0100000		/* Send SIGTTOU for background output.	*/
 #define ITOSTOP TOSTOP
 #define EXTPROC 0200000		/* External processing on pty */
+#define NOKERNINFO 0400000	/* Disable kernel status message */
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 #define TIOCSER_TEMT	0x01	/* Transmitter physically empty */
diff --git a/arch/parisc/include/asm/termios.h b/arch/parisc/include/asm/termios.h
index cded9dc90c1b..63c6c7edb0ff 100644
--- a/arch/parisc/include/asm/termios.h
+++ b/arch/parisc/include/asm/termios.h
@@ -9,9 +9,9 @@
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
+	eol2=\0         status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/arch/parisc/include/uapi/asm/ioctls.h b/arch/parisc/include/uapi/asm/ioctls.h
index 82d1148c6379..1ac156dd8209 100644
--- a/arch/parisc/include/uapi/asm/ioctls.h
+++ b/arch/parisc/include/uapi/asm/ioctls.h
@@ -80,6 +80,7 @@
 
 #define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
+#define TIOCSTAT	_IO('T', 0x5E)	/* display process group stats on tty */
 #define FIOQSIZE	0x5460	/* Get exact space used by quota */
 
 #define TIOCSTART	0x5461
diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/uapi/asm/termbits.h
index 40e920f8d683..b449d8ea1c00 100644
--- a/arch/parisc/include/uapi/asm/termbits.h
+++ b/arch/parisc/include/uapi/asm/termbits.h
@@ -58,6 +58,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 
 /* c_iflag bits */
@@ -182,6 +183,7 @@ struct ktermios {
 #define PENDIN  0040000
 #define IEXTEN  0100000
 #define EXTPROC	0200000
+#define NOKERNINFO 0400000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
diff --git a/arch/powerpc/include/asm/termios.h b/arch/powerpc/include/asm/termios.h
index 205de8f8a9d3..e5381c8f86f0 100644
--- a/arch/powerpc/include/asm/termios.h
+++ b/arch/powerpc/include/asm/termios.h
@@ -10,8 +10,8 @@
 
 #include <uapi/asm/termios.h>
 
-/*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^U  */
-#define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\025" 
+/*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^U  ^T */
+#define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\025\024"
 
 #include <asm-generic/termios-base.h>
 
diff --git a/arch/powerpc/include/uapi/asm/ioctls.h b/arch/powerpc/include/uapi/asm/ioctls.h
index 2c145da3b774..0a0755863500 100644
--- a/arch/powerpc/include/uapi/asm/ioctls.h
+++ b/arch/powerpc/include/uapi/asm/ioctls.h
@@ -120,4 +120,6 @@
 #define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
 
+#define TIOCSTAT	_IO('T', 0x5E)	/* display process group stats on tty */
+
 #endif	/* _ASM_POWERPC_IOCTLS_H */
diff --git a/arch/powerpc/include/uapi/asm/termbits.h b/arch/powerpc/include/uapi/asm/termbits.h
index ed18bc61f63d..50d787d95c91 100644
--- a/arch/powerpc/include/uapi/asm/termbits.h
+++ b/arch/powerpc/include/uapi/asm/termbits.h
@@ -62,6 +62,7 @@ struct ktermios {
 #define VSTOP		14
 #define VLNEXT		15
 #define VDISCARD	16
+#define VSTATUS		17
 
 /* c_iflag bits */
 #define IGNBRK	0000001
@@ -191,6 +192,7 @@ struct ktermios {
 #define PENDIN	0x20000000
 #define IEXTEN	0x00000400
 #define EXTPROC	0x10000000
+#define NOKERNINFO 0x40000000
 
 /* Values for the ACTION argument to `tcflow'.  */
 #define	TCOOFF		0
diff --git a/arch/s390/include/asm/termios.h b/arch/s390/include/asm/termios.h
index 46fa3020b41e..8d2017f4905d 100644
--- a/arch/s390/include/asm/termios.h
+++ b/arch/s390/include/asm/termios.h
@@ -14,9 +14,9 @@
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
+	eol2=\0         vstatus=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0\024"
 
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
diff --git a/arch/sh/include/uapi/asm/ioctls.h b/arch/sh/include/uapi/asm/ioctls.h
index 11866d4f60e1..fefef10922ec 100644
--- a/arch/sh/include/uapi/asm/ioctls.h
+++ b/arch/sh/include/uapi/asm/ioctls.h
@@ -112,5 +112,6 @@
 
 #define TIOCMIWAIT	_IO('T', 92) /* 0x545C */	/* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
+#define TIOCSTAT	_IO('T', 0x5F)	/* display process group stats on tty */
 
 #endif /* __ASM_SH_IOCTLS_H */
diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
index 7fd2f5873c9e..9819090bd850 100644
--- a/arch/sparc/include/uapi/asm/ioctls.h
+++ b/arch/sparc/include/uapi/asm/ioctls.h
@@ -124,6 +124,7 @@
 #define TIOCSERSETMULTI 0x545B /* Set multiport config */
 #define TIOCMIWAIT	0x545C /* Wait for change on serial input line(s) */
 #define TIOCGICOUNT	0x545D /* Read serial port inline interrupt counts */
+#define TIOCSTAT	_IO('T', 0x5E) /* Display process group stats on tty */
 
 /* Kernel definitions */
 
diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
index ce5ad5d0f105..b8441ce42278 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -80,6 +80,7 @@ struct ktermios {
 #define VDISCARD 13
 #define VWERASE  14
 #define VLNEXT   15
+#define VSTATUS  16
 
 /* Kernel keeps vmin/vtime separated, user apps assume vmin/vtime is
  * shared with eof/eol
@@ -224,6 +225,7 @@ struct ktermios {
 #define PENDIN	0x00004000
 #define IEXTEN	0x00008000
 #define EXTPROC	0x00010000
+#define NOKERNINFO 0x00020000
 
 /* modem lines */
 #define TIOCM_LE	0x001
diff --git a/arch/xtensa/include/uapi/asm/ioctls.h b/arch/xtensa/include/uapi/asm/ioctls.h
index 6d4a87296c95..f92fb8e5b2a5 100644
--- a/arch/xtensa/include/uapi/asm/ioctls.h
+++ b/arch/xtensa/include/uapi/asm/ioctls.h
@@ -126,5 +126,6 @@
 
 #define TIOCMIWAIT	_IO('T', 92) /* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
+#define TIOCSTAT	_IO('T', 0x5E)	/* display process group stats on tty */
 
 #endif /* _XTENSA_IOCTLS_H */
diff --git a/include/asm-generic/termios.h b/include/asm-generic/termios.h
index b1398d0d4a1d..9b080e1a82d4 100644
--- a/include/asm-generic/termios.h
+++ b/include/asm-generic/termios.h
@@ -10,9 +10,9 @@
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
+	eol2=\0         status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/include/uapi/asm-generic/ioctls.h b/include/uapi/asm-generic/ioctls.h
index cdc9f4ca8c27..02ceb990ce9b 100644
--- a/include/uapi/asm-generic/ioctls.h
+++ b/include/uapi/asm-generic/ioctls.h
@@ -97,6 +97,7 @@
 
 #define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
+#define TIOCSTAT        _IO('T', 0x5E)	/* display process group stats on tty */
 
 /*
  * Some arches already define FIOQSIZE due to a historical
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 2fbaf9ae89dd..6219803d6f4d 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -58,6 +58,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 /* c_iflag bits */
 #define IGNBRK	0000001
@@ -180,6 +181,7 @@ struct ktermios {
 #define PENDIN	0040000
 #define IEXTEN	0100000
 #define EXTPROC	0200000
+#define NOKERNINFO 0400000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
-- 
2.30.2

