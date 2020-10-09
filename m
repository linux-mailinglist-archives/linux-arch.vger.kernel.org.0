Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBEF2890EC
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 20:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbgJISde (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 14:33:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:9542 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390461AbgJISdU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 14:33:20 -0400
IronPort-SDR: CdDg7pQKwCYsfXdJfR/aNpS4tPaFqYh9tm32PfPERtkYImRXbSSP7szdBD8C0U9/jnU0fVK/cE
 qgLhreokDiiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="164736618"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="164736618"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:19 -0700
IronPort-SDR: P+MUraUybckbWiHQRGxlDqH898uEvbgyWOD5TyH5Q7Cl0/6rBGPRcW9SRcHlo+z/IJdRli2HvL
 vfKy7HsenfcA==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="529031170"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:19 -0700
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
Subject: [PATCH v14 13/26] x86/mm: Shadow Stack page fault error checking
Date:   Fri,  9 Oct 2020 11:32:17 -0700
Message-Id: <20201009183230.26717-14-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201009183230.26717-1-yu-cheng.yu@intel.com>
References: <20201009183230.26717-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

v10:
-Revise commit log.
---
 arch/x86/include/asm/traps.h |  2 ++
 arch/x86/mm/fault.c          | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 714b1a30e7b0..28b493c53d70 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -50,6 +50,7 @@ void __noreturn handle_stack_overflow(const char *message,
  *   bit 3 ==				1: use of reserved bit detected
  *   bit 4 ==				1: fault was an instruction fetch
  *   bit 5 ==				1: protection keys block access
+ *   bit 6 ==				1: shadow stack access fault
  */
 enum x86_pf_error_code {
 	X86_PF_PROT	=		1 << 0,
@@ -58,5 +59,6 @@ enum x86_pf_error_code {
 	X86_PF_RSVD	=		1 << 3,
 	X86_PF_INSTR	=		1 << 4,
 	X86_PF_PK	=		1 << 5,
+	X86_PF_SHSTK	=		1 << 6,
 };
 #endif /* _ASM_X86_TRAPS_H */
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6e3e8a124903..2390399c157f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1110,6 +1110,17 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
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
@@ -1275,6 +1286,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 
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

