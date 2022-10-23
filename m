Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D70F6093AB
	for <lists+linux-arch@lfdr.de>; Sun, 23 Oct 2022 15:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiJWNeP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 23 Oct 2022 09:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiJWNeG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 23 Oct 2022 09:34:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0A93AE49;
        Sun, 23 Oct 2022 06:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B2C0B80BFF;
        Sun, 23 Oct 2022 13:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D109C43470;
        Sun, 23 Oct 2022 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666532040;
        bh=HgCI1fwpCRV6cbIVNToGS+BLd1ULTdQix8qchtvlux4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVFtjHfSb8Pix+ZODNxlJQR5O5aUXDkMSRquLor3ywU7ifraASh1B9mCOEjvSpmhi
         5pwloxojUVQPEPJ2nXi5g1JVDuDE1h3HpRLY42daghXEUPTF7NpE69kjP4CO1wc0ML
         OzbFYnrf6HzV8oxKV1yp5MMhWhLI4SLmS2V+DRTzZxBvEFKaEvXBlJ6KnhO+lYL3dI
         1IWrS6h4wVbfMAXen6V8wN5llaAW/lK3lOeEvN7oClwG3ggzWrMfgYvsVvCq5yv/EB
         qeU0OFXs587rqByUX1KKY/7/nHUUujPncosY2MQnzIcadA2hayGkXIyo9eL+kUJ0RU
         yMZXSDWBeTMUQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, palmer@rivosinc.com,
        heiko@sntech.de, arnd@arndb.de, songmuchun@bytedance.com,
        catalin.marinas@arm.com, chenhuacai@loongson.cn,
        Conor.Dooley@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 2/2] riscv: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
Date:   Sun, 23 Oct 2022 09:32:05 -0400
Message-Id: <20221023133205.3493564-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221023133205.3493564-1-guoren@kernel.org>
References: <20221023133205.3493564-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch enable the feature of "free some vmemmap pages of HugeTLB
page" [1]. To make it work correct, we also need fixup PG_dcache_clean
setting for huge page [2].

[1] https://lore.kernel.org/linux-doc/20210510030027.56044-1-songmuchun@bytedance.com/
[2] https://lore.kernel.org/linux-mm/20220302084624.33340-1-songmuchun@bytedance.com/

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/Kconfig                  | 1 +
 arch/riscv/include/asm/cacheflush.h | 3 +++
 arch/riscv/mm/cacheflush.c          | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6b48a3ae9843..81ac25b0e005 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -45,6 +45,7 @@ config RISCV
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_GENERAL_HUGETLB
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
+	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
 	select BUILDTIME_TABLE_SORT if MMU
diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 8a5c246b0a21..96f7381aeeeb 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -17,6 +17,9 @@ static inline void local_flush_icache_all(void)
 
 static inline void flush_dcache_page(struct page *page)
 {
+	if (PageHuge(page))
+		page = compound_head(page);
+
 	if (test_bit(PG_dcache_clean, &page->flags))
 		clear_bit(PG_dcache_clean, &page->flags);
 }
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 7c9f97fa3938..ca35807cf185 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -82,6 +82,9 @@ void flush_icache_pte(pte_t pte)
 {
 	struct page *page = pte_page(pte);
 
+	if (PageHuge(page))
+		page = compound_head(page);
+
 	if (!test_bit(PG_dcache_clean, &page->flags)) {
 		flush_icache_all();
 		set_bit(PG_dcache_clean, &page->flags);
-- 
2.36.1

