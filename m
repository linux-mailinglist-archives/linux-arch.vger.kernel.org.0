Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C9264125A
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiLCAjy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiLCAi5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:38:57 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2C2FF812;
        Fri,  2 Dec 2022 16:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027844; x=1701563844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=5fQPilj2pCPckJowlDuif3gKg3nQuarhXSyucpbcgNM=;
  b=HCwZl4W/fi27609ejETMFt9TiTfz8MaBCETJKC9VB5GqfBpcYib+DgHN
   2WkNfJhweC+vxsrybg76TEMAOsAMtz/CS745S1CZaj1ubb8uVLsyz5OuU
   ppSrOS3KLkwXTB8zuz+b4cNv/2oDhM7L9Em3M2fOmnV23Dq5WAsqjD5Gs
   eW0Up1leAKG8ekSTsAiA+uG8j8gyW1pSePwtG3A4aCFCGjlb4oQ1t7cXR
   5u0mzOFlD1j64EYWgmQWHwMAwFNBcRKZ2EtTEUjgNiyx6eipTnnejUES8
   ZxQ8xYr/QRwDF1qSIlBir0zjK/8D7ea9RHUHzWp0100Xq47ETO6sXYYy9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313711087"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313711087"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479898"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479898"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:11 -0800
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
Subject: [PATCH v4 18/39] mm: Fixup places that call pte_mkwrite() directly
Date:   Fri,  2 Dec 2022 16:35:45 -0800
Message-Id: <20221203003606.6838-19-rick.p.edgecombe@intel.com>
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
   shadow stack VMA's won't be VM_SHARED, so it is not nessary.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---

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
index e4530b39f378..a89dfa9174ae 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -918,6 +918,9 @@ static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 }
 #endif  /* CONFIG_PAGE_TABLE_ISOLATION */
 
+#define is_shstk_write is_shstk_write
+extern bool is_shstk_write(unsigned long vm_flags);
+
 #endif	/* __ASSEMBLY__ */
 
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 8525f2876fb4..f0e536bea3ca 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -876,3 +876,9 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 #endif /* CONFIG_X86_64 */
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
+
+bool is_shstk_write(unsigned long vm_flags)
+{
+	return (vm_flags & (VM_SHADOW_STACK | VM_WRITE)) ==
+	       (VM_SHADOW_STACK | VM_WRITE);
+}
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index d8096578610a..b4a9d9936463 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1586,6 +1586,13 @@ static inline bool arch_has_pfn_modify_check(void)
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
index 8a6d5c823f91..c02b6421241d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4128,7 +4128,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
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
index 3a8ff47943d5..1f6d102d069b 100644
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
@@ -83,9 +84,12 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
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

