Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CFA72D5C5
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbjFMAMa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbjFMAMZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:12:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AAE1996;
        Mon, 12 Jun 2023 17:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615139; x=1718151139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m52H3JZHS5dKvCQFGYyapfckCiGOGTRhvdDeSntBBxk=;
  b=QY28iBE1VRwIzr0w1+d1sPUyhwOeLbtzUqxmISgNndXNT8KXB+rmz4MG
   nEpBMDa1hMXmF0tm/naPI4x8811U9wPlZzw/w1R1q7TZnn4fb1vbT9HDl
   0Fr/MY8kSvDWeJnFrPMrgivTbTcVrI4/QVo5WafbE/II+DSA/rUvi1LJF
   ARapMg4l5qGppyWqsVO1mnDEOrLWIrGxmEPGdRKRwJagiVWDjDUHk/qHk
   uOzeWvVb9VPd0qgsSXkCRKqQgU15spXPqPIh34NCpo4+dEinnJyog9jVh
   oNco9BeRWA0AF/Om/StG6V+JDnEZp2uwHKHi/JgFNDmmT85cp5P9x8QV5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361556890"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361556890"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671009"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671009"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:16 -0700
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
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v9 11/42] x86/mm: Update ptep/pmdp_set_wrprotect() for _PAGE_SAVED_DIRTY
Date:   Mon, 12 Jun 2023 17:10:37 -0700
Message-Id: <20230613001108.3040476-12-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
   transient shadow stack PTE can be created as a result.

Prevent the second case when doing a write protection and Dirty->SavedDirty
shift at the same time with a CMPXCHG loop. The first case

Note, in the PAE case CMPXCHG will need to operate on 8 byte, but
try_cmpxchg() will not use CMPXCHG8B, so it cannot operate on a full PAE
PTE. However the exiting logic is not operating on a full 8 byte region
either, and relies on the fact that the Write bit is in the first 4
bytes when doing the clear_bit(). Since both the Dirty, SavedDirty and
Write bits are in the first 4 bytes, casting to a long will be similar to
the existing behavior which also casts to a long.

Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
insights to the issue. Jann Horn provided the CMPXCHG solution.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v9:
 - Use bit shifting helpers that don't need any extra conditional
   logic. (Linus)
 - Always do the SavedDirty shifting (Linus)
---
 arch/x86/include/asm/pgtable.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a95f872c7429..99b54ab0a919 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1189,7 +1189,17 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
-	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
+	/*
+	 * Avoid accidentally creating shadow stack PTEs
+	 * (Write=0,Dirty=1).  Use cmpxchg() to prevent races with
+	 * the hardware setting Dirty=1.
+	 */
+	pte_t old_pte, new_pte;
+
+	old_pte = READ_ONCE(*ptep);
+	do {
+		new_pte = pte_wrprotect(old_pte);
+	} while (!try_cmpxchg((long *)&ptep->pte, (long *)&old_pte, *(long *)&new_pte));
 }
 
 #define flush_tlb_fix_spurious_fault(vma, address, ptep) do { } while (0)
@@ -1241,7 +1251,17 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp)
 {
-	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
+	/*
+	 * Avoid accidentally creating shadow stack PTEs
+	 * (Write=0,Dirty=1).  Use cmpxchg() to prevent races with
+	 * the hardware setting Dirty=1.
+	 */
+	pmd_t old_pmd, new_pmd;
+
+	old_pmd = READ_ONCE(*pmdp);
+	do {
+		new_pmd = pmd_wrprotect(old_pmd);
+	} while (!try_cmpxchg((long *)pmdp, (long *)&old_pmd, *(long *)&new_pmd));
 }
 
 #ifndef pmdp_establish
-- 
2.34.1

