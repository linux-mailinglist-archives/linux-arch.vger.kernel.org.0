Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA1576D155
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjHBPOe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjHBPOU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E80F30C0;
        Wed,  2 Aug 2023 08:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GMRZGVpnCMpBl9S2OQBEWBTvbiAjuCy5RfO1vOJbT6c=; b=cQkkaX9AAfT+d7aTl5ZlUwKXon
        wtvoBRn9/aedjqXlIbvq18fj1I3TJw2+Zzf0Vr5WnotPRXSumcCXfibnTrESIbosE2vYswfRzJAVa
        5H4yBKdcE98OVD6ZAzq2xzrvctgLTLNioAjG9q+h6IlZXBn2pr/rjY0+/1fkGPnTJNGjWwQwqp54d
        t4ypSDkHUZ53K1hqvfNIg17njSek0Kx0yJSgRxqmqJklyEUyXTmY4IFbNUXNPvbSrwInEp8yEwBZR
        c0y0PWV2FZa7GOSlSo0lATyq7uLmb+tmAxstsweGFfCCSbkM5AFqWZR7TQaEEkgi0+dczcR/0Sv1c
        3m1xnWGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDYB-00FflP-LZ; Wed, 02 Aug 2023 15:14:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v6 32/38] mm: Tidy up set_ptes definition
Date:   Wed,  2 Aug 2023 16:14:00 +0100
Message-Id: <20230802151406.3735276-33-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230802151406.3735276-1-willy@infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that all architectures are converted, we can remove the
PFN_PTE_SHIFT ifdef and we can define set_pte_at() unconditionally.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/pgtable.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 3fde0d5d1c29..9df42e4721fc 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -204,7 +204,6 @@ static inline int pmd_young(pmd_t pmd)
 #endif
 
 #ifndef set_ptes
-#ifdef PFN_PTE_SHIFT
 /**
  * set_ptes - Map consecutive pages to a contiguous range of addresses.
  * @mm: Address space to map the pages into.
@@ -234,13 +233,8 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	}
 	arch_leave_lazy_mmu_mode();
 }
-#ifndef set_pte_at
-#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
-#endif
 #endif
-#else
 #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
-#endif
 
 #ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 extern int ptep_set_access_flags(struct vm_area_struct *vma,
-- 
2.40.1

