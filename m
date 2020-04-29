Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA11BEB8A
	for <lists+linux-arch@lfdr.de>; Thu, 30 Apr 2020 00:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgD2WIt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Apr 2020 18:08:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:61304 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgD2WIs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Apr 2020 18:08:48 -0400
IronPort-SDR: ptjlQfRhHAza6nTYZFyJqGKn9mXwfzRYamZ+GIHvCDdWkYJ4LI8TPBp4ICslRytIXIKDF+FhgE
 QZm2x7/oF5Pw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 15:08:47 -0700
IronPort-SDR: p9cb/Q7S4xMy86CCEwnBcUwsVAc9j+7g/RmTBGqUUnl02LUmjD+QYT5MjQ5SwiptTEaO4qAsJC
 62CDfEDdvf8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="276308893"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002.jf.intel.com with ESMTP; 29 Apr 2020 15:08:46 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v10 13/26] x86/mm: Shadow Stack page fault error checking
Date:   Wed, 29 Apr 2020 15:07:19 -0700
Message-Id: <20200429220732.31602-14-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200429220732.31602-1-yu-cheng.yu@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Shadow stack accesses are those that are performed by the CPU where it
expects to encounter a shadow stack mapping.  These accesses are performed
implicitly by CALL/RET at the site of the shadow stack pointer.  These
accesses are made explicitly by shadow stack management instructions like
WRUSSQ.

Shadow stacks accesses to shadow-stack mapping can see faults in normal,
valid operation just like regular accesses to regular mappings.  Shadow
stacks need some of the same features like delayed allocation, swap and
copy-on-write.

Shadow stack accesses can also result in errors, such as when a shadow
stack overflows, or if a shadow stack access occurs to a non-shadow-stack
mapping.

In handling a shadow stack page fault, verify it occurs within a shadow
stack mapping.  It is always an error otherwise.  For valid shadow stack
accesses, set FAULT_FLAG_WRITE to effect copy-on-write.  Because clearing
_PAGE_DIRTY_HW (vs. _PAGE_RW) is used to trigger the fault, shadow stack
read fault and shadow stack write fault are not differentiated and both are
handled as a write access.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
v10:
-Revise commit log.

 arch/x86/include/asm/traps.h |  2 ++
 arch/x86/mm/fault.c          | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 9bf804709ee6..b4f4c725a350 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -168,6 +168,7 @@ enum {
  *   bit 3 ==				1: use of reserved bit detected
  *   bit 4 ==				1: fault was an instruction fetch
  *   bit 5 ==				1: protection keys block access
+ *   bit 6 ==				1: shadow stack access fault
  */
 enum x86_pf_error_code {
 	X86_PF_PROT	=		1 << 0,
@@ -176,5 +177,6 @@ enum x86_pf_error_code {
 	X86_PF_RSVD	=		1 << 3,
 	X86_PF_INSTR	=		1 << 4,
 	X86_PF_PK	=		1 << 5,
+	X86_PF_SHSTK	=		1 << 6,
 };
 #endif /* _ASM_X86_TRAPS_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a51df516b87b..a4a3c8f016f0 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1210,6 +1210,17 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 				       (error_code & X86_PF_INSTR), foreign))
 		return 1;
 
+	/*
+	 * Verify a shadow stack access is within a shadow stack VMA.
+	 * It is always an error otherwise.  Normal data access to a
+	 * shadow stack area is checked in the case followed.
+	 */
+	if (error_code & X86_PF_SHSTK) {
+		if (!(vma->vm_flags & VM_SHSTK))
+			return 1;
+		return 0;
+	}
+
 	if (error_code & X86_PF_WRITE) {
 		/* write, present and write, not present: */
 		if (unlikely(!(vma->vm_flags & VM_WRITE)))
@@ -1367,6 +1378,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
+	/*
+	 * Clearing _PAGE_DIRTY_HW is used to detect shadow stack access.
+	 * This method cannot distinguish shadow stack read vs. write.
+	 * For valid shadow stack accesses, set FAULT_FLAG_WRITE to effect
+	 * copy-on-write.
+	 */
+	if (hw_error_code & X86_PF_SHSTK)
+		flags |= FAULT_FLAG_WRITE;
 	if (hw_error_code & X86_PF_WRITE)
 		flags |= FAULT_FLAG_WRITE;
 	if (hw_error_code & X86_PF_INSTR)
-- 
2.21.0

