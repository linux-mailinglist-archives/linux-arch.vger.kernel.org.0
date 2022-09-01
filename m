Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FDD5A9DBE
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 19:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiIARIC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 13:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbiIARIB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 13:08:01 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E499A97A;
        Thu,  1 Sep 2022 10:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u8/36Ys6ceTULsI88M9VSpOe7jLEiHdbiJrWxxzobmY=; b=eQsXsJKMeg6xOhqCYJgv/fIHm2
        KP6X8QJFTwgfN5Aci24BpP+dYuqUbLQr7eEQBxq3ySf0NsnYDB/lT+gFW4YKLLoattPvsv3zZBT1n
        zeV8r4nPBTRUu9hBB+85VK4AU9GWMgbH2sLRfkgPG4JI7XM1OmJOJ81bcX/+BWlm5ejm6QDVgdR5r
        oZJKeA70gpSrmUXtp0oZNxJqYaDDHu83Vo6h8nS/Srhx8ZTBOYokw5zqgzIzDssCilTLN8JS2gKq0
        KUxdtzg6YSxdYujl6wOw6/mYGSJtNzMKX60GIN/VtkJKqQ25v3ajSijwauIGDBMJ1Mo+vT9U5OuZG
        sF8xq5Ng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTnfY-00B2oG-Fv;
        Thu, 01 Sep 2022 17:07:56 +0000
Date:   Thu, 1 Sep 2022 18:07:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] make generic INIT_C_CC a bit more generic
Message-ID: <YxDm7M6M91gC2RPL@ZenIV>
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

From 54bdf984b1bb317f732a49ff8c1db59f8534de4f Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sun, 9 Sep 2018 17:57:42 -0400
Subject: [PATCH v3 4/6] make generic INIT_C_CC a bit more generic

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
index 9cc784d0a83c..3894fd92c508 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -5,12 +5,4 @@
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
 #endif	/* _ALPHA_TERMIOS_H */
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
index 7eb3598c109d..8a53141ab44a 100644
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
 
 int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
-- 
2.30.2

