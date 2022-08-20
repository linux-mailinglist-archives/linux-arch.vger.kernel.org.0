Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF2759AAF1
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 05:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243080AbiHTDhi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 23:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbiHTDhf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 23:37:35 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083419C8DC;
        Fri, 19 Aug 2022 20:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HaKQMTsdiwizVwLG1iEascfVi97JDrK/fRrewXmlp/o=; b=lQW364VnnPuKi6Co+i0iV2X85V
        38N+g7lyaj0wneNYmUF1/pF7mgaeWJ0AVA2W+luP9nDiZRfe3uywqz0OkOQdnwKmLwUOQOOsNHnqc
        5IDcfh7KQRaD7rNQVgGrUS4XpxnZpg2WdPpFJbDTB7oAv553dvbJBtsxtwI6OnFtG3TyNONpfBU7l
        RutGri8vlCx7Uqv1JbT/8HqJSQ771kiHbIcw4+IL1bRj1eb3nTfCSSwdADejAPLcJXEd5VmKOFjmv
        w/whd7ix92x1nl99OxqtJRbLeZSMwu1M3FiCZ4X+XnW9onY47Am6U+Z8C4/geWxfCshKcOPJsy15p
        FmxsdXOA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPFIh-006Hnx-FO;
        Sat, 20 Aug 2022 03:37:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5/7] make generic INIT_C_CC a bit more generic
Date:   Sat, 20 Aug 2022 04:37:28 +0100
Message-Id: <20220820033730.1498392-5-viro@zeniv.linux.org.uk>
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

turn it into an array initializer; then alpha, mips and powerpc
variants fold into it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/termios.h   |  8 --------
 arch/mips/include/asm/termios.h    |  9 ---------
 arch/powerpc/include/asm/termios.h |  3 ---
 include/linux/termios_internal.h   | 15 ++++++++++++++-
 4 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios.h
index 9028c533e125..c676067a1da7 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -5,14 +5,6 @@
 #include <linux/uaccess.h>
 #include <uapi/asm/termios.h>
 
-/*	eof=^D		eol=\0		eol2=\0		erase=del
-	werase=^W	kill=^U		reprint=^R	sxtc=\0
-	intr=^C		quit=^\		susp=^Z		<OSF/1 VDSUSP>
-	start=^Q	stop=^S		lnext=^V	discard=^O
-	vmin=\1		vtime=\0
-*/
-#define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\017\001\000"
-
 /*
  * Translate a "termio" structure into a "termios". Ugh.
  */
diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index 059c800afaa1..12bc56857bf1 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -12,13 +12,4 @@
 #include <linux/uaccess.h>
 #include <uapi/asm/termios.h>
 
-/*
- *	intr=^C		quit=^\		erase=del	kill=^U
- *	vmin=\1		vtime=\0	eol2=\0		swtc=\0
- *	start=^Q	stop=^S		susp=^Z		vdsusp=
- *	reprint=^R	discard=^O	werase=^W	lnext=^V
- *	eof=^D		eol=\0
- */
-#define INIT_C_CC "\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0"
-
 #endif /* _ASM_TERMIOS_H */
diff --git a/arch/powerpc/include/asm/termios.h b/arch/powerpc/include/asm/termios.h
index e18a05a6ed34..83794533f607 100644
--- a/arch/powerpc/include/asm/termios.h
+++ b/arch/powerpc/include/asm/termios.h
@@ -10,7 +10,4 @@
 
 #include <uapi/asm/termios.h>
 
-/*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^O  */
-#define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\017"
-
 #endif	/* _ASM_POWERPC_TERMIOS_H */
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
index 14a3f64117fe..d525a8dc2045 100644
--- a/include/linux/termios_internal.h
+++ b/include/linux/termios_internal.h
@@ -12,7 +12,20 @@
 	reprint=^R	discard=^O	werase=^W	lnext=^V
 	eol2=\0
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC {		\
+	[VINTR] = 'C'-0x40,	\
+	[VQUIT] = '\\'-0x40,	\
+	[VERASE] = '\177',	\
+	[VKILL] = 'U'-0x40,	\
+	[VEOF] = 'D'-0x40,	\
+	[VSTART] = 'Q'-0x40,	\
+	[VSTOP] = 'S'-0x40,	\
+	[VSUSP] = 'Z'-0x40,	\
+	[VREPRINT] = 'R'-0x40,	\
+	[VDISCARD] = 'O'-0x40,	\
+	[VWERASE] = 'W'-0x40,	\
+	[VLNEXT] = 'V'-0x40,	\
+	[VMIN] = 1 }
 #endif
 
 #ifndef user_termio_to_kernel_termios
-- 
2.30.2

