Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEAA6A4E40
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 23:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjB0WcL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 17:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjB0Wbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 17:31:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA0729E21;
        Mon, 27 Feb 2023 14:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677537102; x=1709073102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Pl+T1+xmSBSUgFqJaHPWJP+BmegywDM6GYKzVKSMXoQ=;
  b=WpAUs+LC/vw0mPAi93gkoF3qw07+xTbpkva4e9Wiv8NQvjFiBQU4wMYc
   SiphOKORA/bSv2e7xPIXhL/CbqQEXGy0jHrZHRRL+RF5LxxtsuR+/zdpA
   rYqUh1fxz35U+XROGRtZILtg8GgWsEzp7n2ukBrUfWKNBWac+h+mOX/Uq
   ObqzUnfkG2A02jBuKrXJKORMVbG2ifgW3YCs5H4rfRQpFZCBIVK3krJTn
   fGL1iQhkj5RwfO+GpE3B5hgiYPUy1Lonck7UTTeoqhuUctEyQBW6/+XNh
   eSqe80gRgwB8wpOywtXa32v9NvM8mCBoCsxggArdjbjECYZXCfQYJXxPr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313657398"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313657398"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="848024576"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="848024576"
Received: from leonqu-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.72.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:18 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v7 15/41] x86/mm: Update ptep/pmdp_set_wrprotect() for _PAGE_SAVED_DIRTY
Date:   Mon, 27 Feb 2023 14:29:31 -0800
Message-Id: <20230227222957.24501-16-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

When shadow stack is in use, Write=0,Dirty=1 PTE are preserved for
shadow stack. Copy-on-write PTEs then have Write=0,SavedDirty=1.

When a PTE goes from Write=1,Dirty=1 to Write=0,SavedDirty=1, it could
become a transient shadow stack PTE in two cases:

1. Some processors can start a write but end up seeing a Write=0 PTE by
   the time they get to the Dirty bit, creating a transient shadow stack
   PTE. However, this will not occur on processors supporting shadow
   stack, and a TLB flush is not necessary.

2. When _PAGE_DIRTY is replaced with _PAGE_SAVED_DIRTY non-atomically, a
   transient shadow stack PTE can be created as a result. Thus, prevent
   that with cmpxchg.

In the case of pmdp_set_wrprotect(), for nopmd configs the ->pmd operated
on does not exist and the logic would need to be different. Although the
extra functionality will normally be optimized out when user shadow
stacks are not configured, also exclude it in the preprocessor stage so
that it will still compile. User shadow stack is not supported there by
Linux anyway. Leave the cpu_feature_enabled() check so that the
functionality also gets disabled based on runtime detection of the
feature.

Similarly, compile it out in ptep_set_wrprotect() due to a clang warning
on i386. Like above, the code path should get optimized out on i386
since shadow stack is not supported on 32 bit kernels, but this makes
the compiler happy.

Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
insights to the issue. Jann Horn provided the cmpxchg solution.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
v6:
 - Fix comment and log to update for _PAGE_COW being replaced with
   _PAGE_SAVED_DIRTY.

v5:
 - Commit log verbiage and formatting (Boris)
 - Remove capitalization on shadow stack (Boris)
 - Fix i386 warning on recent clang

v3:
 - Remove unnecessary #ifdef (Dave Hansen)

v2:
 - Compile out some code due to clang build error
 - Clarify commit log (dhansen)
 - Normalize PTE bit descriptions between patches (dhansen)
 - Update comment with text from (dhansen)
---
 arch/x86/include/asm/pgtable.h | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7360783f2140..349fcab0405a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1192,6 +1192,23 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
+#ifdef CONFIG_X86_USER_SHADOW_STACK
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
+#endif
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
 }
 
@@ -1244,6 +1261,24 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp)
 {
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+	/*
+	 * Avoid accidentally creating shadow stack PTEs
+	 * (Write=0,Dirty=1).  Use cmpxchg() to prevent races with
+	 * the hardware setting Dirty=1.
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

