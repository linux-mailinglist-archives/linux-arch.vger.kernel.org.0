Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4136174DFBE
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjGJUp5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjGJUpG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:45:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F410D8;
        Mon, 10 Jul 2023 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zInuUFQyhX5p7DpW3QqqQDh+iQp8HWHqrOQDZ/8fecU=; b=h5hg1vuQKj8IikMBDz/QMQ5zbM
        BU94LS/OWLcKkW6MxRnbHPLCfyRZ2Lr6xBmEK9Rx6BXDSf1Sra6nL03pUpr/aTtubBUTbTjg4XQH+
        VdLL8HvPmHmq79BaL5uIRw16OPQJX1cm4deBVvW+FjCaqQha73lKU2GtIOfjnBeGaQnYkCRUB+4/G
        aYjSnWAwOzf+4ATQRUlE040bdRBIC74jAE4rASNqAsBSG2GrOBj/+eN1MgBa+07KdCQCYEQA7VSOI
        8V/56S2yFOPY+Hc8geU/XDl1km87/OOnNr1GGaCAOUC1zRM0wAZJVqzCjQWNAdN+VV2gt9Shqf+aI
        vZ94wgIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjU-00Euqu-P3; Mon, 10 Jul 2023 20:43:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v5 32/38] mm: Tidy up set_ptes definition
Date:   Mon, 10 Jul 2023 21:43:33 +0100
Message-Id: <20230710204339.3554919-33-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710204339.3554919-1-willy@infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index 22f48f9997d5..e2a0bd5941be 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -181,7 +181,6 @@ static inline int pmd_young(pmd_t pmd)
 #endif
 
 #ifndef set_ptes
-#ifdef PFN_PTE_SHIFT
 /**
  * set_ptes - Map consecutive pages to a contiguous range of addresses.
  * @mm: Address space to map the pages into.
@@ -209,13 +208,8 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
 	}
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
2.39.2

