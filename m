Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293994A3A22
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356658AbiA3VYt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:24:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:52047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356511AbiA3VWT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577740; x=1675113740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=numCZyfka0OHXp22LK4zITWZGhKJw0SkYk203jreRnY=;
  b=dlM74cuDh7xu2MNg3+IJvLIAs2pYaU5sWnV/oj7ayaRERiOVcP8VZIA/
   TpTW4QNHGblvwiZF8j6vydljDAgwtO+MAdVLVJ0kx8hjYh1dETkVvbmYe
   6uVxz6o8DvdFqSA2/Kx0rhEkdGXj+V96NjC9317uPBunrImEdNRm6bF9v
   wG9l6pSrkxX9FwjWDekTrQXLsyCQL1l1xrxg3HwOIBKtOw8VabjaH7Soe
   fjy1UVFLONAFby32xi0ok4irb2BdUOftG5IBsVO3EV9zgOcZo84KImrOF
   MTGOkMkQphgjosl1TrT+yOf6H7nXroXF2yOSMKcMbV3qoNaCH9Nr/UfsV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104948"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104948"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856831"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:01 -0800
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 20/35] mm: Update can_follow_write_pte() for shadow stack
Date:   Sun, 30 Jan 2022 13:18:23 -0800
Message-Id: <20220130211838.8382-21-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Can_follow_write_pte() ensures a read-only page is COWed by checking the
FOLL_COW flag, and uses pte_dirty() to validate the flag is still valid.

Like a writable data page, a shadow stack page is writable, and becomes
read-only during copy-on-write, but it is always dirty.  Thus, in the
can_follow_write_pte() check, it belongs to the writable page case and
should be excluded from the read-only page pte_dirty() check.  Apply
the same changes to can_follow_write_pmd().

While at it, also split the long line into smaller ones.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---

Yu-cheng v26:
 - Instead of passing vm_flags, pass down vma pointer to can_follow_write_*().

Yu-cheng v25:
 - Split long line into smaller ones.

Yu-cheng v24:
 - Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().

 mm/gup.c         | 16 ++++++++++++----
 mm/huge_memory.c | 16 ++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f0af462ac1e2..95b7d1084c44 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -464,10 +464,18 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
  * FOLL_FORCE can write to even unwritable pte's, but only
  * after we've gone through a COW cycle and they are dirty.
  */
-static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
+static inline bool can_follow_write_pte(pte_t pte, unsigned int flags,
+					struct vm_area_struct *vma)
 {
-	return pte_write(pte) ||
-		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
+	if (pte_write(pte))
+		return true;
+	if ((flags & (FOLL_FORCE | FOLL_COW)) != (FOLL_FORCE | FOLL_COW))
+		return false;
+	if (!pte_dirty(pte))
+		return false;
+	if (is_shadow_stack_mapping(vma->vm_flags))
+		return false;
+	return true;
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
@@ -510,7 +518,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	}
 	if ((flags & FOLL_NUMA) && pte_protnone(pte))
 		goto no_page;
-	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
+	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags, vma)) {
 		pte_unmap_unlock(ptep, ptl);
 		return NULL;
 	}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3588e9fefbe0..1c7167e6f223 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1346,10 +1346,18 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
  * FOLL_FORCE can write to even unwritable pmd's, but only
  * after we've gone through a COW cycle and they are dirty.
  */
-static inline bool can_follow_write_pmd(pmd_t pmd, unsigned int flags)
+static inline bool can_follow_write_pmd(pmd_t pmd, unsigned int flags,
+					struct vm_area_struct *vma)
 {
-	return pmd_write(pmd) ||
-	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pmd_dirty(pmd));
+	if (pmd_write(pmd))
+		return true;
+	if ((flags & (FOLL_FORCE | FOLL_COW)) != (FOLL_FORCE | FOLL_COW))
+		return false;
+	if (!pmd_dirty(pmd))
+		return false;
+	if (is_shadow_stack_mapping(vma->vm_flags))
+		return false;
+	return true;
 }
 
 struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
@@ -1362,7 +1370,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 
 	assert_spin_locked(pmd_lockptr(mm, pmd));
 
-	if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags))
+	if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags, vma))
 		goto out;
 
 	/* Avoid dumping huge zero page */
-- 
2.17.1

