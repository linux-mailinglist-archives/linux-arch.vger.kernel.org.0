Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3AB567328
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiGEPsL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 11:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiGEPri (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 11:47:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F2317E22;
        Tue,  5 Jul 2022 08:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A41FC61B49;
        Tue,  5 Jul 2022 15:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D15C341CB;
        Tue,  5 Jul 2022 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657036057;
        bh=yII5UNWZKGsbdktmuyJMDCcQNmFGi0PKtAPWkTX44+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qaLjiQFhyHDfW36wq/6nru8GfWGyEzg5fUbs6v3lYDItFli5Crx68fyYHWaAvFRBO
         ScGG3r5m7DMl3AOG0GlxFiJbuso46mLCVQnEaQ4IpuS3yMEufTX2OIU097bun08x3k
         0cyw59FyQOczQqoaaGYSN9BdFYCUfNN6/2gKjlALGUQiR0811lIjNWtHy5IDY9Lg+m
         HjW4DHtYSoaNDb15Ojv7TeVeKbJqfPzFyPa2HL5upxQQ5RhTxASWA4S50LzQ4mtDpm
         3kFTtVBy6FnCijV6aL4WJ8bGa9252Wo24hPE0wWTjkIDSOZuvLwE3tKfHL/MoMq0Vc
         676sVFBmG4zOQ==
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
Subject: [PATCH v2 02/15] csky: drop definition of PGD_ORDER
Date:   Tue,  5 Jul 2022 18:46:55 +0300
Message-Id: <20220705154708.181258-3-rppt@kernel.org>
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
Since its always hardwired to 0, simply drop it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/include/asm/pgalloc.h | 2 +-
 arch/csky/include/asm/pgtable.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index bbbd0698b397..7d57e5da0914 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -44,7 +44,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	pgd_t *ret;
 	pgd_t *init;
 
-	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ORDER);
+	ret = (pgd_t *) __get_free_page(GFP_KERNEL);
 	if (ret) {
 		init = pgd_offset(&init_mm, 0UL);
 		pgd_init((unsigned long *)ret);
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index f8bb1e12334b..0f1e2eda1601 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -18,9 +18,8 @@
 /*
  * C-SKY is two-level paging structure:
  */
-#define PGD_ORDER	0
 
-#define PTRS_PER_PGD	((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
+#define PTRS_PER_PGD	(PAGE_SIZE / sizeof(pgd_t))
 #define PTRS_PER_PMD	1
 #define PTRS_PER_PTE	(PAGE_SIZE / sizeof(pte_t))
 
-- 
2.34.1

