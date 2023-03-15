Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7046BA6AC
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjCOFPP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjCOFPI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A98229415;
        Tue, 14 Mar 2023 22:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BuY0++zuEEGNdRYvMzcc0MIGd74y5or4vnxSMjxSxAU=; b=KO1zVLlGb/MzuwQDc6H5JGyaiM
        Rcd8vcHf9egA+FO/fneFm2txL7VYi7RGvKiYak65nKIhpMQYh5LYZ23GREoZnDyWUhfJJlzR6cz5E
        z8KN/MPG9T2jlYkxKrF4K33ud3w2oV4+pqBCVlhSddpm1HAiF2CpmpsGIOdC/zLyrNYNIlfh0c3aZ
        d8oO9am1dBH9CzW4W+jf64/ZJe6NYzB9er70DxS58dqSMTGNPqh16kMVXBx4aPUrzrc9zzT2eJ3eF
        zPkCTWdMjtaMHnvzt85vbQXvo/OnTpecryfD+3uwDbqVIpn8hor2cZSjxd3xuyKg5td/+gj7MpPeF
        RY1ek+SQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTO-00DYDX-87; Wed, 15 Mar 2023 05:14:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 31/36] mm: Tidy up set_ptes definition
Date:   Wed, 15 Mar 2023 05:14:39 +0000
Message-Id: <20230315051444.3229621-32-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230315051444.3229621-1-willy@infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that all architectures are converted, we can remove the
PFN_PTE_SHIFT ifdef and we can define set_pte_at() unconditionally.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pgtable.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a755fe94b4b4..a54b9197f2f2 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -173,7 +173,6 @@ static inline int pmd_young(pmd_t pmd)
 #endif
 
 #ifndef set_ptes
-#ifdef PFN_PTE_SHIFT
 /**
  * set_ptes - Map consecutive pages to a contiguous range of addresses.
  * @mm: Address space to map the pages into.
@@ -201,13 +200,8 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
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

