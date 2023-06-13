Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C03E72D5B6
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238954AbjFMAMy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbjFMAMf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:12:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5A81728;
        Mon, 12 Jun 2023 17:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615146; x=1718151146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VxsR8A3vgFZdU2Uya7vVGhJBClJyO0tAkA+BqmUO8Zs=;
  b=MAkibPwx6HjXO50QeclLoNDH6D2TGh73wITGile4ozU9mHcxnH+PheEm
   qOjOV8daMbTI/KuLiGHq4DTFRyRxFm676WzWhjn4w9iO9g845IDe9z26b
   fLqErGBXzqHHP/1PSPelFvMbtbKi/g/NPubKjam5QPWQAuZRmOJWDXiDi
   DjWXx/G850tGLUankXiSV3sx/AD+jF9uujteIqChg2rfcgOqef46XIszU
   jmuYjA/lcME4NaA6VS+8A3AViz/M9lJ7dOR1FP9CBYfFijfQsY8GfK1O3
   lk4CwotlRYtaR+WONZpp2wd+jlQh8t2dx/ZYGlXPs7xRyo1an1mbNDzBZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361556998"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361556998"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671026"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671026"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:20 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v9 15/42] x86/mm: Check shadow stack page fault errors
Date:   Mon, 12 Jun 2023 17:10:41 -0700
Message-Id: <20230613001108.3040476-16-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The CPU performs "shadow stack accesses" when it expects to encounter
shadow stack mappings. These accesses can be implicit (via CALL/RET
instructions) or explicit (instructions like WRSS).

Shadow stack accesses to shadow-stack mappings can result in faults in
normal, valid operation just like regular accesses to regular mappings.
Shadow stacks need some of the same features like delayed allocation, swap
and copy-on-write. The kernel needs to use faults to implement those
features.

The architecture has concepts of both shadow stack reads and shadow stack
writes. Any shadow stack access to non-shadow stack memory will generate
a fault with the shadow stack error code bit set.

This means that, unlike normal write protection, the fault handler needs
to create a type of memory that can be written to (with instructions that
generate shadow stack writes), even to fulfill a read access. So in the
case of COW memory, the COW needs to take place even with a shadow stack
read. Otherwise the page will be left (shadow stack) writable in
userspace. So to trigger the appropriate behavior, set FAULT_FLAG_WRITE
for shadow stack accesses, even if the access was a shadow stack read.

For the purpose of making this clearer, consider the following example.
If a process has a shadow stack, and forks, the shadow stack PTEs will
become read-only due to COW. If the CPU in one process performs a shadow
stack read access to the shadow stack, for example executing a RET and
causing the CPU to read the shadow stack copy of the return address, then
in order for the fault to be resolved the PTE will need to be set with
shadow stack permissions. But then the memory would be changeable from
userspace (from CALL, RET, WRSS, etc). So this scenario needs to trigger
COW, otherwise the shared page would be changeable from both processes.

Shadow stack accesses can also result in errors, such as when a shadow
stack overflows, or if a shadow stack access occurs to a non-shadow-stack
mapping. Also, generate the errors for invalid shadow stack accesses.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/trap_pf.h |  2 ++
 arch/x86/mm/fault.c            | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

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
index e4399983c50c..fe68119ce2cc 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1118,8 +1118,22 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 				       (error_code & X86_PF_INSTR), foreign))
 		return 1;
 
+	/*
+	 * Shadow stack accesses (PF_SHSTK=1) are only permitted to
+	 * shadow stack VMAs. All other accesses result in an error.
+	 */
+	if (error_code & X86_PF_SHSTK) {
+		if (unlikely(!(vma->vm_flags & VM_SHADOW_STACK)))
+			return 1;
+		if (unlikely(!(vma->vm_flags & VM_WRITE)))
+			return 1;
+		return 0;
+	}
+
 	if (error_code & X86_PF_WRITE) {
 		/* write, present and write, not present: */
+		if (unlikely(vma->vm_flags & VM_SHADOW_STACK))
+			return 1;
 		if (unlikely(!(vma->vm_flags & VM_WRITE)))
 			return 1;
 		return 0;
@@ -1311,6 +1325,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
+	/*
+	 * Read-only permissions can not be expressed in shadow stack PTEs.
+	 * Treat all shadow stack accesses as WRITE faults. This ensures
+	 * that the MM will prepare everything (e.g., break COW) such that
+	 * maybe_mkwrite() can create a proper shadow stack PTE.
+	 */
+	if (error_code & X86_PF_SHSTK)
+		flags |= FAULT_FLAG_WRITE;
 	if (error_code & X86_PF_WRITE)
 		flags |= FAULT_FLAG_WRITE;
 	if (error_code & X86_PF_INSTR)
-- 
2.34.1

