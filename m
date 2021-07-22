Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0378E3D2E36
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 22:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhGVUMr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 16:12:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:54377 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231297AbhGVUM1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 16:12:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="275560603"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="275560603"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:53:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="502035481"
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
Subject: [PATCH v28 18/32] mm: Add guard pages around a shadow stack.
Date:   Thu, 22 Jul 2021 13:52:05 -0700
Message-Id: <20210722205219.7934-19-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210722205219.7934-1-yu-cheng.yu@intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

INCSSP(Q/D) increments shadow stack pointer and 'pops and discards' the
first and the last elements in the range, effectively touches those memory
areas.

The maximum moving distance by INCSSPQ is 255 * 8 = 2040 bytes and
255 * 4 = 1020 bytes by INCSSPD.  Both ranges are far from PAGE_SIZE.
Thus, putting a gap page on both ends of a shadow stack prevents INCSSP,
CALL, and RET from going beyond.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v25:
- Move SHADOW_STACK_GUARD_GAP to arch/x86/mm/mmap.c.

v24:
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
index 4548f75cef14..354f38d21eed 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2729,6 +2729,7 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }
 
+#ifndef vm_start_gap
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_start = vma->vm_start;
@@ -2740,7 +2741,9 @@ static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 	}
 	return vm_start;
 }
+#endif
 
+#ifndef vm_end_gap
 static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_end = vma->vm_end;
@@ -2752,6 +2755,7 @@ static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
 	}
 	return vm_end;
 }
+#endif
 
 static inline unsigned long vma_pages(struct vm_area_struct *vma)
 {
-- 
2.21.0

