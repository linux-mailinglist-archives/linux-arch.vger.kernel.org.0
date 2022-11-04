Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CC661A469
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKDWll (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKDWkp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:40:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE45B4AF30;
        Fri,  4 Nov 2022 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601577; x=1699137577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=3/rM2KyC/x9FhcIHFIgAr562vZ6+pVG10d1tw9A8cn4=;
  b=RD6QhiLkzJyTfOFSedDqKGmLY8rWgQehYYU5uUWPqnyN3t5QN9DRucHD
   viVYFPrPJgrlVLQVsmERw3AU8B3ZePWtLsfpjhfrHKcde+BFMkvWtcQdl
   3r/I+Q2qb03VV1zdheLB3cLv7bomtw0ezqII6OlUjJlKYyKypIVxgCx/q
   kdCFx8mN/Bl8R/tZn4CqotgXkbeSmhVGpI7o8MDSbGabW3FXjreg08KRr
   ogGDTwmFNjMUp4sImHZtk9XUlx1969SsjSiXRLZ0KBMrNgOt62EDNELZc
   oaVsgGGxnL7ufBkRWneUCUSdThHL98FJJCHMAGEN3L02ULuG7qPpfuOxi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840538"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840538"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668514058"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668514058"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:35 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v3 15/37] x86/mm: Check Shadow Stack page fault errors
Date:   Fri,  4 Nov 2022 15:35:42 -0700
Message-Id: <20221104223604.29615-16-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

The CPU performs "shadow stack accesses" when it expects to encounter
shadow stack mappings. These accesses can be implicit (via CALL/RET
instructions) or explicit (instructions like WRSS).

Shadow stacks accesses to shadow-stack mappings can see faults in normal,
valid operation just like regular accesses to regular mappings. Shadow
stacks need some of the same features like delayed allocation, swap and
copy-on-write. The kernel needs to use faults to implement those features.

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

Shadow stack accesses can also result in errors, such as when a shadow
stack overflows, or if a shadow stack access occurs to a non-shadow-stack
mapping. Also, generate the errors for invalid shadow stack accesses.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v3:
 - Improve comment talking about using FAULT_FLAG_WRITE (Peterz)

v2:
 - Update commit log with verbiage/feedback from Dave Hansen
 - Clarify reasoning for FAULT_FLAG_WRITE for all shadow stack accesses
 - Update comments with some verbiage from Dave Hansen

Yu-cheng v30:
 - Update Subject line and add a verb

 arch/x86/include/asm/trap_pf.h |  2 ++
 arch/x86/mm/fault.c            | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

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
index 7b0d4ab894c8..0af3d7f52c2e 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1138,8 +1138,22 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
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
@@ -1331,6 +1345,18 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
+	/*
+	 * To service shadow stack read faults, unlike normal read faults, the
+	 * fault handler needs to create a type of memory that will also be
+	 * writable (with instructions that generate shadow stack writes).
+	 * In the case of COW memory, the COW needs to take place even with
+	 * a shadow stack read. Otherwise the shared page will be left (shadow
+	 * stack) writable in userspace. So to trigger the appropriate behavior
+	 * by setting FAULT_FLAG_WRITE for shadow stack accesses, even if the
+	 * access was a shadow stack read.
+	 */
+	if (error_code & X86_PF_SHSTK)
+		flags |= FAULT_FLAG_WRITE;
 	if (error_code & X86_PF_WRITE)
 		flags |= FAULT_FLAG_WRITE;
 	if (error_code & X86_PF_INSTR)
-- 
2.17.1

