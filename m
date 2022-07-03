Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4E6564802
	for <lists+linux-arch@lfdr.de>; Sun,  3 Jul 2022 16:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiGCOOZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Jul 2022 10:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiGCON7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2022 10:13:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D18262F3;
        Sun,  3 Jul 2022 07:13:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73D5460EA7;
        Sun,  3 Jul 2022 14:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CACAC341CB;
        Sun,  3 Jul 2022 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656857616;
        bh=oXZW+dUjDDPpDV6V5KTSTxOrdigIFbUT4mUe7nec500=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6CjB0J11WxgCdNY+KJBZq6cPCrF0uiW8afxPX6gF0HFKA4RMMDTiYl+ggu6gVgp3
         QEhcUCw8yexCinnJo51BP3xFsZBkvQdnAkhdFlxdTUK3j/tqoo5TB7Plise33XB6PX
         cW3Ua/PoG00+osKgXds6MoZg+ZjFWUjw/ClFWu34WoKygnApMETD1ojNIOaQK1MXZo
         nkQMW4Gui4bhFyB7tTpdWp3/xHRf4ud6yzoUEvFM8CBsKu2vZdRURoiF0GSu6fD96/
         bWsZP5O9zqC/3tCh5MOwg2ceqs0LdT/aK/js0xlPy7XY+u94c8qZD/cNcG/k6c5q/F
         IlCAAgFu9qHIQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        loongarch@lists.linux.dev
Subject: [PATCH 13/14] parisc: Rename PGD_ORDER to PGD_TABLE_ORDER
Date:   Sun,  3 Jul 2022 17:12:02 +0300
Message-Id: <20220703141203.147893-14-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220703141203.147893-1-rppt@kernel.org>
References: <20220703141203.147893-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

This is the order of the page table allocation, not the order of a PGD.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/parisc/include/asm/pgalloc.h | 6 +++---
 arch/parisc/include/asm/pgtable.h | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index 54b63374579b..e3e142b1c5c5 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -20,18 +20,18 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
 
-	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ORDER);
+	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_TABLE_ORDER);
 	if (unlikely(pgd == NULL))
 		return NULL;
 
-	memset(pgd, 0, PAGE_SIZE << PGD_ORDER);
+	memset(pgd, 0, PAGE_SIZE << PGD_TABLE_ORDER);
 
 	return pgd;
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	free_pages((unsigned long)pgd, PGD_ORDER);
+	free_pages((unsigned long)pgd, PGD_TABLE_ORDER);
 }
 
 #if CONFIG_PGTABLE_LEVELS == 3
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 69765a6dbe89..6790b554bdfd 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -118,9 +118,9 @@ extern void __update_cache(pte_t pte);
 
 #if CONFIG_PGTABLE_LEVELS == 3
 #define PMD_TABLE_ORDER	1
-#define PGD_ORDER	0
+#define PGD_TABLE_ORDER	0
 #else
-#define PGD_ORDER	1
+#define PGD_TABLE_ORDER	1
 #endif
 
 /* Definitions for 3rd level (we use PLD here for Page Lower directory
@@ -144,10 +144,10 @@ extern void __update_cache(pte_t pte);
 
 /* Definitions for 1st level */
 #define PGDIR_SHIFT	(PLD_SHIFT + BITS_PER_PTE + BITS_PER_PMD)
-#if (PGDIR_SHIFT + PAGE_SHIFT + PGD_ORDER - BITS_PER_PGD_ENTRY) > BITS_PER_LONG
+#if (PGDIR_SHIFT + PAGE_SHIFT + PGD_TABLE_ORDER - BITS_PER_PGD_ENTRY) > BITS_PER_LONG
 #define BITS_PER_PGD	(BITS_PER_LONG - PGDIR_SHIFT)
 #else
-#define BITS_PER_PGD	(PAGE_SHIFT + PGD_ORDER - BITS_PER_PGD_ENTRY)
+#define BITS_PER_PGD	(PAGE_SHIFT + PGD_TABLE_ORDER - BITS_PER_PGD_ENTRY)
 #endif
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
-- 
2.34.1

