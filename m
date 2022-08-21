Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D3759B128
	for <lists+linux-arch@lfdr.de>; Sun, 21 Aug 2022 03:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiHUBCo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 21:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiHUBCm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 21:02:42 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D7F22B00;
        Sat, 20 Aug 2022 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=L8BNIBwkcFzYI2yCB9iLw8Rvl4EWJ17MZfSkWSBfAyI=; b=cOB6xT6bM6FH9QwoZ/bEh3Y4Lw
        g9BjsJMHRlU2q3T7b1ZZWqiuqjJltkVb8xhkl+JgNjMJS5mVEexIzJM8EhKtwjcw3HjMA1V2P2tM0
        TKgyG6RenBWK98kxcYdCDrsxkUUMEG+5u7nN6tXrTuuqSNQOr7qfhnrGZiuY52cmQMiElnuqA310t
        mxRb+MkrXYWyt2EwxBki4H6rL7L8BwM2yY8mYtz6wuP52MsEkU5e5xk1XmOZ3V6OaZhyhBwotnDYz
        LRGj9qisf9QRY8A1D2ffvzDIT/qfza1q+sXLFCQQbbt9J8W/KF668wgy9LFSFX7cZm3loJqsVWJq3
        J/IDKGSA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPZMO-006WJ0-4j;
        Sun, 21 Aug 2022 01:02:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 5/8] termios: consolidate values for VDISCARD in INIT_C_CC
Date:   Sun, 21 Aug 2022 02:02:36 +0100
Message-Id: <20220821010239.1554132-5-viro@zeniv.linux.org.uk>
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

On old systems it used to be ^O.  Linux had never actually used
the value, but INIT_C_CC (on i386) did initialize it to ^O;
unfortunately, it had a typo in the comment claiming that to be
^U.  Most of the architectures copied the (correct) definition
along with mistaken comment.  alpha, powerpc and sparc tried
to make the definition match comment.

However, util-linux still resets it to ^O on any architecture,
^O is the historical value, kernel ignores it anyway and finally,
Linus said "Just change everybody to do the same, nobody cares
about VDISCARD".

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/termios.h   | 4 ++--
 arch/mips/include/asm/termios.h    | 2 +-
 arch/powerpc/include/asm/termios.h | 4 ++--
 arch/sparc/include/asm/termios.h   | 4 ++--
 include/linux/termios_internal.h   | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios.h
index 17b109859e05..9cc784d0a83c 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -8,9 +8,9 @@
 /*	eof=^D		eol=\0		eol2=\0		erase=del
 	werase=^W	kill=^U		reprint=^R	sxtc=\0
 	intr=^C		quit=^\		susp=^Z		<OSF/1 VDSUSP>
-	start=^Q	stop=^S		lnext=^V	discard=^U
+	start=^Q	stop=^S		lnext=^V	discard=^O
 	vmin=\1		vtime=\0
 */
-#define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\025\001\000"
+#define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\017\001\000"
 
 #endif	/* _ALPHA_TERMIOS_H */
diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index dbb62330b7a4..059c800afaa1 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -16,7 +16,7 @@
  *	intr=^C		quit=^\		erase=del	kill=^U
  *	vmin=\1		vtime=\0	eol2=\0		swtc=\0
  *	start=^Q	stop=^S		susp=^Z		vdsusp=
- *	reprint=^R	discard=^U	werase=^W	lnext=^V
+ *	reprint=^R	discard=^O	werase=^W	lnext=^V
  *	eof=^D		eol=\0
  */
 #define INIT_C_CC "\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0"
diff --git a/arch/powerpc/include/asm/termios.h b/arch/powerpc/include/asm/termios.h
index 5c003322fe29..e18a05a6ed34 100644
--- a/arch/powerpc/include/asm/termios.h
+++ b/arch/powerpc/include/asm/termios.h
@@ -10,7 +10,7 @@
 
 #include <uapi/asm/termios.h>
 
-/*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^U  */
-#define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\025" 
+/*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^O  */
+#define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\017"
 
 #endif	/* _ASM_POWERPC_TERMIOS_H */
diff --git a/arch/sparc/include/asm/termios.h b/arch/sparc/include/asm/termios.h
index bafd7768f309..60f90465fc12 100644
--- a/arch/sparc/include/asm/termios.h
+++ b/arch/sparc/include/asm/termios.h
@@ -9,9 +9,9 @@
 /*	intr=^C		quit=^\		erase=del	kill=^U
 	eof=^D		eol=\0		eol2=\0		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		dsusp=^Y
-	reprint=^R	discard=^U	werase=^W	lnext=^V
+	reprint=^R	discard=^O	werase=^W	lnext=^V
 	vmin=\1         vtime=\0
 */
-#define INIT_C_CC "\003\034\177\025\004\000\000\000\021\023\032\031\022\025\027\026\001"
+#define INIT_C_CC "\003\034\177\025\004\000\000\000\021\023\032\031\022\017\027\026\001"
 
 #endif /* _SPARC_TERMIOS_H */
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
index 103ca0370948..7eb3598c109d 100644
--- a/include/linux/termios_internal.h
+++ b/include/linux/termios_internal.h
@@ -9,7 +9,7 @@
 /*	intr=^C		quit=^\		erase=del	kill=^U
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
-	reprint=^R	discard=^U	werase=^W	lnext=^V
+	reprint=^R	discard=^O	werase=^W	lnext=^V
 	eol2=\0
 */
 #define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
-- 
2.30.2

