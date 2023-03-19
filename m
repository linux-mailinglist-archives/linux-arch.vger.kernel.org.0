Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F896BFE5E
	for <lists+linux-arch@lfdr.de>; Sun, 19 Mar 2023 01:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCSAVR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Mar 2023 20:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCSAUk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Mar 2023 20:20:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E6729164;
        Sat, 18 Mar 2023 17:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679185140; x=1710721140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hsI3rH3pI5zk+4z/rTXM9tpk9smi32a1UvWDoOYm7ZQ=;
  b=PqFoSa7/6Z5cmCTiu11VWoCfxMrMU7vhg/2XObKVjJqnOgzg6jK7DhBE
   drxJnb8txN/5olsNU5b1HANo7xjSuEn5034CLGrQEjjsvSxS6dY7GbmCu
   moIpbTw19UQvIjcWwZSHc7zdwS2mjrPQ/0/wxXSn31wvyAbeSbFc1piZt
   s5+IRz4CCzE1ZHmwyuqrTniDsUgghhm1o49mysE8CxtIgHs1HsXorl7XZ
   p+zaePi92v1DvIxzlH0iiRIBvY+4rcqHnjRGc1Xk2ZQ7xB1Yvg5ncXUFH
   pipP52qAgr5KQKiPZ0QXF2Bwgw9Wz3JVDG8r+ERVUkcJMl6x1k0YUoJl3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="338491306"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="338491306"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="749672895"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="749672895"
Received: from bmahatwo-mobl1.gar.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.135.34.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:36 -0700
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
Subject: [PATCH v8 26/40] mm: Warn on shadow stack memory in wrong vma
Date:   Sat, 18 Mar 2023 17:15:21 -0700
Message-Id: <20230319001535.23210-27-rick.p.edgecombe@intel.com>
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

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

One sharp edge is that PTEs that are both Write=0 and Dirty=1 are
treated as shadow by the CPU, but this combination used to be created by
the kernel on x86. Previous patches have changed the kernel to now avoid
creating these PTEs unless they are for shadow stack memory. In case any
missed corners of the kernel are still creating PTEs like this for
non-shadow stack memory, and to catch any re-introductions of the logic,
warn if any shadow stack PTEs (Write=0, Dirty=1) are found in non-shadow
stack VMAs when they are being zapped. This won't catch transient cases
but should have decent coverage. It will be compiled out when shadow
stack is not configured.

In order to check if a PTE is shadow stack in core mm code, add two arch
breakouts arch_check_zapped_pte/pmd(). This will allow shadow stack
specific code to be kept in arch/x86.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>

---
v8:
 - Update commit log verbaige (Boris)

v6:
 - Add arch breakout to remove shstk from core MM code.

v5:
 - Fix typo in commit log

v3:
 - New patch
---
 arch/x86/include/asm/pgtable.h |  6 ++++++
 arch/x86/mm/pgtable.c          | 12 ++++++++++++
 include/linux/pgtable.h        | 14 ++++++++++++++
 mm/huge_memory.c               |  1 +
 mm/memory.c                    |  1 +
 5 files changed, 34 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 2e3d8cca1195..e5b3dce0d9fe 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1684,6 +1684,12 @@ static inline bool arch_has_hw_pte_young(void)
 	return true;
 }
 
+#define arch_check_zapped_pte arch_check_zapped_pte
+void arch_check_zapped_pte(struct vm_area_struct *vma, pte_t pte);
+
+#define arch_check_zapped_pmd arch_check_zapped_pmd
+void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd);
+
 #ifdef CONFIG_XEN_PV
 #define arch_has_hw_nonleaf_pmd_young arch_has_hw_nonleaf_pmd_young
 static inline bool arch_has_hw_nonleaf_pmd_young(void)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 98856bcc8102..afab0bc7862b 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -906,3 +906,15 @@ pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 
 	return pmd;
 }
+
+void arch_check_zapped_pte(struct vm_area_struct *vma, pte_t pte)
+{
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
+			pte_shstk(pte));
+}
+
+void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd)
+{
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
+			pmd_shstk(pmd));
+}
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c63cd44777ec..4a8970b9fb11 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -291,6 +291,20 @@ static inline bool arch_has_hw_pte_young(void)
 }
 #endif
 
+#ifndef arch_check_zapped_pte
+static inline void arch_check_zapped_pte(struct vm_area_struct *vma,
+					 pte_t pte)
+{
+}
+#endif
+
+#ifndef arch_check_zapped_pmd
+static inline void arch_check_zapped_pmd(struct vm_area_struct *vma,
+					 pmd_t pmd)
+{
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index aaf815838144..24797be05fcb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1689,6 +1689,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 */
 	orig_pmd = pmdp_huge_get_and_clear_full(vma, addr, pmd,
 						tlb->fullmm);
+	arch_check_zapped_pmd(vma, orig_pmd);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 	if (vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
diff --git a/mm/memory.c b/mm/memory.c
index d0972d2d6f36..c953c2c4588c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1389,6 +1389,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
+			arch_check_zapped_pte(vma, ptent);
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
 						      ptent);
-- 
2.17.1

