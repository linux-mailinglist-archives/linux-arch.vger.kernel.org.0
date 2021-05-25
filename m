Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB3C3900CC
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 14:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhEYMXe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 08:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232588AbhEYMWz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 08:22:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D25EF613F5;
        Tue, 25 May 2021 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621945286;
        bh=kkOFBK36MRxl8q4h1ABFoSf/N6xzgxGjK2IhPoS7xos=;
        h=From:To:Cc:Subject:Date:From;
        b=dFS/jLpi2jnANmVgkpVSLL+EL4f1yLHSxpzak6UnyM6v4A/aNcCTvjWpJtpJSiNZR
         GKgB4LEiLR6US9khaJ8z4aYMx2PXMXvxZSCq/GEN/oE4CcfNqGisIHRrWELvNfTZKm
         xh17eSoJqSi1W5C5TYN8kN0+g4VsFzH1I87ILpc+nbjPTYbytl9zn/38VCnrOXUNWE
         hgjXkE1BHNqtaT0hwcy5cWVWAcy5rwk4FQ/MfJ/Z3Ms8EGP6F3mlE5IikT2DtjAEtQ
         ai3oQkuUkJp6v6Xmuwn2lLFs8y9UIAn0TiVRH5IkEVg6u8dgiaRoqTLzBUxoVCd9zb
         L03U1dSD8pRpw==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, hch@lst.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH] arch: Cleanup unused functions
Date:   Tue, 25 May 2021 12:20:34 +0000
Message-Id: <1621945234-37878-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

These functions haven't been used, so just remove them. The patch
has been tested with riscv, but I only use grep to check the
microblaze's.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/include/asm/page.h |  3 ---
 arch/riscv/include/asm/page.h      | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
index bf681f2..ce55097 100644
--- a/arch/microblaze/include/asm/page.h
+++ b/arch/microblaze/include/asm/page.h
@@ -35,9 +35,6 @@
 
 #define ARCH_SLAB_MINALIGN	L1_CACHE_BYTES
 
-#define PAGE_UP(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
-#define PAGE_DOWN(addr)	((addr)&(~((PAGE_SIZE)-1)))
-
 /*
  * PAGE_OFFSET -- the first address of the first page of memory. With MMU
  * it is set to the kernel start address (aligned on a page boundary).
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 6a7761c..a1b888f 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -37,16 +37,6 @@
 
 #ifndef __ASSEMBLY__
 
-#define PAGE_UP(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
-#define PAGE_DOWN(addr)	((addr)&(~((PAGE_SIZE)-1)))
-
-/* align addr on a size boundary - adjust address up/down if needed */
-#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((size)-1)))
-#define _ALIGN_DOWN(addr, size)	((addr)&(~((size)-1)))
-
-/* align addr on a size boundary - adjust address up if needed */
-#define _ALIGN(addr, size)	_ALIGN_UP(addr, size)
-
 #define clear_page(pgaddr)			memset((pgaddr), 0, PAGE_SIZE)
 #define copy_page(to, from)			memcpy((to), (from), PAGE_SIZE)
 
-- 
2.7.4

