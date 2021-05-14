Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86EF3806B1
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 12:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhENKEg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 06:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232792AbhENKEf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 06:04:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5CE96101D;
        Fri, 14 May 2021 10:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620986604;
        bh=FCn6ZP/mDL3GEna//8Jp2ayzBRYkQcmsOPivYHNTfF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKmoKSrMYAHLhDOeZ1UP89+0ZXg+ckzD143m2Hec1GKcmtQiUgKUoNcj+firf8vej
         xMeYFAvG5JbdI+OqIfrxb3SQmgVSpK7qWlyx7UfDW5lsqwlMjQKksvbuQ1gzStl6e8
         TsCZD+VaMs0sYrmzmMKmDST9QEbnuAsH1RJHyHIKdPXN0TbB0UskOL+s3d+2KLNYUM
         h0bGn7DwU1wpHuSlQuZDdxBhcYDdatG42va2mdQx6FUtS5rmnCEkrWH2efKZedu9tf
         ElmLQp0RWThAYINEENWcoHvYSpyhUAqvitng3o6dSGmEiyKAWioG9Xo+U0zbDCdg40
         WILL8pWDh7/rA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] m68k: select CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
Date:   Fri, 14 May 2021 12:00:52 +0200
Message-Id: <20210514100106.3404011-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210514100106.3404011-1-arnd@kernel.org>
References: <20210514100106.3404011-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

All supported CPUs other than the old dragonball and in theory other 68000
derivatives use the include/linux/unaligned/access_ok.h implementation
for accessing unaligned variables, so presumably this works everywhere.

However, m68k never selects CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
so none of the other conditionals in the kernel get the optimized
implementation.

Select this based on CPU_HAS_NO_UNALIGNED to make the two settings
always match, and then use the generic version of the header.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/Kconfig                 |  1 +
 arch/m68k/include/asm/unaligned.h | 19 -------------------
 2 files changed, 1 insertion(+), 19 deletions(-)
 delete mode 100644 arch/m68k/include/asm/unaligned.h

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 372e4e69c43a..46089f3b9603 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -21,6 +21,7 @@ config M68K
 	select HAVE_AOUT if MMU
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_DEBUG_BUGVERBOSE
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_HAS_NO_UNALIGNED
 	select HAVE_FUTEX_CMPXCHG if MMU && FUTEX
 	select HAVE_IDE
 	select HAVE_MOD_ARCH_SPECIFIC
diff --git a/arch/m68k/include/asm/unaligned.h b/arch/m68k/include/asm/unaligned.h
deleted file mode 100644
index 84e437337344..000000000000
--- a/arch/m68k/include/asm/unaligned.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_M68K_UNALIGNED_H
-#define _ASM_M68K_UNALIGNED_H
-
-#ifdef CONFIG_CPU_HAS_NO_UNALIGNED
-#include <asm-generic/unaligned.h>
-#else
-/*
- * The m68k can do unaligned accesses itself.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-
-#endif
-
-#endif /* _ASM_M68K_UNALIGNED_H */
-- 
2.29.2

