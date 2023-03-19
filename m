Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AC16BFE33
	for <lists+linux-arch@lfdr.de>; Sun, 19 Mar 2023 01:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCSAS2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Mar 2023 20:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCSARy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Mar 2023 20:17:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB528D2B;
        Sat, 18 Mar 2023 17:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679185013; x=1710721013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bCew3mJcfQObTYD8BfRHQ7rk2S0psN/tr65S9eiRcMg=;
  b=Rph1UHcdY1SmqGbeMuGQQcaQuEZwG9pSmrL6KHICpg5jFrjF7/imRahT
   Ri0pwEXfu8LGp/cY7VOKMCBoikLJ5toT4zn0aZKJyGxNWpLIsN+SW7DTi
   s2oW+oVi2Y8QuQuMS7D1HeNWIW43fCrEoHEIKP9SU1LRissalx7fhAn8l
   DgVNGopLcVzPTbzx4HJJ3s9e7x6JcRHMnDSLBUExjfWA6bWsdHzio+VrG
   Wy7uLw8zJF6VDQMJw3xUJLywZqKo4kw/VVwmobN+o08oJzug7FFSB/Vj/
   wOZLsu9j9Wd0tqtTfHjalQWGgdALqF6cx1kaMKLGWVb1MtJf1IxvRThUw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="338491050"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="338491050"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="749672841"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="749672841"
Received: from bmahatwo-mobl1.gar.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.135.34.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:18 -0700
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
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 15/40] x86/mm: Update ptep/pmdp_set_wrprotect() for _PAGE_SAVED_DIRTY
Date:   Sat, 18 Mar 2023 17:15:10 -0700
Message-Id: <20230319001535.23210-16-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
References: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
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

