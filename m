Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161382890F1
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 20:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390488AbgJISdd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 14:33:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:9542 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390464AbgJISdW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 14:33:22 -0400
IronPort-SDR: YWrPIKZpIMUGD55LLsDYPoe2zECRKJexQ82E+wtd37GloQOhBIyLLzF6pH1RBQbz7H0/Haat9C
 4+jOiNehfidw==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="164736622"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="164736622"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:22 -0700
IronPort-SDR: kwqnonbsJTBKvJ1u/MPsZ7qKVw2rupj2KDzxzltIKru8fra2WhgDj8Wmu0wolWM/MgNw5jfCIp
 119yCIcITC1w==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="529031183"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:21 -0700
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
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v14 16/26] mm: Add guard pages around a shadow stack.
Date:   Fri,  9 Oct 2020 11:32:20 -0700
Message-Id: <20201009183230.26717-17-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201009183230.26717-1-yu-cheng.yu@intel.com>
References: <20201009183230.26717-1-yu-cheng.yu@intel.com>
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

v10:
- Define ARCH_SHADOW_STACK_GUARD_GAP.
---
 arch/x86/include/asm/processor.h | 10 ++++++++++
 include/linux/mm.h               | 24 ++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 97143d87994c..01acbd63cad8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -840,6 +840,16 @@ static inline void spin_lock_prefetch(const void *x)
 #define STACK_TOP		TASK_SIZE_LOW
 #define STACK_TOP_MAX		TASK_SIZE_MAX
 
+/*
+ * Shadow stack pointer is moved by CALL, JMP, and INCSSP(Q/D).  INCSSPQ
+ * moves shadow stack pointer up to 255 * 8 = ~2 KB (~1KB for INCSSPD) and
+ * touches the first and the last element in the range, which triggers a
+ * page fault if the range is not in a shadow stack.  Because of this,
+ * creating 4-KB guard pages around a shadow stack prevents these
+ * instructions from going beyond.
+ */
+#define ARCH_SHADOW_STACK_GUARD_GAP PAGE_SIZE
+
 #define INIT_THREAD  {						\
 	.addr_limit		= KERNEL_DS,			\
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4f6305106feb..ce461795fd8b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2615,6 +2615,10 @@ extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
 int __must_check write_one_page(struct page *page);
 void task_dirty_inc(struct task_struct *tsk);
 
+#ifndef ARCH_SHADOW_STACK_GUARD_GAP
+#define ARCH_SHADOW_STACK_GUARD_GAP 0
+#endif
+
 extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
@@ -2647,9 +2651,15 @@ static inline struct vm_area_struct * find_vma_intersection(struct mm_struct * m
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_start = vma->vm_start;
+	unsigned long gap = 0;
 
-	if (vma->vm_flags & VM_GROWSDOWN) {
-		vm_start -= stack_guard_gap;
+	if (vma->vm_flags & VM_GROWSDOWN)
+		gap = stack_guard_gap;
+	else if (vma->vm_flags & VM_SHSTK)
+		gap = ARCH_SHADOW_STACK_GUARD_GAP;
+
+	if (gap != 0) {
+		vm_start -= gap;
 		if (vm_start > vma->vm_start)
 			vm_start = 0;
 	}
@@ -2659,9 +2669,15 @@ static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_end = vma->vm_end;
+	unsigned long gap = 0;
+
+	if (vma->vm_flags & VM_GROWSUP)
+		gap = stack_guard_gap;
+	else if (vma->vm_flags & VM_SHSTK)
+		gap = ARCH_SHADOW_STACK_GUARD_GAP;
 
-	if (vma->vm_flags & VM_GROWSUP) {
-		vm_end += stack_guard_gap;
+	if (gap != 0) {
+		vm_end += gap;
 		if (vm_end < vma->vm_end)
 			vm_end = -PAGE_SIZE;
 	}
-- 
2.21.0

