Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E081530E663
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 23:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhBCW6J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 17:58:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:30214 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233238AbhBCW6E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 17:58:04 -0500
IronPort-SDR: ZL02OKQnYOgoCANYl07XDITE635kQSnZMLGo0qxLlVM8rAonyfGiuyr1JRKw3dm88Gz1uTTxm3
 u9wdVvzGHklQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="242642362"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="242642362"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:56:27 -0800
IronPort-SDR: 4cVRY76efhpwVQu/bcg6WAMas/WxazJTvfiBsSxCU+9ZiGuZbMVm0U4gwcSqSVf/mRaK/tibfI
 dNhHT0IWNKeg==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="507921118"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:56:27 -0800
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
Subject: [PATCH v19 13/25] x86/mm: Shadow Stack page fault error checking
Date:   Wed,  3 Feb 2021 14:55:35 -0800
Message-Id: <20210203225547.32221-14-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210203225547.32221-1-yu-cheng.yu@intel.com>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
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
_PAGE_DIRTY (vs. _PAGE_RW) is used to trigger the fault, shadow stack read
fault and shadow stack write fault are not differentiated and both are
handled as a write access.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/trap_pf.h |  2 ++
 arch/x86/mm/fault.c            | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/trap_pf.h b/arch/x86/include/asm/trap_pf.h
index 10b1de500ab1..afa524325e55 100644
--- a/arch/x86/include/asm/trap_pf.h
+++ b/arch/x86/include/asm/trap_pf.h
@@ -11,6 +11,7 @@
  *   bit 3 ==				1: use of reserved bit detected
  *   bit 4 ==				1: fault was an instruction fetch
  *   bit 5 ==				1: protection keys block access
+ *   bit 6 ==				1: shadow stack access fault
  *   bit 15 ==				1: SGX MMU page-fault
  */
 enum x86_pf_error_code {
@@ -20,6 +21,7 @@ enum x86_pf_error_code {
 	X86_PF_RSVD	=		1 << 3,
 	X86_PF_INSTR	=		1 << 4,
 	X86_PF_PK	=		1 << 5,
+	X86_PF_SHSTK	=		1 << 6,
 	X86_PF_SGX	=		1 << 15,
 };
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f1f1b5a0956a..4cfb8c474a82 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1131,6 +1131,17 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
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
@@ -1296,6 +1307,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
+	/*
+	 * Clearing _PAGE_DIRTY is used to detect shadow stack access.
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

