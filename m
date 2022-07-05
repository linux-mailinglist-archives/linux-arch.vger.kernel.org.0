Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9B1567372
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 17:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiGEPuZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiGEPtt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 11:49:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD131D0E8;
        Tue,  5 Jul 2022 08:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70E9CB81823;
        Tue,  5 Jul 2022 15:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941B5C36AE2;
        Tue,  5 Jul 2022 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657036124;
        bh=9oaDWzRU6R0GkjSESj8xB0w7pNOdSSaExN3Vy3D6ls8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAfMts3hGwakKfseM8AZpijDZr4H9urWzpwNHqBWOGC/J2thqz6Q7V+VJXrNotL/4
         yaiztHNM0qSW8XYTkHylOjgM08kCHXZ6cxSjjqJR/BmqhY0EAU9qO1jn6l4NQNfhbW
         7eMU4fqbWgfMxzxC0C5NniYlNoAfabHyegMlfcisMGqFTRjGUsGesf5Y0CocKNLRi6
         7W+TvZKbJLUYR9ss9hEgMRV77Hy+JoigITZMvmNcahZysMrcw7kiCF4CLMiAQPx72h
         XUylFJ1YQ9pVlFOo27H5jyvHNjew2ZquZi9Qqzua7/n6nOxbaQ6Ur3TM2QKZCeXQxM
         nM6xNf0OuqgsA==
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
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        loongarch@lists.linux.dev
Subject: [PATCH v2 13/15] parisc: Rename PGD_ORDER to PGD_TABLE_ORDER
Date:   Tue,  5 Jul 2022 18:47:06 +0300
Message-Id: <20220705154708.181258-14-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220705154708.181258-1-rppt@kernel.org>
References: <20220705154708.181258-1-rppt@kernel.org>
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
Acked-by: Helge Deller <deller@gmx.de>
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

