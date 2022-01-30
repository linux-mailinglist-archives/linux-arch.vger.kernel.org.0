Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474904A3A09
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356683AbiA3VWV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:22:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:52048 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356536AbiA3VWB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577721; x=1675113721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JTPyM8ZAgyeb9WCq9+VH3FXgpAXnWn1PijDxlRo5/Us=;
  b=Z16Y+Sd5+dXMjzc3qsc/NGUN8jNBXJx1Uph7z6lKaFV3BvoQFrW+ZCl5
   yOyXx45vmQzHVHAUjkATda6+Oequ09mOqPoXZpWXLDAYtnOlGGiXXon3/
   8H+Shnm2XjsSKhDfN5MxDIE/7ppqkb5I09oMZuirvLxrIc4EL/kJrYXpx
   bHgxcpUcHRAafF+MCp1pVVL9bfu9ZusrvyCniqbpHWqb3gSKpNnWOxwYx
   pnQLBiOUzVe9TJL2/dMIg6vsjSpxjEz6iGxLKotF4ufe9odt26iK9DbCw
   ya9CkKJaa7pH4dmngXs84Pndey8oAe7g4arM+NPxZVwB1Mht+2GKtiVwO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104942"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104942"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856812"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:59 -0800
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
Subject: [PATCH 18/35] mm: Add guard pages around a shadow stack.
Date:   Sun, 30 Jan 2022 13:18:21 -0800
Message-Id: <20220130211838.8382-19-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

INCSSP(Q/D) increments shadow stack pointer and 'pops and discards' the
first and the last elements in the range, effectively touches those memory
areas.

The maximum moving distance by INCSSPQ is 255 * 8 = 2040 bytes and
255 * 4 = 1020 bytes by INCSSPD.  Both ranges are far from PAGE_SIZE.
Thus, putting a gap page on both ends of a shadow stack prevents INCSSP,
CALL, and RET from going beyond.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---

Yu-cheng v25:
 - Move SHADOW_STACK_GUARD_GAP to arch/x86/mm/mmap.c.

Yu-cheng v24:
 - Instead changing vm_*_gap(), create x86-specific versions.

 arch/x86/include/asm/page_types.h |  7 +++++
 arch/x86/mm/mmap.c                | 46 +++++++++++++++++++++++++++++++
 include/linux/mm.h                |  4 +++
 3 files changed, 57 insertions(+)

diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index a506a411474d..e1533fdc08b4 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -73,6 +73,13 @@ bool pfn_range_is_mapped(unsigned long start_pfn, unsigned long end_pfn);
 
 extern void initmem_init(void);
 
+#define vm_start_gap vm_start_gap
+struct vm_area_struct;
+extern unsigned long vm_start_gap(struct vm_area_struct *vma);
+
+#define vm_end_gap vm_end_gap
+extern unsigned long vm_end_gap(struct vm_area_struct *vma);
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif	/* _ASM_X86_PAGE_DEFS_H */
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index f3f52c5e2fd6..81f9325084d3 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -250,3 +250,49 @@ bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
 		return false;
 	return true;
 }
+
+/*
+ * Shadow stack pointer is moved by CALL, RET, and INCSSP(Q/D).  INCSSPQ
+ * moves shadow stack pointer up to 255 * 8 = ~2 KB (~1KB for INCSSPD) and
+ * touches the first and the last element in the range, which triggers a
+ * page fault if the range is not in a shadow stack.  Because of this,
+ * creating 4-KB guard pages around a shadow stack prevents these
+ * instructions from going beyond.
+ */
+#define SHADOW_STACK_GUARD_GAP PAGE_SIZE
+
+unsigned long vm_start_gap(struct vm_area_struct *vma)
+{
+	unsigned long vm_start = vma->vm_start;
+	unsigned long gap = 0;
+
+	if (vma->vm_flags & VM_GROWSDOWN)
+		gap = stack_guard_gap;
+	else if (vma->vm_flags & VM_SHADOW_STACK)
+		gap = SHADOW_STACK_GUARD_GAP;
+
+	if (gap != 0) {
+		vm_start -= gap;
+		if (vm_start > vma->vm_start)
+			vm_start = 0;
+	}
+	return vm_start;
+}
+
+unsigned long vm_end_gap(struct vm_area_struct *vma)
+{
+	unsigned long vm_end = vma->vm_end;
+	unsigned long gap = 0;
+
+	if (vma->vm_flags & VM_GROWSUP)
+		gap = stack_guard_gap;
+	else if (vma->vm_flags & VM_SHADOW_STACK)
+		gap = SHADOW_STACK_GUARD_GAP;
+
+	if (gap != 0) {
+		vm_end += gap;
+		if (vm_end < vma->vm_end)
+			vm_end = -PAGE_SIZE;
+	}
+	return vm_end;
+}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b3cb3a17037b..e125358d7f75 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2797,6 +2797,7 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }
 
+#ifndef vm_start_gap
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_start = vma->vm_start;
@@ -2808,7 +2809,9 @@ static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 	}
 	return vm_start;
 }
+#endif
 
+#ifndef vm_end_gap
 static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_end = vma->vm_end;
@@ -2820,6 +2823,7 @@ static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
 	}
 	return vm_end;
 }
+#endif
 
 static inline unsigned long vma_pages(struct vm_area_struct *vma)
 {
-- 
2.17.1

