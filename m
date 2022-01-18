Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158F7491E9E
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jan 2022 05:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbiAREpQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jan 2022 23:45:16 -0500
Received: from drummond.us ([74.95.14.229]:16092 "EHLO
        talisker.home.drummond.us" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235811AbiAREpM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Jan 2022 23:45:12 -0500
Received: from talisker.home.drummond.us (localhost [127.0.0.1])
        by talisker.home.drummond.us (8.15.2/8.15.2/Debian-20) with ESMTP id 20I4hT96765151;
        Mon, 17 Jan 2022 20:43:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=home.drummond.us;
        s=default; t=1642481009;
        bh=6C1Nxh/G1LHcPNysXj/fJXh166rXLAHU5n42b1e64wQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=4G3OGtM7wIQRfLPRPW3XYmlSpS8gyDGwKQf4p2CBg/dXRD48vQXdo7KU2PyMZwhnl
         JhiP9hOswVD7FM4vN3/5Rx1KqI2K8HtjW0BeL0bAijmpZyaiUVS3vrDDEw6D6vWGQk
         /IuNisQzE+6AuBbBPq+O1vy0Wgf84av9YJEerI1tBkFVfon2ua6fBOiBIcCw8JCAN9
         +HOljET2UblSMBKdZThLOFVzZcGFsGCwPWA4YYBEBujtUk7A0qO4Q7EoRp4iCYitis
         xdRQjo+J7FWM38b9Xe4TfrSUqFU0JKRznVGAlIy9vR5x10wq9nO+TRlsmKZ7AYJ2co
         yhpA43yYlMGgw==
Received: (from walt@localhost)
        by talisker.home.drummond.us (8.15.2/8.15.2/Submit) id 20I4hTrM765150;
        Mon, 17 Jan 2022 20:43:29 -0800
From:   Walt Drummond <walt@drummond.us>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Yoshinori Sato <ysato@users.osdn.me>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     ar@cs.msu.ru, linux-kernel@vger.kernel.org, walt@drummond.us,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Subject: [PATCH 2/3] vstatus: Add user space API definitions for VSTATUS, NOKERNINFO and TIOCSTAT
Date:   Mon, 17 Jan 2022 20:43:22 -0800
Message-Id: <20220118044323.765038-2-walt@drummond.us>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220118044323.765038-1-walt@drummond.us>
References: <20220118044323.765038-1-walt@drummond.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add definitions for the VSTATUS control character, and the NOKERNINFO
local control flag in the termios struct, and add an ioctl number for
the ioctl TIOCSTAT.  Also add a default VSTATUS character (Ctrl-T)
default valuses in termios.c_cc.  Do this for all architectures.

Signed-off-by: Walt Drummond <walt@drummond.us>
---
 arch/alpha/include/asm/termios.h         |  4 +--
 arch/alpha/include/uapi/asm/ioctls.h     |  1 +
 arch/alpha/include/uapi/asm/termbits.h   | 34 +++++++++++----------
 arch/ia64/include/asm/termios.h          |  4 +--
 arch/ia64/include/uapi/asm/termbits.h    | 34 +++++++++++----------
 arch/mips/include/asm/termios.h          |  4 +--
 arch/mips/include/uapi/asm/ioctls.h      |  1 +
 arch/mips/include/uapi/asm/termbits.h    | 36 +++++++++++-----------
 arch/parisc/include/asm/termios.h        |  4 +--
 arch/parisc/include/uapi/asm/ioctls.h    |  1 +
 arch/parisc/include/uapi/asm/termbits.h  | 34 +++++++++++----------
 arch/powerpc/include/asm/termios.h       |  4 +--
 arch/powerpc/include/uapi/asm/ioctls.h   |  2 ++
 arch/powerpc/include/uapi/asm/termbits.h | 34 +++++++++++----------
 arch/s390/include/asm/termios.h          |  4 +--
 arch/sh/include/uapi/asm/ioctls.h        |  1 +
 arch/sparc/include/uapi/asm/ioctls.h     |  1 +
 arch/sparc/include/uapi/asm/termbits.h   | 38 +++++++++++++-----------
 arch/xtensa/include/uapi/asm/ioctls.h    |  1 +
 include/asm-generic/termios.h            |  4 +--
 include/uapi/asm-generic/ioctls.h        |  1 +
 include/uapi/asm-generic/termbits.h      | 34 +++++++++++----------
 22 files changed, 152 insertions(+), 129 deletions(-)

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
index 971311605288..4a092b917fc1 100644
--- a/arch/alpha/include/uapi/asm/ioctls.h
+++ b/arch/alpha/include/uapi/asm/ioctls.h
@@ -124,5 +124,6 @@
 
 #define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
+#define TIOCSTAT	0x545E	/* display process group stats on tty */
 
 #endif /* _ASM_ALPHA_IOCTLS_H */
diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/uapi/asm/termbits.h
index 4575ba34a0ea..c429e60e0b64 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -70,6 +70,7 @@ struct ktermios {
 #define VDISCARD 15
 #define VMIN 16
 #define VTIME 17
+#define VSTATUS 18
 
 /* c_iflag bits */
 #define IGNBRK	0000001
@@ -187,22 +188,23 @@ struct ktermios {
 #define IBSHIFT	16
 
 /* c_lflag bits */
-#define ISIG	0x00000080
-#define ICANON	0x00000100
-#define XCASE	0x00004000
-#define ECHO	0x00000008
-#define ECHOE	0x00000002
-#define ECHOK	0x00000004
-#define ECHONL	0x00000010
-#define NOFLSH	0x80000000
-#define TOSTOP	0x00400000
-#define ECHOCTL	0x00000040
-#define ECHOPRT	0x00000020
-#define ECHOKE	0x00000001
-#define FLUSHO	0x00800000
-#define PENDIN	0x20000000
-#define IEXTEN	0x00000400
-#define EXTPROC	0x10000000
+#define ISIG	   0x00000080
+#define ICANON	   0x00000100
+#define XCASE	   0x00004000
+#define ECHO	   0x00000008
+#define ECHOE	   0x00000002
+#define ECHOK	   0x00000004
+#define ECHONL	   0x00000010
+#define NOFLSH	   0x80000000
+#define TOSTOP	   0x00400000
+#define ECHOCTL	   0x00000040
+#define ECHOPRT	   0x00000020
+#define ECHOKE	   0x00000001
+#define FLUSHO	   0x00800000
+#define PENDIN	   0x20000000
+#define IEXTEN	   0x00000400
+#define EXTPROC	   0x10000000
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
index 000a1a297c75..2b6e943a89c6 100644
--- a/arch/ia64/include/uapi/asm/termbits.h
+++ b/arch/ia64/include/uapi/asm/termbits.h
@@ -67,6 +67,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 /* c_iflag bits */
 #define IGNBRK	0000001
@@ -173,22 +174,23 @@ struct ktermios {
 #define IBSHIFT	16		/* Shift from CBAUD to CIBAUD */
 
 /* c_lflag bits */
-#define ISIG	0000001
-#define ICANON	0000002
-#define XCASE	0000004
-#define ECHO	0000010
-#define ECHOE	0000020
-#define ECHOK	0000040
-#define ECHONL	0000100
-#define NOFLSH	0000200
-#define TOSTOP	0000400
-#define ECHOCTL	0001000
-#define ECHOPRT	0002000
-#define ECHOKE	0004000
-#define FLUSHO	0010000
-#define PENDIN	0040000
-#define IEXTEN	0100000
-#define EXTPROC	0200000
+#define ISIG	   0000001
+#define ICANON	   0000002
+#define XCASE	   0000004
+#define ECHO	   0000010
+#define ECHOE	   0000020
+#define ECHOK	   0000040
+#define ECHONL	   0000100
+#define NOFLSH	   0000200
+#define TOSTOP	   0000400
+#define ECHOCTL	   0001000
+#define ECHOPRT	   0002000
+#define ECHOKE	   0004000
+#define FLUSHO	   0010000
+#define PENDIN	   0040000
+#define IEXTEN	   0100000
+#define EXTPROC	   0200000
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
index 16aa8a766aec..dff4e9a01336 100644
--- a/arch/mips/include/uapi/asm/ioctls.h
+++ b/arch/mips/include/uapi/asm/ioctls.h
@@ -115,5 +115,6 @@
 #define TIOCSERSETMULTI 0x5490 /* Set multiport config */
 #define TIOCMIWAIT	0x5491 /* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x5492 /* read serial port inline interrupt counts */
+#define TIOCSTAT	0x5493 /* display process group stats on tty */
 
 #endif /* __ASM_IOCTLS_H */
diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
index dfeffba729b7..402d44c2aa9c 100644
--- a/arch/mips/include/uapi/asm/termbits.h
+++ b/arch/mips/include/uapi/asm/termbits.h
@@ -78,6 +78,7 @@ struct ktermios {
 #define VLNEXT		15		/* Literal-next character [IEXTEN].  */
 #define VEOF		16		/* End-of-file character [ICANON].  */
 #define VEOL		17		/* End-of-line character [ICANON].  */
+#define VSTATUS         18
 
 /* c_iflag bits */
 #define IGNBRK	0000001		/* Ignore break condition.  */
@@ -188,23 +189,24 @@ struct ktermios {
 #define IBSHIFT 16		/* Shift from CBAUD to CIBAUD */
 
 /* c_lflag bits */
-#define ISIG	0000001		/* Enable signals.  */
-#define ICANON	0000002		/* Do erase and kill processing.  */
-#define XCASE	0000004
-#define ECHO	0000010		/* Enable echo.	 */
-#define ECHOE	0000020		/* Visual erase for ERASE.  */
-#define ECHOK	0000040		/* Echo NL after KILL.	*/
-#define ECHONL	0000100		/* Echo NL even if ECHO is off.	 */
-#define NOFLSH	0000200		/* Disable flush after interrupt.  */
-#define IEXTEN	0000400		/* Enable DISCARD and LNEXT.  */
-#define ECHOCTL 0001000		/* Echo control characters as ^X.  */
-#define ECHOPRT 0002000		/* Hardcopy visual erase.  */
-#define ECHOKE	0004000		/* Visual erase for KILL.  */
-#define FLUSHO	0020000
-#define PENDIN	0040000		/* Retype pending input (state).  */
-#define TOSTOP	0100000		/* Send SIGTTOU for background output.	*/
-#define ITOSTOP TOSTOP
-#define EXTPROC 0200000		/* External processing on pty */
+#define ISIG	   0000001	/* Enable signals.  */
+#define ICANON	   0000002	/* Do erase and kill processing.  */
+#define XCASE	   0000004
+#define ECHO	   0000010	/* Enable echo.	 */
+#define ECHOE	   0000020	/* Visual erase for ERASE.  */
+#define ECHOK	   0000040	/* Echo NL after KILL.	*/
+#define ECHONL	   0000100	/* Echo NL even if ECHO is off.	 */
+#define NOFLSH	   0000200	/* Disable flush after interrupt.  */
+#define IEXTEN	   0000400	/* Enable DISCARD and LNEXT.  */
+#define ECHOCTL    0001000	/* Echo control characters as ^X.  */
+#define ECHOPRT    0002000	/* Hardcopy visual erase.  */
+#define ECHOKE	   0004000	/* Visual erase for KILL.  */
+#define FLUSHO	   0020000
+#define PENDIN	   0040000	/* Retype pending input (state).  */
+#define TOSTOP	   0100000	/* Send SIGTTOU for background output.	*/
+#define ITOSTOP    TOSTOP
+#define EXTPROC    0200000	/* External processing on pty */
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
index 82d1148c6379..875db5ff080a 100644
--- a/arch/parisc/include/uapi/asm/ioctls.h
+++ b/arch/parisc/include/uapi/asm/ioctls.h
@@ -80,6 +80,7 @@
 
 #define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
+#define TIOCSTAT	0x545E	/* display process group stats on tty */
 #define FIOQSIZE	0x5460	/* Get exact space used by quota */
 
 #define TIOCSTART	0x5461
diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/uapi/asm/termbits.h
index 40e920f8d683..384df7348b53 100644
--- a/arch/parisc/include/uapi/asm/termbits.h
+++ b/arch/parisc/include/uapi/asm/termbits.h
@@ -58,6 +58,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 
 /* c_iflag bits */
@@ -166,22 +167,23 @@ struct ktermios {
 
 
 /* c_lflag bits */
-#define ISIG    0000001
-#define ICANON  0000002
-#define XCASE   0000004
-#define ECHO    0000010
-#define ECHOE   0000020
-#define ECHOK   0000040
-#define ECHONL  0000100
-#define NOFLSH  0000200
-#define TOSTOP  0000400
-#define ECHOCTL 0001000
-#define ECHOPRT 0002000
-#define ECHOKE  0004000
-#define FLUSHO  0010000
-#define PENDIN  0040000
-#define IEXTEN  0100000
-#define EXTPROC	0200000
+#define ISIG       0000001
+#define ICANON     0000002
+#define XCASE      0000004
+#define ECHO       0000010
+#define ECHOE      0000020
+#define ECHOK      0000040
+#define ECHONL     0000100
+#define NOFLSH     0000200
+#define TOSTOP     0000400
+#define ECHOCTL    0001000
+#define ECHOPRT    0002000
+#define ECHOKE     0004000
+#define FLUSHO     0010000
+#define PENDIN     0040000
+#define IEXTEN     0100000
+#define EXTPROC	   0200000
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
index 2c145da3b774..5fc2449036a7 100644
--- a/arch/powerpc/include/uapi/asm/ioctls.h
+++ b/arch/powerpc/include/uapi/asm/ioctls.h
@@ -120,4 +120,6 @@
 #define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
 
+#define TIOCSTAT	0x545E	/* display process group stats on tty */
+
 #endif	/* _ASM_POWERPC_IOCTLS_H */
diff --git a/arch/powerpc/include/uapi/asm/termbits.h b/arch/powerpc/include/uapi/asm/termbits.h
index ed18bc61f63d..ffd0e50d680c 100644
--- a/arch/powerpc/include/uapi/asm/termbits.h
+++ b/arch/powerpc/include/uapi/asm/termbits.h
@@ -62,6 +62,7 @@ struct ktermios {
 #define VSTOP		14
 #define VLNEXT		15
 #define VDISCARD	16
+#define VSTATUS		17
 
 /* c_iflag bits */
 #define IGNBRK	0000001
@@ -175,22 +176,23 @@ struct ktermios {
 #define CRTSCTS	  020000000000		/* flow control */
 
 /* c_lflag bits */
-#define ISIG	0x00000080
-#define ICANON	0x00000100
-#define XCASE	0x00004000
-#define ECHO	0x00000008
-#define ECHOE	0x00000002
-#define ECHOK	0x00000004
-#define ECHONL	0x00000010
-#define NOFLSH	0x80000000
-#define TOSTOP	0x00400000
-#define ECHOCTL	0x00000040
-#define ECHOPRT	0x00000020
-#define ECHOKE	0x00000001
-#define FLUSHO	0x00800000
-#define PENDIN	0x20000000
-#define IEXTEN	0x00000400
-#define EXTPROC	0x10000000
+#define ISIG	   0x00000080
+#define ICANON	   0x00000100
+#define XCASE	   0x00004000
+#define ECHO	   0x00000008
+#define ECHOE	   0x00000002
+#define ECHOK	   0x00000004
+#define ECHONL	   0x00000010
+#define NOFLSH	   0x80000000
+#define TOSTOP	   0x00400000
+#define ECHOCTL	   0x00000040
+#define ECHOPRT	   0x00000020
+#define ECHOKE	   0x00000001
+#define FLUSHO	   0x00800000
+#define PENDIN	   0x20000000
+#define IEXTEN	   0x00000400
+#define EXTPROC	   0x10000000
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
index 11866d4f60e1..a17d6eb802a2 100644
--- a/arch/sh/include/uapi/asm/ioctls.h
+++ b/arch/sh/include/uapi/asm/ioctls.h
@@ -112,5 +112,6 @@
 
 #define TIOCMIWAIT	_IO('T', 92) /* 0x545C */	/* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
+#define TIOCSTAT	0x545F	/* display process group stats on tty */
 
 #endif /* __ASM_SH_IOCTLS_H */
diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
index 7fd2f5873c9e..2207627ffcd2 100644
--- a/arch/sparc/include/uapi/asm/ioctls.h
+++ b/arch/sparc/include/uapi/asm/ioctls.h
@@ -124,6 +124,7 @@
 #define TIOCSERSETMULTI 0x545B /* Set multiport config */
 #define TIOCMIWAIT	0x545C /* Wait for change on serial input line(s) */
 #define TIOCGICOUNT	0x545D /* Read serial port inline interrupt counts */
+#define TIOCSTAT	0x545E /* Display process group stats on tty */
 
 /* Kernel definitions */
 
diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
index ce5ad5d0f105..ec60e792a125 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -80,6 +80,7 @@ struct ktermios {
 #define VDISCARD 13
 #define VWERASE  14
 #define VLNEXT   15
+#define VSTATUS  16
 
 /* Kernel keeps vmin/vtime separated, user apps assume vmin/vtime is
  * shared with eof/eol
@@ -206,24 +207,25 @@ struct ktermios {
 
 #define IBSHIFT	  16		/* Shift from CBAUD to CIBAUD */
 
-/* c_lflag bits */
-#define ISIG	0x00000001
-#define ICANON	0x00000002
-#define XCASE	0x00000004
-#define ECHO	0x00000008
-#define ECHOE	0x00000010
-#define ECHOK	0x00000020
-#define ECHONL	0x00000040
-#define NOFLSH	0x00000080
-#define TOSTOP	0x00000100
-#define ECHOCTL	0x00000200
-#define ECHOPRT	0x00000400
-#define ECHOKE	0x00000800
-#define DEFECHO 0x00001000  /* SUNOS thing, what is it? */
-#define FLUSHO	0x00002000
-#define PENDIN	0x00004000
-#define IEXTEN	0x00008000
-#define EXTPROC	0x00010000
+/* c_lflag bits    */
+#define ISIG	   0x00000001
+#define ICANON	   0x00000002
+#define XCASE	   0x00000004
+#define ECHO	   0x00000008
+#define ECHOE	   0x00000010
+#define ECHOK	   0x00000020
+#define ECHONL	   0x00000040
+#define NOFLSH	   0x00000080
+#define TOSTOP	   0x00000100
+#define ECHOCTL	   0x00000200
+#define ECHOPRT	   0x00000400
+#define ECHOKE	   0x00000800
+#define DEFECHO    0x00001000  /* SUNOS thing, what is it? */
+#define FLUSHO	   0x00002000
+#define PENDIN	   0x00004000
+#define IEXTEN	   0x00008000
+#define EXTPROC	   0x00010000
+#define NOKERNINFO 0x00020000
 
 /* modem lines */
 #define TIOCM_LE	0x001
diff --git a/arch/xtensa/include/uapi/asm/ioctls.h b/arch/xtensa/include/uapi/asm/ioctls.h
index 6d4a87296c95..7c0198877bcf 100644
--- a/arch/xtensa/include/uapi/asm/ioctls.h
+++ b/arch/xtensa/include/uapi/asm/ioctls.h
@@ -126,5 +126,6 @@
 
 #define TIOCMIWAIT	_IO('T', 92) /* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
+#define TIOCSTAT	0x545E	/* display process group stats on tty */
 
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
index cdc9f4ca8c27..eafb662d6a0e 100644
--- a/include/uapi/asm-generic/ioctls.h
+++ b/include/uapi/asm-generic/ioctls.h
@@ -97,6 +97,7 @@
 
 #define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
+#define TIOCSTAT        0x545E	/* display process group stats on tty */
 
 /*
  * Some arches already define FIOQSIZE due to a historical
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 2fbaf9ae89dd..cb4e9c6d629f 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -58,6 +58,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 /* c_iflag bits */
 #define IGNBRK	0000001
@@ -164,22 +165,23 @@ struct ktermios {
 #define IBSHIFT	  16		/* Shift from CBAUD to CIBAUD */
 
 /* c_lflag bits */
-#define ISIG	0000001
-#define ICANON	0000002
-#define XCASE	0000004
-#define ECHO	0000010
-#define ECHOE	0000020
-#define ECHOK	0000040
-#define ECHONL	0000100
-#define NOFLSH	0000200
-#define TOSTOP	0000400
-#define ECHOCTL	0001000
-#define ECHOPRT	0002000
-#define ECHOKE	0004000
-#define FLUSHO	0010000
-#define PENDIN	0040000
-#define IEXTEN	0100000
-#define EXTPROC	0200000
+#define ISIG	   0000001
+#define ICANON	   0000002
+#define XCASE	   0000004
+#define ECHO	   0000010
+#define ECHOE	   0000020
+#define ECHOK	   0000040
+#define ECHONL	   0000100
+#define NOFLSH	   0000200
+#define TOSTOP	   0000400
+#define ECHOCTL	   0001000
+#define ECHOPRT	   0002000
+#define ECHOKE	   0004000
+#define FLUSHO	   0010000
+#define PENDIN	   0040000
+#define IEXTEN	   0100000
+#define EXTPROC	   0200000
+#define NOKERNINFO 0400000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
-- 
2.30.2

