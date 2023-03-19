Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F516BFE47
	for <lists+linux-arch@lfdr.de>; Sun, 19 Mar 2023 01:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCSATz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Mar 2023 20:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCSATM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Mar 2023 20:19:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024AE298F6;
        Sat, 18 Mar 2023 17:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679185073; x=1710721073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HJSW741k8aVu5mpNpwjQ9huZphqr/UOu519JqYv/Vlg=;
  b=IpaEJuhLf+pVg6obEAOlrCI/MUkoaMPFa6Ly6guupQgA9tuJjbG2oeO1
   n/OvfgNpv0Sqe7joxxir5AlvFvyKTKw5aSElVqB0DekTyXcjQGHhnEvLv
   +nTYxIpF93ITmRbRErk0TuoZFu+rEySMqwaLvUfBf2B8OAYrXZK8WTP7p
   xvgIiC97+ly3Tavy2eyn1X+eBm5Ry2+4YIWC1Uh/HgLep6cH2ksFJrgJj
   ks7FSlR0BaxiaQ+iEaaU59uanIfZeqFO6di5G6YXbL+/5z/oIEuSPEUHW
   XukbzNx6jWqwXOtzINn94pSiUf5C47WgJO6qZNZdKMVr3ReGySFylQ7hA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="338491163"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="338491163"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="749672862"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="749672862"
Received: from bmahatwo-mobl1.gar.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.135.34.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:26 -0700
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v8 20/40] x86/mm: Teach pte_mkwrite() about stack memory
Date:   Sat, 18 Mar 2023 17:15:15 -0700
Message-Id: <20230319001535.23210-21-rick.p.edgecombe@intel.com>
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

If a VMA has the VM_SHADOW_STACK flag, it is shadow stack memory. So
when it is made writable with pte_mkwrite(), it should create shadow
stack memory, not conventionally writable memory. Now that all the places
where shadow stack memory might be created pass a VMA into pte_mkwrite(),
it can know when it should do this.

So make pte_mkwrite() create shadow stack memory when the VMA has the
VM_SHADOW_STACK flag. Do the same thing for pmd_mkwrite().

This requires referencing VM_SHADOW_STACK in these functions, which are
currently defined in pgtable.h, however mm.h (where VM_SHADOW_STACK is
located) can't be pulled in without causing problems for files that
reference pgtable.h. So also move pte/pmd_mkwrite() into pgtable.c, where
they can safely reference VM_SHADOW_STACK.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Deepak Gupta <debug@rivosinc.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v8:
 - Update commit log verbiage (Boris)

v6:
 - New patch
---
 arch/x86/include/asm/pgtable.h | 20 ++------------------
 arch/x86/mm/pgtable.c          | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 05dfdbdf96b4..d81e7ec27507 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -456,15 +456,7 @@ static inline pte_t pte_mkwrite_kernel(pte_t pte)
 
 struct vm_area_struct;
 
-static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
-{
-	pte = pte_mkwrite_kernel(pte);
-
-	if (pte_dirty(pte))
-		pte = pte_clear_saveddirty(pte);
-
-	return pte;
-}
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
 
 static inline pte_t pte_mkhuge(pte_t pte)
 {
@@ -601,15 +593,7 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pmd_set_flags(pmd, _PAGE_ACCESSED);
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
-{
-	pmd = pmd_set_flags(pmd, _PAGE_RW);
-
-	if (pmd_dirty(pmd))
-		pmd = pmd_clear_saveddirty(pmd);
-
-	return pmd;
-}
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
 static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
 {
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index e4f499eb0f29..98856bcc8102 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -880,3 +880,29 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 #endif /* CONFIG_X86_64 */
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
+
+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pte_mkwrite_shstk(pte);
+
+	pte = pte_mkwrite_kernel(pte);
+
+	if (pte_dirty(pte))
+		pte = pte_clear_saveddirty(pte);
+
+	return pte;
+}
+
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return pmd_mkwrite_shstk(pmd);
+
+	pmd = pmd_set_flags(pmd, _PAGE_RW);
+
+	if (pmd_dirty(pmd))
+		pmd = pmd_clear_saveddirty(pmd);
+
+	return pmd;
+}
-- 
2.17.1

