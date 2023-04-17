Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A6F6E5363
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjDQU4O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjDQUzI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:55:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC016A6E;
        Mon, 17 Apr 2023 13:53:31 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w11so27723749pjh.5;
        Mon, 17 Apr 2023 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764811; x=1684356811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lI4mQ87WoWgY+PGEzL+RyVT2V9KzYHmGTUoQkkpMa78=;
        b=OlBOZiQXTEQ2yJNCXWXVeEV70jBd/5g1C1TEFSYKGJH4RB2t5MeymRQTJkCAMhqY8X
         xT0QIMwkP3fej3rBN/YVKJNeHnVxdz5dc1MiD+bCMEF9s0dHv6uN4wyDmNsH2Y2Ym+iY
         2ZNsAP/RgJk51+uVp81qcQOj+bGNImtPBjaen/JrqoOw/PBUibNGoaM/ZCPpfG5uzvkW
         XBTMu6ICJd2ADipenkzYOjnqUxYIKWTiKPtzD1nHG87S/riR67Qes5ac47aDjBNBedgZ
         nWtoSmVXLxbkA7A5m2dqK2dJ5Frc5F3qBCVwCqlbD2BXSOmg77x4kXyTkenC4W3QlTw8
         reIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764811; x=1684356811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lI4mQ87WoWgY+PGEzL+RyVT2V9KzYHmGTUoQkkpMa78=;
        b=lVlYSTD1LuCsc+L0ebS06Q8vheOM+rsoe0fIojyurHvjcsFq0hQcs0aQHmjumkn4VS
         K1KQb5ruzAK3IhPituaQOiopXc3sBEFtIMcg7sdlii46vPYtbHJlczejiiPEdwlOclOZ
         QDFJ13W/FLEgg86995sW9MfA5UQqJuyLgySET45rnZi7JOVbXH8FYU3cdxVfPvmumCn9
         i8fQ0z4SBRlO2lyYBEHlqRMFE9L7x1ZyRj7jLHJVpXAvV4+YMhq1J+41IbbAOoIz3jSM
         6admw9+ohKNrSRe9SlhNeLuG1mnXdCNXG8sGKgSdM66a2kDiPt5rHeNo0w3E6ELbb+fX
         zz8w==
X-Gm-Message-State: AAQBX9eZJrRqjSyTrtpJBZWn0lFEnISOie0tjP+Cgz+RWVo/FLRxpsb4
        ZvJjZ3JFViKlDKixm/7agQA=
X-Google-Smtp-Source: AKy350bto7gkYUEXZmV5HcAXbLEbfMM+TO53YOoTMdsdAnKO7c7cFoDN5d9Q3fv9Tr0h94wXesVw1Q==
X-Received: by 2002:a17:902:ec82:b0:1a1:b137:4975 with SMTP id x2-20020a170902ec8200b001a1b1374975mr256275plg.49.1681764811306;
        Mon, 17 Apr 2023 13:53:31 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:31 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 33/33] mm: Remove pgtable_{pmd, pte}_page_{ctor, dtor}() wrappers
Date:   Mon, 17 Apr 2023 13:50:48 -0700
Message-Id: <20230417205048.15870-34-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These functions are no longer necessary. Remove them and cleanup
Documentation referencing them.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 Documentation/mm/split_page_table_lock.rst    | 12 +++++------
 .../zh_CN/mm/split_page_table_lock.rst        | 14 ++++++-------
 include/linux/mm.h                            | 20 -------------------
 3 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/Documentation/mm/split_page_table_lock.rst b/Documentation/mm/split_page_table_lock.rst
index 50ee0dfc95be..b3c612183135 100644
--- a/Documentation/mm/split_page_table_lock.rst
+++ b/Documentation/mm/split_page_table_lock.rst
@@ -53,7 +53,7 @@ Support of split page table lock by an architecture
 ===================================================
 
 There's no need in special enabling of PTE split page table lock: everything
-required is done by pgtable_pte_page_ctor() and pgtable_pte_page_dtor(), which
+required is done by ptdesc_pte_ctor() and ptdesc_pte_dtor(), which
 must be called on PTE table allocation / freeing.
 
 Make sure the architecture doesn't use slab allocator for page table
@@ -63,8 +63,8 @@ This field shares storage with page->ptl.
 PMD split lock only makes sense if you have more than two page table
 levels.
 
-PMD split lock enabling requires pgtable_pmd_page_ctor() call on PMD table
-allocation and pgtable_pmd_page_dtor() on freeing.
+PMD split lock enabling requires ptdesc_pmd_ctor() call on PMD table
+allocation and ptdesc_pmd_dtor() on freeing.
 
 Allocation usually happens in pmd_alloc_one(), freeing in pmd_free() and
 pmd_free_tlb(), but make sure you cover all PMD table allocation / freeing
@@ -72,7 +72,7 @@ paths: i.e X86_PAE preallocate few PMDs on pgd_alloc().
 
 With everything in place you can set CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK.
 
-NOTE: pgtable_pte_page_ctor() and pgtable_pmd_page_ctor() can fail -- it must
+NOTE: ptdesc_pte_ctor() and ptdesc_pmd_ctor() can fail -- it must
 be handled properly.
 
 page->ptl
@@ -92,7 +92,7 @@ trick:
    split lock with enabled DEBUG_SPINLOCK or DEBUG_LOCK_ALLOC, but costs
    one more cache line for indirect access;
 
-The spinlock_t allocated in pgtable_pte_page_ctor() for PTE table and in
-pgtable_pmd_page_ctor() for PMD table.
+The spinlock_t allocated in ptdesc_pte_ctor() for PTE table and in
+ptdesc_pmd_ctor() for PMD table.
 
 Please, never access page->ptl directly -- use appropriate helper.
diff --git a/Documentation/translations/zh_CN/mm/split_page_table_lock.rst b/Documentation/translations/zh_CN/mm/split_page_table_lock.rst
index 4fb7aa666037..a3323eb9dc40 100644
--- a/Documentation/translations/zh_CN/mm/split_page_table_lock.rst
+++ b/Documentation/translations/zh_CN/mm/split_page_table_lock.rst
@@ -56,16 +56,16 @@ Hugetlb特定的辅助函数:
 架构对分页表锁的支持
 ====================
 
-没有必要特别启用PTE分页表锁：所有需要的东西都由pgtable_pte_page_ctor()
-和pgtable_pte_page_dtor()完成，它们必须在PTE表分配/释放时被调用。
+没有必要特别启用PTE分页表锁：所有需要的东西都由ptdesc_pte_ctor()
+和ptdesc_pte_dtor()完成，它们必须在PTE表分配/释放时被调用。
 
 确保架构不使用slab分配器来分配页表：slab使用page->slab_cache来分配其页
 面。这个区域与page->ptl共享存储。
 
 PMD分页锁只有在你有两个以上的页表级别时才有意义。
 
-启用PMD分页锁需要在PMD表分配时调用pgtable_pmd_page_ctor()，在释放时调
-用pgtable_pmd_page_dtor()。
+启用PMD分页锁需要在PMD表分配时调用ptdesc_pmd_ctor()，在释放时调
+用ptdesc_pmd_dtor()。
 
 分配通常发生在pmd_alloc_one()中，释放发生在pmd_free()和pmd_free_tlb()
 中，但要确保覆盖所有的PMD表分配/释放路径：即X86_PAE在pgd_alloc()中预先
@@ -73,7 +73,7 @@ PMD分页锁只有在你有两个以上的页表级别时才有意义。
 
 一切就绪后，你可以设置CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK。
 
-注意：pgtable_pte_page_ctor()和pgtable_pmd_page_ctor()可能失败--必
+注意：ptdesc_pte_ctor()和ptdesc_pmd_ctor()可能失败--必
 须正确处理。
 
 page->ptl
@@ -90,7 +90,7 @@ page->ptl用于访问分割页表锁，其中'page'是包含该表的页面struc
    的指针并动态分配它。这允许在启用DEBUG_SPINLOCK或DEBUG_LOCK_ALLOC的
    情况下使用分页锁，但由于间接访问而多花了一个缓存行。
 
-PTE表的spinlock_t分配在pgtable_pte_page_ctor()中，PMD表的spinlock_t
-分配在pgtable_pmd_page_ctor()中。
+PTE表的spinlock_t分配在ptdesc_pte_ctor()中，PMD表的spinlock_t
+分配在ptdesc_pmd_ctor()中。
 
 请不要直接访问page->ptl - -使用适当的辅助函数。
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cb136d2fdf74..e08638dc58cf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2858,11 +2858,6 @@ static inline bool ptdesc_pte_ctor(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline bool pgtable_pte_page_ctor(struct page *page)
-{
-	return ptdesc_pte_ctor(page_ptdesc(page));
-}
-
 static inline void ptdesc_pte_dtor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
@@ -2872,11 +2867,6 @@ static inline void ptdesc_pte_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
-static inline void pgtable_pte_page_dtor(struct page *page)
-{
-	ptdesc_pte_dtor(page_ptdesc(page));
-}
-
 #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
 ({							\
 	spinlock_t *__ptl = pte_lockptr(mm, pmd);	\
@@ -2967,11 +2957,6 @@ static inline bool ptdesc_pmd_ctor(struct ptdesc *ptdesc)
 	return true;
 }
 
-static inline bool pgtable_pmd_page_ctor(struct page *page)
-{
-	return ptdesc_pmd_ctor(page_ptdesc(page));
-}
-
 static inline void ptdesc_pmd_dtor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
@@ -2981,11 +2966,6 @@ static inline void ptdesc_pmd_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
-static inline void pgtable_pmd_page_dtor(struct page *page)
-{
-	ptdesc_pmd_dtor(page_ptdesc(page));
-}
-
 /*
  * No scalability reason to split PUD locks yet, but follow the same pattern
  * as the PMD locks to make it easier if we decide to.  The VM should not be
-- 
2.39.2

