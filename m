Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7295647CC
	for <lists+linux-arch@lfdr.de>; Sun,  3 Jul 2022 16:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiGCOMg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Jul 2022 10:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiGCOMe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2022 10:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249F95FDC;
        Sun,  3 Jul 2022 07:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEEA260EA8;
        Sun,  3 Jul 2022 14:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D8EC341CB;
        Sun,  3 Jul 2022 14:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656857552;
        bh=DI2oxzurFMYqSzd7nO4fq973zusvJhghlTwe6lxPMqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/zlNbN/Q8wxA4e8/ycdSWMEVdV3TtSgYTBHpMxnZRLvanxF3+f9DUAqdWKdfpHlo
         fFAyZ4ugjxnn4bC84GIV7zy0iQJKjXtFH2/nbtMA91iMSkvAFdPwlYuzV1AX5pyhl8
         uaMrInJ00ptJoJDUFCEHewp5xfmB3hQzGdQRauUgc6vHeYklU5tvn1T2fMBvWeXIZm
         0bUggdGaNm4TeDcZvBWkL/ZJeiWCOM4cGwCxu0xzoNDCt2z22erznjTaqbKcTX7ME4
         x2Mtr9OSUxNf8hnXp1y0Qwdpf9jq3W4FEBmALpw6ueos8y44pZwabhqG5ATObcqJnZ
         fVGdL7LUTkWVw==
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
Subject: [PATCH 02/14] csky: drop definition of PGD_ORDER
Date:   Sun,  3 Jul 2022 17:11:51 +0300
Message-Id: <20220703141203.147893-3-rppt@kernel.org>
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
Since its always hardwired to 0, simply drop it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
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

