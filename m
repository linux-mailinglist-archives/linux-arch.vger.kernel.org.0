Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7238E381794
	for <lists+linux-arch@lfdr.de>; Sat, 15 May 2021 12:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhEOKUc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 May 2021 06:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234837AbhEOKUV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 15 May 2021 06:20:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 222DB613F2;
        Sat, 15 May 2021 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621073949;
        bh=ZuoXd0B2SrZ7Z7bKOj6098xfQUeD3LlhjJk6ioEZ4Xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaXxzQOLVw4qXYynCG0CbJTLPAAS4Cb6ml36FdzlD2oZFwMEoeLCGboIwHsdJ5exf
         Ga2adeohFo6jmgrDUQjP94/gg0dswfFTbe+zdsfcWzgNBT43wk4Rxgkfpfu1PQ0+Z7
         ZxuSwUyFzpHZs+JqnThCfpAyalEYKBpG0bbzQmP4PXw6PFNb5+nQV6gUU6v/7++9gN
         Hzg5TNwsEo/ElbE+CUdy7zXGXcUoVWfppN9fShcogVKUpONLfuipIrULhaQbwVAGSP
         c+UkqkoXdQGbJ9zE+9HHem2AcbupgnH8nxd1PtiVRb0sqYrQm9KC8BHrRsfyNFx2uH
         C6SoseNotBhMg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Sid Manning <sidneym@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org
Subject: [PATCH 2/6] [v2] h8300: remove stale strncpy_from_user
Date:   Sat, 15 May 2021 12:17:59 +0200
Message-Id: <20210515101803.924427-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210515101803.924427-1-arnd@kernel.org>
References: <20210515101803.924427-1-arnd@kernel.org>
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

