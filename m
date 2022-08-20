Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF9A59AAF2
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 05:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbiHTDhl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 23:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240693AbiHTDhg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 23:37:36 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF8D9D660;
        Fri, 19 Aug 2022 20:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=olAv1q9wvINTOpgKpvEbjbsQ4p48TW+gxE9t+NMEqNE=; b=wnMJrenKy2/49h40a6rLIlzqt+
        oPT1PzCwLNA6NXRKnNfhAjnASwYr9tihMcHvyZ4B/YptAiuNdGenixjgmSJdDJM8zqNee/YaYxsSk
        yab8VZURLolPmQUUuPhWJcmqRit31VvCWknAiHkv6zWhnjTWxqhi3zWCvTYjnOJ+Wy2YdrkawzCYO
        s8TX9YdrMAzwOcV5QYSBGJfJSZJkpKkhcfTDnpCQfb4qrsjT6dMrDL6AKY00vLbBIw5YbOiYUf/nB
        UzZasB5lF318iW3BI+XwJhLtrsGW7chdDO+wX8QQCyIHPm8y8PvQ9vkqLxckwJz33PpFplFjTBBNd
        NRZPnJMw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPFIh-006Ho2-OP;
        Sat, 20 Aug 2022 03:37:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6/7] termios: convert the last (sparc) INIT_C_CC to array
Date:   Sat, 20 Aug 2022 04:37:29 +0100
Message-Id: <20220820033730.1498392-6-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/include/asm/termios.h |  8 --------
 include/linux/termios_internal.h | 10 ++++++++--
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/termios.h b/arch/sparc/include/asm/termios.h
index 6ad37199bee7..ba4b7517a3bb 100644
--- a/arch/sparc/include/asm/termios.h
+++ b/arch/sparc/include/asm/termios.h
@@ -17,14 +17,6 @@
 #define _VMIN	4
 #define _VTIME	5
 
-/*	intr=^C		quit=^\		erase=del	kill=^U
-	eof=^D		eol=\0		eol2=\0		sxtc=\0
-	start=^Q	stop=^S		susp=^Z		dsusp=^Y
-	reprint=^R	discard=^O	werase=^W	lnext=^V
-	vmin=\1         vtime=\0
-*/
-#define INIT_C_CC "\003\034\177\025\004\000\000\000\021\023\032\031\022\017\027\026\001"
-
 /*
  * Translate a "termios" structure into a "termio". Ugh.
  *
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
index d525a8dc2045..7c92d64a7989 100644
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
 
 #ifndef user_termio_to_kernel_termios
 /*
-- 
2.30.2

