Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64D138D0CB
	for <lists+linux-arch@lfdr.de>; Sat, 22 May 2021 00:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhEUWPB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 18:15:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:55677 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhEUWOm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 18:14:42 -0400
IronPort-SDR: 0mqObyhoNPTOzLz4Th+trVoYrGjj6W5wUvXK64VwViSsjX/lo08XMnnH5pyoI6M8vv//g7nvb6
 fSfIyA/e8QBA==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="201618771"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201618771"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:13:17 -0700
IronPort-SDR: 8bd7lh9NKYiTQjZUTitrmmHd/zI0AGAKB4v3xJs25TIipTb079bG84mHw4hdLZ549k4dbLjP5W
 ny2bCZYrteXA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441116205"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:13:17 -0700
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
        Haitao Huang <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v27 20/31] mm: Update can_follow_write_pte() for shadow stack
Date:   Fri, 21 May 2021 15:12:00 -0700
Message-Id: <20210521221211.29077-21-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210521221211.29077-1-yu-cheng.yu@intel.com>
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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
Cc: Kees Cook <keescook@chromium.org>
---
v26:
- Instead of passing vm_flags, pass down vma pointer to can_follow_write_*().

v25:
- Split long line into smaller ones.

v24:
- Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().

 mm/gup.c         | 16 ++++++++++++----
 mm/huge_memory.c | 16 ++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 0697134b6a12..432ba7ccf8ae 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -438,10 +438,18 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
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
@@ -484,7 +492,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	}
 	if ((flags & FOLL_NUMA) && pte_protnone(pte))
 		goto no_page;
-	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
+	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags, vma)) {
 		pte_unmap_unlock(ptep, ptl);
 		return NULL;
 	}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 819f6c32eb5b..99352caf7188 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1337,10 +1337,18 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
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
@@ -1353,7 +1361,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 
 	assert_spin_locked(pmd_lockptr(mm, pmd));
 
-	if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags))
+	if (flags & FOLL_WRITE && !can_follow_write_pmd(*pmd, flags, vma))
 		goto out;
 
 	/* Avoid dumping huge zero page */
-- 
2.21.0

