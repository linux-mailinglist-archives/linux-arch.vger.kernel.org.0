Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEF23D2E32
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 22:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhGVUMq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 16:12:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:54375 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231289AbhGVUM1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 16:12:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="275560599"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="275560599"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:53:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="502035476"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:53:01 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v28 17/32] mm: Fixup places that call pte_mkwrite() directly
Date:   Thu, 22 Jul 2021 13:52:04 -0700
Message-Id: <20210722205219.7934-18-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210722205219.7934-1-yu-cheng.yu@intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When serving a page fault, maybe_mkwrite() makes a PTE writable if it is in
a writable vma.  A shadow stack vma is writable, but its PTEs need
_PAGE_DIRTY to be set to become writable.  For this reason, maybe_mkwrite()
has been updated.

There are a few places that call pte_mkwrite() directly, but have the
same result as from maybe_mkwrite().  These sites need to be updated for
shadow stack as well.  Thus, change them to maybe_mkwrite():

- do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE directly
  and call pte_mkwrite(), which is the same as maybe_mkwrite().  Change
  them to maybe_mkwrite().

- In do_numa_page(), if the numa entry was writable, then pte_mkwrite()
  is called directly.  Fix it by doing maybe_mkwrite().  Make the same
  changes to do_huge_pmd_numa_page().

- In change_pte_range(), pte_mkwrite() is called directly.  Replace it with
  maybe_mkwrite().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v25:
- Apply same changes to do_huge_pmd_numa_page() as to do_numa_page().

 mm/huge_memory.c | 2 +-
 mm/memory.c      | 5 ++---
 mm/migrate.c     | 3 +--
 mm/mprotect.c    | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c8dd5913884e..b9a6fc7af693 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1515,7 +1515,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
 	pmd = pmd_mkyoung(pmd);
 	if (was_writable)
-		pmd = pmd_mkwrite(pmd);
+		pmd = maybe_pmd_mkwrite(pmd, vma);
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	spin_unlock(vmf->ptl);
diff --git a/mm/memory.c b/mm/memory.c
index 747a01d495f2..c82a8f38fb04 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3781,8 +3781,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	entry = mk_pte(page, vma->vm_page_prot);
 	entry = pte_sw_mkyoung(entry);
-	if (vma->vm_flags & VM_WRITE)
-		entry = pte_mkwrite(pte_mkdirty(entry));
+	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
@@ -4407,7 +4406,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 	pte = pte_mkyoung(pte);
 	if (was_writable)
-		pte = pte_mkwrite(pte);
+		pte = maybe_mkwrite(pte, vma);
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
diff --git a/mm/migrate.c b/mm/migrate.c
index 34a9ad3e0a4f..f8c1ce0c187b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2794,8 +2794,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		}
 	} else {
 		entry = mk_pte(page, vma->vm_page_prot);
-		if (vma->vm_flags & VM_WRITE)
-			entry = pte_mkwrite(pte_mkdirty(entry));
+		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	}
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 883e2cc85cad..9b424f2fd3a9 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -135,7 +135,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			if (dirty_accountable && pte_dirty(ptent) &&
 					(pte_soft_dirty(ptent) ||
 					 !(vma->vm_flags & VM_SOFTDIRTY))) {
-				ptent = pte_mkwrite(ptent);
+				ptent = maybe_mkwrite(ptent, vma);
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			pages++;
-- 
2.21.0

