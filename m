Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E15761A45B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiKDWlI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKDWkK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:40:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03D243AE2;
        Fri,  4 Nov 2022 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601574; x=1699137574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8jsAS8647WvaR/jj/jAxKS3gRgPtSsCKGZz+X7gLR1o=;
  b=hxvqphCQSCjS35NnftYr9QjHGkghCOg3XAstdgT/12tf30bdqcppV9qi
   z/LpepMAErUs6HRCtHzlmXoLCQ/CQAJxCroB5Uo4huIx6CGZfdKPHn47A
   V2SE3Dz0myWAbR/3A6wprxiFcqd8IcoCCuHfQfH3T7Ah7i4a/byZFkOYv
   oQrLoS5fIQXD80lEK7fD3pV7aL4Nramoi8t+fbKyYP81rNKOovFXZSjFi
   wIFNxEvl9WAozBPQI2Ie9a6G7Yg642UyqMgy9hl1d2gMwxrWdLjMXg66/
   X30WSUvz7yYOWhHQdcO9KqReC+MpiywW2K8Dqzy+hPQJwdF5+DcDROEwd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840521"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840521"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668514033"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668514033"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:32 -0700
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
Subject: [PATCH v3 12/37] x86/mm: Update ptep_set_wrprotect() and pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Date:   Fri,  4 Nov 2022 15:35:39 -0700
Message-Id: <20221104223604.29615-13-rick.p.edgecombe@intel.com>
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

When Shadow Stack is in use, Write=0,Dirty=1 PTE are reserved for shadow
stack. Copy-on-write PTes then have Write=0,Cow=1.

When a PTE goes from Write=1,Dirty=1 to Write=0,Cow=1, it could
become a transient shadow stack PTE in two cases:

The first case is that some processors can start a write but end up seeing
a Write=0 PTE by the time they get to the Dirty bit, creating a transient
shadow stack PTE. However, this will not occur on processors supporting
Shadow Stack, and a TLB flush is not necessary.

The second case is that when _PAGE_DIRTY is replaced with _PAGE_COW non-
atomically, a transient shadow stack PTE can be created as a result.
Thus, prevent that with cmpxchg.

In the case of pmdp_set_wrprotect(), for nopmd configs the ->pmd operated
on does not exist and the logic would need to be different. Although the
extra functionality will normally be optimized out when user shadow
stacks are not configured, also exclude it in the preprocessor stage so
that it will still compile. User shadow stack is not supported there by
Linux anyway. Leave the cpu_feature_enabled() check so that the
functionality also disables based on runtime detection of the feature.

Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
insights to the issue. Jann Horn provided the cmpxchg solution.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v3:
 - Remove unnecessary #ifdef (Dave Hansen)

v2:
 - Compile out some code due to clang build error
 - Clarify commit log (dhansen)
 - Normalize PTE bit descriptions between patches (dhansen)
 - Update comment with text from (dhansen)

Yu-cheng v30:
 - Replace (pmdval_t) cast with CONFIG_PGTABLE_LEVELES > 2 (Borislav Petkov).

 arch/x86/include/asm/pgtable.h | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 81f388a5a5ab..f252c42f3ca1 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1289,6 +1289,21 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
+	/*
+	 * Avoid accidentally creating shadow stack PTEs
+	 * (Write=0,Dirty=1).  Use cmpxchg() to prevent races with
+	 * the hardware setting Dirty=1.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK)) {
+		pte_t old_pte, new_pte;
+
+		old_pte = READ_ONCE(*ptep);
+		do {
+			new_pte = pte_wrprotect(old_pte);
+		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
+
+		return;
+	}
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
 }
 
@@ -1341,6 +1356,26 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp)
 {
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+	/*
+	 * If Shadow Stack is enabled, pmd_wrprotect() moves _PAGE_DIRTY
+	 * to _PAGE_COW (see comments at pmd_wrprotect()).
+	 * When a thread reads a RW=1, Dirty=0 PMD and before changing it
+	 * to RW=0, Dirty=0, another thread could have written to the page
+	 * and the PMD is RW=1, Dirty=1 now.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK)) {
+		pmd_t old_pmd, new_pmd;
+
+		old_pmd = READ_ONCE(*pmdp);
+		do {
+			new_pmd = pmd_wrprotect(old_pmd);
+		} while (!try_cmpxchg(&pmdp->pmd, &old_pmd.pmd, new_pmd.pmd));
+
+		return;
+	}
+#endif
+
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
 }
 
-- 
2.17.1

