Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269825647D0
	for <lists+linux-arch@lfdr.de>; Sun,  3 Jul 2022 16:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiGCON1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Jul 2022 10:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiGCONF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2022 10:13:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C360DE;
        Sun,  3 Jul 2022 07:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CE0960EAE;
        Sun,  3 Jul 2022 14:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532C0C341CB;
        Sun,  3 Jul 2022 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656857581;
        bh=/GRO3PH1/o87mSyvNwgnC65awjhLFzdc6wqe5YuxHNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJFDg9Bgulgv5UqAd8swJwn0kDrs3Y3ocmaBsuM0mujV/oZeAthGWtZMn7kKUAQ80
         SZ0MHLBIR9xIepLWav3peBr3s34BVb7UJdRO7mOGvuUTNhUVUggPAS7xJzvwcIL9tf
         SdZUYaAorua9UevqjSAm7SPv3Kcps/fPqkCG6Rql2QrThsgFKAmf8OI1WYxxr0J8hF
         lsDw76I+i8jyR0XHcDuxnrKDN/66uz4amgsNT061C29l4RY9Ju6IW2m/m744KzlSpZ
         4ro4AkvEQT0RAkgYVfpyGhh7rvtGBg4VHYhw0quxUnIr59djXCx+Jys+aaFkHZp9Dz
         iE3YIX4ZRdtSQ==
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
Subject: [PATCH 07/14] nios2: drop definition of PTE_ORDER
Date:   Sun,  3 Jul 2022 17:11:56 +0300
Message-Id: <20220703141203.147893-8-rppt@kernel.org>
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

This is the order of the page table allocation, not the order of a PTE.
Since its always hardwired to 0, simply drop it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/nios2/include/asm/pgtable.h | 3 +--
 arch/nios2/mm/init.c             | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index 262d0609268c..eaf8f28baa8b 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -69,10 +69,9 @@ struct mm_struct;
 #define PAGE_COPY MKP(0, 0, 1)
 
 #define PGD_ORDER	0
-#define PTE_ORDER	0
 
 #define PTRS_PER_PGD	((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
-#define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
+#define PTRS_PER_PTE	(PAGE_SIZE / sizeof(pte_t))
 
 #define USER_PTRS_PER_PGD	\
 	(CONFIG_NIOS2_KERNEL_MMU_REGION_BASE / PGDIR_SIZE)
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 613fcaa5988a..2d6dbf7701f6 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -80,7 +80,7 @@ void __init mmu_init(void)
 
 #define __page_aligned(order) __aligned(PAGE_SIZE << (order))
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned(PGD_ORDER);
-pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned(PTE_ORDER);
+pte_t invalid_pte_table[PTRS_PER_PTE] __aligned(PAGE_SIZE);
 static struct page *kuser_page[1];
 
 static int alloc_kuser_page(void)
-- 
2.34.1

