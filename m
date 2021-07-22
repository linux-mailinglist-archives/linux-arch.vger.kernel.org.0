Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA023D239B
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 14:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhGVMIf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 08:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231938AbhGVMI3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 08:08:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E28E361362;
        Thu, 22 Jul 2021 12:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626958144;
        bh=ZuoXd0B2SrZ7Z7bKOj6098xfQUeD3LlhjJk6ioEZ4Xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hA3Nlg7PrCYGjNZbyik3EyJnOGH4Rc+WYZ/44n/S8bm1S6Z4X1gjmih8rHBlXKQot
         GSuLfvUhJGYRCeAt3OD4idwM47GXeI38tK4ueK9rSkMpw76wM3DftVyTOVJbuJgErI
         3G1dOi6f0yBrlYqEGllSDwn4BaHHw1e//0+kj36Ov6BumSLnC5e8cjFwoyBjuvxdZK
         56PzMD+dBAZmyaIHbyo6gB8KRotIXWFo2JwMKdGjo+8D0Jxqcypq81UfnfAUnUmNog
         3yVbGFOs8zQc9PujNSM217ldBRIWNluLGRQnAXjeifG5jNaaN2DZzzboy4rk8bo2pm
         c+NrsffAWKYYA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Cain <bcain@codeaurora.org>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH v3 2/9] h8300: remove stale strncpy_from_user
Date:   Thu, 22 Jul 2021 14:48:07 +0200
Message-Id: <20210722124814.778059-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210722124814.778059-1-arnd@kernel.org>
References: <20210722124814.778059-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function is never called because h8300 uses the asm-generic
inline function version.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/h8300/kernel/h8300_ksyms.c |  2 --
 arch/h8300/lib/Makefile         |  2 +-
 arch/h8300/lib/strncpy.S        | 35 ---------------------------------
 3 files changed, 1 insertion(+), 38 deletions(-)
 delete mode 100644 arch/h8300/lib/strncpy.S

diff --git a/arch/h8300/kernel/h8300_ksyms.c b/arch/h8300/kernel/h8300_ksyms.c
index 1c6f902e82a5..853d6e886477 100644
--- a/arch/h8300/kernel/h8300_ksyms.c
+++ b/arch/h8300/kernel/h8300_ksyms.c
@@ -19,7 +19,6 @@ asmlinkage long __mulsi3(long, long);
 asmlinkage long __udivsi3(long, long);
 asmlinkage void *memcpy(void *, const void *, size_t);
 asmlinkage void *memset(void *, int, size_t);
-asmlinkage long strncpy_from_user(void *to, void *from, size_t n);
 
 	/* gcc lib functions */
 EXPORT_SYMBOL(__ucmpdi2);
@@ -34,4 +33,3 @@ EXPORT_SYMBOL(__mulsi3);
 EXPORT_SYMBOL(__udivsi3);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(strncpy_from_user);
diff --git a/arch/h8300/lib/Makefile b/arch/h8300/lib/Makefile
index 685fa837c1f7..5911c1fa856d 100644
--- a/arch/h8300/lib/Makefile
+++ b/arch/h8300/lib/Makefile
@@ -3,7 +3,7 @@
 # Makefile for H8/300-specific library files..
 #
 
-lib-y  = memcpy.o memset.o abs.o strncpy.o \
+lib-y  = memcpy.o memset.o abs.o \
 	 mulsi3.o udivsi3.o muldi3.o moddivsi3.o \
 	 ashldi3.o lshrdi3.o ashrdi3.o ucmpdi2.o \
 	 delay.o
diff --git a/arch/h8300/lib/strncpy.S b/arch/h8300/lib/strncpy.S
deleted file mode 100644
index 8b65d7c4727b..000000000000
--- a/arch/h8300/lib/strncpy.S
+++ /dev/null
@@ -1,35 +0,0 @@
-;;; SPDX-License-Identifier: GPL-2.0
-;;; strncpy.S
-
-#include <asm/linkage.h>
-
-	.text
-.global strncpy_from_user
-
-;;; long strncpy_from_user(void *to, void *from, size_t n)
-strncpy_from_user:
-	mov.l	er2,er2
-	bne	1f
-	sub.l	er0,er0
-	rts
-1:
-	mov.l	er4,@-sp
-	sub.l	er3,er3
-2:
-	mov.b	@er1+,r4l
-	mov.b	r4l,@er0
-	adds	#1,er0
-	beq	3f
-	inc.l	#1,er3
-	dec.l	#1,er2
-	bne	2b
-3:
-	dec.l	#1,er2
-4:
-	mov.b	r4l,@er0
-	adds	#1,er0
-	dec.l	#1,er2
-	bne	4b
-	mov.l	er3,er0
-	mov.l	@sp+,er4
-	rts
-- 
2.29.2

