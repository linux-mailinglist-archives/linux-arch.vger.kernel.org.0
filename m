Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA5A641244
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiLCAis (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbiLCAhz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:37:55 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06337FB8B7;
        Fri,  2 Dec 2022 16:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027821; x=1701563821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mMUmCMQ2UpuIfMiP4n71ImLyKciupdTDYlrsPhVTKDs=;
  b=amCcSKnCNnD9eKsl8dqaLnknkLm6WjS38RqDJqNyuKmuvZ7mvlcXtx+R
   yG4l5Z20EWkQWPq5W86piPxsdzqj9JJ0DQmFKGpa9fBW2sSIS97xORznY
   7HxIo5JF+Vv+wWxFqD7gfvhWm4FjY3KKCVvzaACb3dpAXvtu00TrFWl3i
   U5pvNDdrQExZZLuM4rFXG7jdKjmcd4vtPuRCxbRxba17PPL1a/NQ732hn
   XX0HiD/WLPcx71R37rq5+aLyfGh7S8DcDL3jf2HjmF+ju24lRNpLq1wNw
   CuXgZz7sA5f8Su1dI3x4RTNl9xIiRt5nKVGoEoleCmFEpI15PQH1k4j20
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313710938"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313710938"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479830"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479830"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:36:57 -0800
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v4 12/39] x86/mm: Update ptep_set_wrprotect() and pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Date:   Fri,  2 Dec 2022 16:35:39 -0800
Message-Id: <20221203003606.6838-13-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 67bd2627c293..b68428099932 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1195,6 +1195,21 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
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
 
@@ -1247,6 +1262,26 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
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

