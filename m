Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC53225D668
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgIDKfw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 06:35:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbgIDKbV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Sep 2020 06:31:21 -0400
Received: from localhost.localdomain (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B4C621548;
        Fri,  4 Sep 2020 10:30:57 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 11/29] arm64: Avoid unnecessary clear_user_page() indirection
Date:   Fri,  4 Sep 2020 11:30:11 +0100
Message-Id: <20200904103029.32083-12-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200904103029.32083-1-catalin.marinas@arm.com>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since clear_user_page() calls clear_page() directly, avoid the
unnecessary indirection.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    New in v5.

 arch/arm64/include/asm/page.h | 3 +--
 arch/arm64/mm/copypage.c      | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 11734ce29702..d918cb1d83a6 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -18,7 +18,6 @@
 struct page;
 struct vm_area_struct;
 
-extern void __cpu_clear_user_page(void *p, unsigned long user);
 extern void copy_page(void *to, const void *from);
 extern void clear_page(void *to);
 
@@ -33,7 +32,7 @@ void copy_highpage(struct page *to, struct page *from);
 	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vaddr)
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
-#define clear_user_page(addr,vaddr,pg)  __cpu_clear_user_page(addr, vaddr)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
 typedef struct page *pgtable_t;
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 4a2233fa674e..70a71f38b6a9 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -35,9 +35,3 @@ void copy_user_highpage(struct page *to, struct page *from,
 	flush_dcache_page(to);
 }
 EXPORT_SYMBOL_GPL(copy_user_highpage);
-
-void __cpu_clear_user_page(void *kaddr, unsigned long vaddr)
-{
-	clear_page(kaddr);
-}
-EXPORT_SYMBOL_GPL(__cpu_clear_user_page);
