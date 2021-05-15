Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC39D3817A1
	for <lists+linux-arch@lfdr.de>; Sat, 15 May 2021 12:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhEOKVW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 May 2021 06:21:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231583AbhEOKUj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 15 May 2021 06:20:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E949460C40;
        Sat, 15 May 2021 10:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621073967;
        bh=Lb/DGS9E/FUSMtSHAOCH5rcc8a7ucnqACx5B/SB9r64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lp+IzcRjKvLR7R++grQxnLp5gtXP/qgN/cg/jcb91yHCafo9eiUfkQxObCDBCGovC
         TFKLGUohWA3fQwZPvPi3so4qDwe/nQwdVB/Zpg89Ei6NLVc98yHvm8h8zpxNkOXOzJ
         HqlnbG+AOzcfs7TiPxwHgCjBWg/sp1i9Mx+5NkeL/2X5g4YE7j9kLgiy41okPcWaDK
         GZ3hLjqev+EZ0yJmEGmLgCdC9w79agdGf9FvOnZDObtON4etwgfiPcWKWiAgelyks0
         Gtn4EtMiZohOg//Wb49qpe1Brp+XFagahm8puDaxQjJ1NEBFDVrRK656cJmTzk6wAb
         0ws3B/3Ao+LfA==
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
Subject: [PATCH 6/6] [v2] asm-generic: remove extra strn{cpy_from,len}_user declarations
Date:   Sat, 15 May 2021 12:18:03 +0200
Message-Id: <20210515101803.924427-7-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210515101803.924427-1-arnd@kernel.org>
References: <20210515101803.924427-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

As these are now in asm-generic, it's no longer necessary to
declare them in the architecture.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arc/include/asm/uaccess.h     | 5 -----
 arch/hexagon/include/asm/uaccess.h | 6 ------
 arch/um/include/asm/uaccess.h      | 5 +----
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index 754a23f26736..783bfdb3bfa3 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -667,11 +667,6 @@ extern unsigned long arc_clear_user_noinline(void __user *to,
 #define __clear_user(d, n)		arc_clear_user_noinline(d, n)
 #endif
 
-extern long strncpy_from_user(char *dst, const char __user *src, long count);
-#define strncpy_from_user(d, s, n)	strncpy_from_user(d, s, n)
-extern long strnlen_user(const char __user *src, long n);
-#define strnlen_user(s, n)		strnlen_user(s, n)
-
 #include <asm/segment.h>
 #include <asm-generic/uaccess.h>
 
diff --git a/arch/hexagon/include/asm/uaccess.h b/arch/hexagon/include/asm/uaccess.h
index d950df12d8c5..ef5bfef8d490 100644
--- a/arch/hexagon/include/asm/uaccess.h
+++ b/arch/hexagon/include/asm/uaccess.h
@@ -57,12 +57,6 @@ unsigned long raw_copy_to_user(void __user *to, const void *from,
 __kernel_size_t __clear_user_hexagon(void __user *dest, unsigned long count);
 #define __clear_user(a, s) __clear_user_hexagon((a), (s))
 
-extern long strnlen_user(const char __user *src, long n);
-#define strnlen_user strnlen_user
-
-extern long strncpy_from_user(char *dst, const char __user *src, long n)
-#define strncpy_from_user strncpy_from_user
-
 #include <asm-generic/uaccess.h>
 
 
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 3bf209f683f8..191ef36dd543 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -23,16 +23,13 @@
 
 extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
-extern long strncpy_from_user(char *dst, const char __user *src, long count);
-extern long strnlen_user(const void __user *str, long len);
 extern unsigned long __clear_user(void __user *mem, unsigned long len);
 static inline int __access_ok(unsigned long addr, unsigned long size);
 
 /* Teach asm-generic/uaccess.h that we have C functions for these. */
 #define __access_ok __access_ok
 #define __clear_user __clear_user
-#define strnlen_user strnlen_user
-#define strncpy_from_user strncpy_from_user
+
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
 
-- 
2.29.2

