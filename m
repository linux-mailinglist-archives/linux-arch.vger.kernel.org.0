Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0478861A455
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiKDWkr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiKDWkJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:40:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB26C42F78;
        Fri,  4 Nov 2022 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601572; x=1699137572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7RPrghckrOaEzYfVScgc7PDmuhgD0p+mb/96hlyTVUg=;
  b=GePPTV4oZJGLtTa0qlOmr7fBM8oH/rMsRg6YSHixgU0edWrP0PkWYBwT
   Gxcs+oGx5RYjPOp+QcpWhjawWMTDT7xu8WLfXlH3Wv6XP+aOJk4sQm4dG
   Glh0HRQhQZuzYwVDee+khmSq15T0ZGQjdYKL/HBlVMlWd8EwPg1fob4+6
   kMxNnE1vQ9IDMASvf0w/lQhu+/9UQ9bh3+Xzl2Ja/4ubrS+nspjIV5TFW
   etSmZJfgytY5+0iHxYxJUfiC4V1jI1KZ1oBn+g4UdeKcXPDgtCHs2HaZ7
   gslELfuj7M8Bhl/CBbFPArttSN4JIh8tBwV8wZVH7m+QRqp97MnmURNdP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840516"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840516"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:32 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668514028"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668514028"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:31 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v3 11/37] x86/mm: Update pte_modify for _PAGE_COW
Date:   Fri,  4 Nov 2022 15:35:38 -0700
Message-Id: <20221104223604.29615-12-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

The Write=0,Dirty=1 PTE has been used to indicate copy-on-write pages.
However, newer x86 processors also regard a Write=0,Dirty=1 PTE as a
shadow stack page. In order to separate the two, the software-defined
_PAGE_DIRTY is changed to _PAGE_COW for the copy-on-write case, and
pte_*() are updated to do this.

pte_modify() takes a "raw" pgprot_t which was not necessarily created
with any of the existing PTE bit helpers. That means that it can return a
pte_t with Write=0,Dirty=1, a shadow stack PTE, when it did not intend to
create one.

However pte_modify() changes a PTE to 'newprot', but it doesn't use the
pte_*(). Modify it to also move _PAGE_DIRTY to _PAGE_COW. Apply the same
changes to pmd_modify().

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v2:
 - Update commit log with text and suggestions from (Dave Hansen)
 - Drop fixup_dirty_pte() in favor of clearing the HW dirty bit along
   with the _PAGE_CHG_MASK masking, then calling pte_mkdirty() (Dave
   Hansen)

 arch/x86/include/asm/pgtable.h | 41 +++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index c284bb6f62a5..81f388a5a5ab 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -791,26 +791,55 @@ static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
+	pteval_t _page_chg_mask_no_dirty = _PAGE_CHG_MASK & ~_PAGE_DIRTY;
 	pteval_t val = pte_val(pte), oldval = val;
+	pte_t pte_result;
 
 	/*
 	 * Chop off the NX bit (if present), and add the NX portion of
 	 * the newprot (if present):
 	 */
-	val &= _PAGE_CHG_MASK;
-	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
+	val &= _page_chg_mask_no_dirty;
+	val |= check_pgprot(newprot) & ~_page_chg_mask_no_dirty;
 	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
-	return __pte(val);
+
+	pte_result = __pte(val);
+
+	/*
+	 * Dirty bit is not preserved above so it can be done
+	 * in a special way for the shadow stack case, where it
+	 * needs to set _PAGE_COW. pte_mkdirty() will do this in
+	 * the case of shadow stack.
+	 */
+	if (pte_dirty(pte))
+		pte_result = pte_mkdirty(pte_result);
+
+	return pte_result;
 }
 
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
+	pteval_t _hpage_chg_mask_no_dirty = _HPAGE_CHG_MASK & ~_PAGE_DIRTY;
 	pmdval_t val = pmd_val(pmd), oldval = val;
+	pmd_t pmd_result;
 
-	val &= _HPAGE_CHG_MASK;
-	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
+	val &= _hpage_chg_mask_no_dirty;
+	val |= check_pgprot(newprot) & ~_hpage_chg_mask_no_dirty;
 	val = flip_protnone_guard(oldval, val, PHYSICAL_PMD_PAGE_MASK);
-	return __pmd(val);
+
+
+	pmd_result = __pmd(val);
+
+	/*
+	 * Dirty bit is not preserved above so it can be done
+	 * specially for the shadow stack case. It needs to move
+	 * the HW dirty bit to the software COW bit. Set in the
+	 * result if it was set in the original value.
+	 */
+	if (pmd_dirty(pmd))
+		pmd_result = pmd_mkdirty(pmd_result);
+
+	return pmd_result;
 }
 
 /*
-- 
2.17.1

