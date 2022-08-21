Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F3C59B121
	for <lists+linux-arch@lfdr.de>; Sun, 21 Aug 2022 03:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiHUBCo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 21:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbiHUBCm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 21:02:42 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E6422B2D;
        Sat, 20 Aug 2022 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IleKUHG9mpoSqd8lMHIHd7V2lYfYBNr2M+M88IbC77s=; b=pMJVFs9laDHnT1nxvHPbYkZubh
        t1togvT5FLl9B74ul3Dz7GBbRiTeeExlzAMcfoEGM9pYrZhmc08mCNVTGLT5HVuFaRVVGciLr4F4/
        /7w1lK9usXYudjg4NzEWJMtsP55Uk2TBL9dbv8DJ2Y27xBATDtZ48HyF/7Z1f7jEWTtm6TydccGnW
        cUCun9/ki+Qf5lAJDpnQM+laZvhacOxP33bjCfhTph4kSzFcjcfInkkDQaidui1jkxcsONgCr1utC
        bXwVcNUoyj2S9yK6iBz7RKYpvNS5Uy/tRaH2GDi7Us/vEcA3W3wIvnt1JHLpf+mhskhDV9aeTNBfL
        ++kiFbyA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPZMO-006WJ8-FX;
        Sun, 21 Aug 2022 01:02:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 7/8] termios: convert the last (sparc) INIT_C_CC to array
Date:   Sun, 21 Aug 2022 02:02:38 +0100
Message-Id: <20220821010239.1554132-7-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/include/asm/termios.h |  9 ---------
 include/linux/termios_internal.h | 10 ++++++++--
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/include/asm/termios.h b/arch/sparc/include/asm/termios.h
index 60f90465fc12..1b85721f4e6b 100644
--- a/arch/sparc/include/asm/termios.h
+++ b/arch/sparc/include/asm/termios.h
@@ -5,13 +5,4 @@
 #include <uapi/asm/termios.h>
 #include <linux/uaccess.h>
 
-
-/*	intr=^C		quit=^\		erase=del	kill=^U
-	eof=^D		eol=\0		eol2=\0		sxtc=\0
-	start=^Q	stop=^S		susp=^Z		dsusp=^Y
-	reprint=^R	discard=^O	werase=^W	lnext=^V
-	vmin=\1         vtime=\0
-*/
-#define INIT_C_CC "\003\034\177\025\004\000\000\000\021\023\032\031\022\017\027\026\001"
-
 #endif /* _SPARC_TERMIOS_H */
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
index 8a53141ab44a..d77f29e5e2b7 100644
--- a/include/linux/termios_internal.h
+++ b/include/linux/termios_internal.h
@@ -5,13 +5,19 @@
 #include <linux/uaccess.h>
 #include <asm/termios.h>
 
-#ifndef INIT_C_CC
 /*	intr=^C		quit=^\		erase=del	kill=^U
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^O	werase=^W	lnext=^V
 	eol2=\0
 */
+
+#ifdef VDSUSP
+#define INIT_C_CC_VDSUSP_EXTRA [VDSUSP] = 'Y'-0x40,
+#else
+#define INIT_C_CC_VDSUSP_EXTRA
+#endif
+
 #define INIT_C_CC {		\
 	[VINTR] = 'C'-0x40,	\
 	[VQUIT] = '\\'-0x40,	\
@@ -25,8 +31,8 @@
 	[VDISCARD] = 'O'-0x40,	\
 	[VWERASE] = 'W'-0x40,	\
 	[VLNEXT] = 'V'-0x40,	\
+	INIT_C_CC_VDSUSP_EXTRA	\
 	[VMIN] = 1 }
-#endif
 
 int user_termio_to_kernel_termios(struct ktermios *, struct termio __user *);
 int kernel_termios_to_user_termio(struct termio __user *, struct ktermios *);
-- 
2.30.2

