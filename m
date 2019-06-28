Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2098259C25
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2019 14:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfF1M5g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jun 2019 08:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfF1M5g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Jun 2019 08:57:36 -0400
Received: from localhost.localdomain (unknown [60.186.221.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD1F82063F;
        Fri, 28 Jun 2019 12:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561726655;
        bh=XEYDarb8NSLXAMTxaRlXcywzzmI5a0jxNDElYQMapA4=;
        h=From:To:Cc:Subject:Date:From;
        b=A+yLbvKdzNksnNInnFSB+NO+OkPfr+84GXHFoD7NIWw+B1ukMT10UITZCWrS3N2lp
         lf+3RS+tLBE8PfiM6tO6bW9nb9Kiq9My83vHCYlUXdtYreeh9WDvdG76X99a1rKA/+
         32ZGOv9Y5ljQtbtN33aPrQ2y11WGyjB+2NkgYqkY=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] csky: Fixup abiv1 memset error
Date:   Fri, 28 Jun 2019 20:57:28 +0800
Message-Id: <1561726648-24871-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Current memset implementation in abiv1 is wrong and it'll cause unalign
access. Just remove it and use the generic one. This patch will cause
performance degradation and we will improve it with a new design in next
patchset.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv1/Makefile         |  1 -
 arch/csky/abiv1/inc/abi/string.h |  3 ---
 arch/csky/abiv1/memset.c         | 37 -------------------------------------
 arch/csky/abiv1/strksyms.c       |  1 -
 4 files changed, 42 deletions(-)
 delete mode 100644 arch/csky/abiv1/memset.c

diff --git a/arch/csky/abiv1/Makefile b/arch/csky/abiv1/Makefile
index e52b42b..601ce3b 100644
--- a/arch/csky/abiv1/Makefile
+++ b/arch/csky/abiv1/Makefile
@@ -5,5 +5,4 @@ obj-y					+= bswapsi.o
 obj-y					+= cacheflush.o
 obj-y					+= mmap.o
 obj-y					+= memcpy.o
-obj-y					+= memset.o
 obj-y					+= strksyms.o
diff --git a/arch/csky/abiv1/inc/abi/string.h b/arch/csky/abiv1/inc/abi/string.h
index 5abe80b..0cd4338 100644
--- a/arch/csky/abiv1/inc/abi/string.h
+++ b/arch/csky/abiv1/inc/abi/string.h
@@ -7,7 +7,4 @@
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *, const void *, __kernel_size_t);
 
-#define __HAVE_ARCH_MEMSET
-extern void *memset(void *, int, __kernel_size_t);
-
 #endif /* __ABI_CSKY_STRING_H */
diff --git a/arch/csky/abiv1/memset.c b/arch/csky/abiv1/memset.c
deleted file mode 100644
index b4aa75b..0000000
--- a/arch/csky/abiv1/memset.c
+++ /dev/null
@@ -1,37 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
-
-#include <linux/types.h>
-
-void *memset(void *dest, int c, size_t l)
-{
-	char *d = dest;
-	int ch = c & 0xff;
-	int tmp = (ch | ch << 8 | ch << 16 | ch << 24);
-
-	while (((uintptr_t)d & 0x3) && l--)
-		*d++ = ch;
-
-	while (l >= 16) {
-		*(((u32 *)d))   = tmp;
-		*(((u32 *)d)+1) = tmp;
-		*(((u32 *)d)+2) = tmp;
-		*(((u32 *)d)+3) = tmp;
-		l -= 16;
-		d += 16;
-	}
-
-	while (l > 3) {
-		*(((u32 *)d)) = tmp;
-		l -= 4;
-		d += 4;
-	}
-
-	while (l) {
-		*d = ch;
-		l--;
-		d++;
-	}
-
-	return dest;
-}
diff --git a/arch/csky/abiv1/strksyms.c b/arch/csky/abiv1/strksyms.c
index 436995c..c7ccbb2 100644
--- a/arch/csky/abiv1/strksyms.c
+++ b/arch/csky/abiv1/strksyms.c
@@ -4,4 +4,3 @@
 #include <linux/module.h>
 
 EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memset);
-- 
2.7.4

