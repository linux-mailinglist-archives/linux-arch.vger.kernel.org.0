Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2559872D5F2
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbjFMAPG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbjFMAN3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:13:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2F91BD4;
        Mon, 12 Jun 2023 17:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615154; x=1718151154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dhZWE6YTdZ+FD9PI/U6uJC2MaFgGrtV9CcOxkJ3S4o4=;
  b=nKs6GDAfAmXL3lLEMiSLw4dNNNs7s5A0Stx5EeIE6X9n4SO805ioHHFN
   eFUI+pVLjs79BDazntQy/EVRVkoXCZsQXPey8yNjshgQxvR8UJTzwrbJO
   Ug4HNzoqjKRYyB2akgYKDOzPKJPxdvNEL6vMEdPTlKs/nv+4KxDu6IuxP
   aHrC41y37agZj2bNv7iNNls1mG0Bw2Xxtdi873dw8akSgzFl6dhDDUhWx
   jTikhY5vmUOvOyOPnYoOPRbSh+CagAtYlIdcB/vd3Sg46JvauC+3ycJYZ
   C30ZZJrDXSYoBb4IVhQs6I8z12z07fgXjHPw7LOplyOal1i72UTeoQ5kT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361557047"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361557047"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671035"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671035"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:21 -0700
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
Cc:     rick.p.edgecombe@intel.com, Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v9 17/42] mm: Warn on shadow stack memory in wrong vma
Date:   Mon, 12 Jun 2023 17:10:43 -0700
Message-Id: <20230613001108.3040476-18-rick.p.edgecombe@intel.com>
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
but should have decent coverage.

In order to check if a PTE is shadow stack in core mm code, add two arch
breakouts arch_check_zapped_pte/pmd(). This will allow shadow stack
specific code to be kept in arch/x86.

Only do the check if shadow stack is supported by the CPU and configured
because in rare cases older CPUs may write Dirty=1 to a Write=0 CPU on
older CPUs. This check is handled in pte_shstk()/pmd_shstk().

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v9:
 - Add comments about not doing the check on non-shadow stack CPUs
---
 arch/x86/include/asm/pgtable.h |  6 ++++++
 arch/x86/mm/pgtable.c          | 20 ++++++++++++++++++++
 include/linux/pgtable.h        | 14 ++++++++++++++
 mm/huge_memory.c               |  1 +
 mm/memory.c                    |  1 +
 5 files changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index d8724f5b1202..89cfa93d0ad6 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1664,6 +1664,12 @@ static inline bool arch_has_hw_pte_young(void)
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
index 0ad2c62ac0a8..101e721d74aa 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -894,3 +894,23 @@ pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 
 	return pmd_clear_saveddirty(pmd);
 }
+
+void arch_check_zapped_pte(struct vm_area_struct *vma, pte_t pte)
+{
+	/*
+	 * Hardware before shadow stack can (rarely) set Dirty=1
+	 * on a Write=0 PTE. So the below condition
+	 * only indicates a software bug when shadow stack is
+	 * supported by the HW. This checking is covered in
+	 * pte_shstk().
+	 */
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
+			pte_shstk(pte));
+}
+
+void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd)
+{
+	/* See note in arch_check_zapped_pte() */
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
+			pmd_shstk(pmd));
+}
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 0f3cf726812a..feb1fd2c814f 100644
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
index 37dd56b7b3d1..c3cc20c1b26c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1681,6 +1681,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 */
 	orig_pmd = pmdp_huge_get_and_clear_full(vma, addr, pmd,
 						tlb->fullmm);
+	arch_check_zapped_pmd(vma, orig_pmd);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 	if (vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
diff --git a/mm/memory.c b/mm/memory.c
index c1b6fe944c20..40c0b233b61d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1412,6 +1412,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				continue;
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
+			arch_check_zapped_pte(vma, ptent);
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
 						      ptent);
-- 
2.34.1

