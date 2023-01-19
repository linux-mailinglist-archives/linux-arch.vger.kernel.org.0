Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB826744B0
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 22:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjASVh2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 16:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjASVfb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 16:35:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A569A259E;
        Thu, 19 Jan 2023 13:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674163619; x=1705699619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mm+/ZDL+/WIl4y++bICVeaKn86uLCgMEEZawTB+3rKc=;
  b=PMpO9Az+5sFWH+BMRmx3RFkQAGEH25D5e6AsgrAQnR9X/Xwhqeb0MwBL
   QwvfWbMG6dLGT/VQgH924UKAZ4bsXdQsCKyrJtFLFVQVGUd2Tib9YwI9V
   5jgYe43GmeAm8Pr9b6eyarvyax1MrP9uS0mdyT7BSddWokkeXnlZs4yCK
   kPQsiGPqUOvFqYMNMQjeMk+b4FrTSaqwKnw2uHw9bBJGwCMTBVBR+U0bl
   zTuH7p5I+PHgIOs+R2fiYA4JcKwdg7uAGbT6cDljmbZlDtAsLM3TyLui7
   y6HeE/amBzIp8yNUesrdS3VU1EE0wEJAIodm/6vU7B+dskbDkZndr39Hl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323119608"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323119608"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989139087"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="989139087"
Received: from hossain3-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.252.128.187])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:53 -0800
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
Subject: [PATCH v5 19/39] mm: Fixup places that call pte_mkwrite() directly
Date:   Thu, 19 Jan 2023 13:22:57 -0800
Message-Id: <20230119212317.8324-20-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

With the introduction of shadow stack memory there are two ways a pte can
be writable: regular writable memory and shadow stack memory.

In past patches, maybe_mkwrite() has been updated to apply pte_mkwrite()
or pte_mkwrite_shstk() depending on the VMA flag. This covers most cases
where a PTE is made writable. However, there are places where pte_mkwrite()
is called directly and the logic should now also create a shadow stack PTE
in the case of a shadow stack VMA.

- do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE
  directly and call pte_mkwrite(). Teach it about pte_mkwrite_shstk()

- When userfaultfd is creating a PTE after userspace handles the fault
  it calls pte_mkwrite() directly. Teach it about pte_mkwrite_shstk()

To make the code cleaner, introduce is_shstk_write() which simplifies
checking for VM_WRITE | VM_SHADOW_STACK together.

In other cases where pte_mkwrite() is called directly, the VMA will not
be VM_SHADOW_STACK, and so shadow stack memory should not be created.
 - In the case of pte_savedwrite(), shadow stack VMA's are excluded.
 - In the case of the "dirty_accountable" optimization in mprotect(),
   shadow stack VMA's won't be VM_SHARED, so it is not necessary.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---

v5:
 - Fix typo in commit log

v3:
 - Restore do_anonymous_page() that accidetally moved commits (Kirill)
 - Open code maybe_mkwrite() cases from v2, so the behavior doesn't change
   to mark that non-writable PTEs dirty. (Nadav)

v2:
 - Updated commit log with comment's from Dave Hansen
 - Dave also suggested (I understood) to maybe tweak vm_get_page_prot()
   to avoid having to call maybe_mkwrite(). After playing around with
   this I opted to *not* do this. Shadow stack memory memory is
   effectively writable, so having the default permissions be writable
   ended up mapping the zero page as writable and other surprises. So
   creating shadow stack memory needs to be done with manual logic
   like pte_mkwrite().
 - Drop change in change_pte_range() because it couldn't actually trigger
   for shadow stack VMAs.
 - Clarify reasoning for skipped cases of pte_mkwrite().

Yu-cheng v25:
 - Apply same changes to do_huge_pmd_numa_page() as to do_numa_page().

 arch/x86/include/asm/pgtable.h |  3 +++
 arch/x86/mm/pgtable.c          |  6 ++++++
 include/linux/pgtable.h        |  7 +++++++
 mm/memory.c                    |  5 ++++-
 mm/migrate_device.c            |  4 +++-
 mm/userfaultfd.c               | 10 +++++++---
 6 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 45b1a8f058fe..87d3068734ec 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -951,6 +951,9 @@ static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 }
 #endif  /* CONFIG_PAGE_TABLE_ISOLATION */
 
+#define is_shstk_write is_shstk_write
+extern bool is_shstk_write(unsigned long vm_flags);
+
 #endif	/* __ASSEMBLY__ */
 
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index e4f499eb0f29..d103945ba502 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -880,3 +880,9 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 #endif /* CONFIG_X86_64 */
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
+
+bool is_shstk_write(unsigned long vm_flags)
+{
+	return (vm_flags & (VM_SHADOW_STACK | VM_WRITE)) ==
+	       (VM_SHADOW_STACK | VM_WRITE);
+}
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 14a820a45a37..49ce1f055242 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1578,6 +1578,13 @@ static inline bool arch_has_pfn_modify_check(void)
 }
 #endif /* !_HAVE_ARCH_PFN_MODIFY_ALLOWED */
 
+#ifndef is_shstk_write
+static inline bool is_shstk_write(unsigned long vm_flags)
+{
+	return false;
+}
+#endif
+
 /*
  * Architecture PAGE_KERNEL_* fallbacks
  *
diff --git a/mm/memory.c b/mm/memory.c
index aad226daf41b..5e5107232a26 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4088,7 +4088,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	entry = mk_pte(page, vma->vm_page_prot);
 	entry = pte_sw_mkyoung(entry);
-	if (vma->vm_flags & VM_WRITE)
+
+	if (is_shstk_write(vma->vm_flags))
+		entry = pte_mkwrite_shstk(pte_mkdirty(entry));
+	else if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry));
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 721b2365dbca..53d417683e01 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -645,7 +645,9 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 			goto abort;
 		}
 		entry = mk_pte(page, vma->vm_page_prot);
-		if (vma->vm_flags & VM_WRITE)
+		if (is_shstk_write(vma->vm_flags))
+			entry = pte_mkwrite_shstk(pte_mkdirty(entry));
+		else if (vma->vm_flags & VM_WRITE)
 			entry = pte_mkwrite(pte_mkdirty(entry));
 	}
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0499907b6f1a..832f0250ca61 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -63,6 +63,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	int ret;
 	pte_t _dst_pte, *dst_pte;
 	bool writable = dst_vma->vm_flags & VM_WRITE;
+	bool shstk = dst_vma->vm_flags & VM_SHADOW_STACK;
 	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
 	bool page_in_cache = page_mapping(page);
 	spinlock_t *ptl;
@@ -84,9 +85,12 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 		writable = false;
 	}
 
-	if (writable)
-		_dst_pte = pte_mkwrite(_dst_pte);
-	else
+	if (writable) {
+		if (shstk)
+			_dst_pte = pte_mkwrite_shstk(_dst_pte);
+		else
+			_dst_pte = pte_mkwrite(_dst_pte);
+	} else
 		/*
 		 * We need this to make sure write bit removed; as mk_pte()
 		 * could return a pte with write bit set.
-- 
2.17.1

