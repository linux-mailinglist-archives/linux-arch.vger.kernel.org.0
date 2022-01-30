Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4CD4A39FF
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356629AbiA3VWJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:22:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:52029 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356503AbiA3VV6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577718; x=1675113718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=95Ekd9pFZXWEBY+wGysVOoEb3gOtJAhC5Dzmrl7nHJo=;
  b=I57QP6fKotv4XIttfrK/8ON1wasZfGohsoQoTNZq2kRKXg5s4DFKqNW3
   bXcUaDefGJg47xFI1vTd4hp2WCDaYjFAidUfu0/fZ1bnEWHwXO3/VL3pC
   5xoc1vN4jPIsF5izqOb9pa8ynTou9U7XwolTBEcq6gdegmd1O1i0REaCc
   9PRyfh+KfeVGof1vBW4o2KCNicVWNo0bhzMht3odiEdmTmWYjcT/7SW2a
   /aTs7yZv9cIuPo+Z2CpmEgQx2p7Etwotp2nEd1kn7mM9Z0BBlK7D/VhSP
   Z/r6wbySoZVxK8p70AFN0x5z+IocFFqzVvXxjJaER01+bF1epxmkw6Ikp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104933"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104933"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856787"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:57 -0800
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
Subject: [PATCH 15/35] x86/mm: Check Shadow Stack page fault errors
Date:   Sun, 30 Jan 2022 13:18:18 -0800
Message-Id: <20220130211838.8382-16-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

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
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

Yu-cheng v30:
 - Update Subject line and add a verb.
 
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
index d0074c6ed31a..6769134986ec 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1107,6 +1107,17 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 				       (error_code & X86_PF_INSTR), foreign))
 		return 1;
 
+	/*
+	 * Verify a shadow stack access is within a shadow stack VMA.
+	 * It is always an error otherwise.  Normal data access to a
+	 * shadow stack area is checked in the case followed.
+	 */
+	if (error_code & X86_PF_SHSTK) {
+		if (!(vma->vm_flags & VM_SHADOW_STACK))
+			return 1;
+		return 0;
+	}
+
 	if (error_code & X86_PF_WRITE) {
 		/* write, present and write, not present: */
 		if (unlikely(!(vma->vm_flags & VM_WRITE)))
@@ -1300,6 +1311,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
+	/*
+	 * Clearing _PAGE_DIRTY is used to detect shadow stack access.
+	 * This method cannot distinguish shadow stack read vs. write.
+	 * For valid shadow stack accesses, set FAULT_FLAG_WRITE to effect
+	 * copy-on-write.
+	 */
+	if (error_code & X86_PF_SHSTK)
+		flags |= FAULT_FLAG_WRITE;
 	if (error_code & X86_PF_WRITE)
 		flags |= FAULT_FLAG_WRITE;
 	if (error_code & X86_PF_INSTR)
-- 
2.17.1

