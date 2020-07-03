Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7584213B95
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 16:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgGCOMw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 10:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgGCOMs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jul 2020 10:12:48 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFD0C08C5C1;
        Fri,  3 Jul 2020 07:12:48 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49yxkH6wwQz9sSJ; Sat,  4 Jul 2020 00:12:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593785559;
        bh=YlRTi0P+v2XAq9ghS39gWH14XqFbbkOlE7lrQjZPTnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lN5H2lHiK0LqSgnRQ4BaV19XM00wtg13Rnfo8DKHT37QYgRcDsoxJ8wqd3XJaaDnf
         cG+NqB9SGq58IJwY4P42TwtJP8NfY5f9dXB0UQ8LIlo/6xpBMJHCKoACI7NHsu6e2t
         8tGnrodMWN9juMGAsSb8MWOBo5GLw6F2ySQ3uh2h+Q5qMa7wk7+umzEBwKMmwYnFNP
         xRLVqknzmqelOutxooeDJye5t3WHJ4O3xi14T6F4fVfzT6/MS8X6OdA6SQ2sR10d2l
         DgAWlq1f4hAG/k71+wadQsHLfrAqto/fdcEgiD0K1Hap3mmUD10DhJjVKqQrFOw2H4
         M9UbQPvTY+V5Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com
Subject: [RFC PATCH 4/5] powerpc/mm: Remove custom stack expansion checking
Date:   Sat,  4 Jul 2020 00:13:26 +1000
Message-Id: <20200703141327.1732550-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703141327.1732550-1-mpe@ellerman.id.au>
References: <20200703141327.1732550-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We have powerpc specific logic in our page fault handling to decide if
an access to an unmapped address below the stack pointer should expand
the stack VMA.

The logic aims to prevent userspace from doing bad accesses below the
stack pointer. However as long as the stack is < 1MB in size, we allow
all accesses without further checks. Adding some debug I see that I
can do a full kernel build and LTP run, and not a single process has
used more than 1MB of stack. So for the majority of processes the
logic never even fires.

We also recently found a nasty bug in this code which could cause
userspace programs to be killed during signal delivery. It went
unnoticed presumably because most processes use < 1MB of stack.

The generic mm code has also grown support for stack guard pages since
this code was originally written, so the most heinous case of the
stack expanding into other mappings is now handled for us.

Finally although some other arches have special logic in this path,
from what I can tell none of x86, arm64, arm and s390 impose any extra
checks other than those in expand_stack().

So drop our complicated logic and like other architectures just let
the stack expand as long as its within the rlimit.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/fault.c | 106 ++--------------------------------------
 1 file changed, 5 insertions(+), 101 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index ed01329dd12b..925a7231abb3 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -42,39 +42,7 @@
 #include <asm/kup.h>
 #include <asm/inst.h>
 
-/*
- * Check whether the instruction inst is a store using
- * an update addressing form which will update r1.
- */
-static bool store_updates_sp(struct ppc_inst inst)
-{
-	/* check for 1 in the rA field */
-	if (((ppc_inst_val(inst) >> 16) & 0x1f) != 1)
-		return false;
-	/* check major opcode */
-	switch (ppc_inst_primary_opcode(inst)) {
-	case OP_STWU:
-	case OP_STBU:
-	case OP_STHU:
-	case OP_STFSU:
-	case OP_STFDU:
-		return true;
-	case OP_STD:	/* std or stdu */
-		return (ppc_inst_val(inst) & 3) == 1;
-	case OP_31:
-		/* check minor opcode */
-		switch ((ppc_inst_val(inst) >> 1) & 0x3ff) {
-		case OP_31_XOP_STDUX:
-		case OP_31_XOP_STWUX:
-		case OP_31_XOP_STBUX:
-		case OP_31_XOP_STHUX:
-		case OP_31_XOP_STFSUX:
-		case OP_31_XOP_STFDUX:
-			return true;
-		}
-	}
-	return false;
-}
+
 /*
  * do_page_fault error handling helpers
  */
@@ -267,54 +235,6 @@ static bool bad_kernel_fault(struct pt_regs *regs, unsigned long error_code,
 	return false;
 }
 
-static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
-				struct vm_area_struct *vma, unsigned int flags,
-				bool *must_retry)
-{
-	/*
-	 * N.B. The POWER/Open ABI allows programs to access up to
-	 * 288 bytes below the stack pointer.
-	 * The kernel signal delivery code writes up to 4KB
-	 * below the stack pointer (r1) before decrementing it.
-	 * The exec code can write slightly over 640kB to the stack
-	 * before setting the user r1.  Thus we allow the stack to
-	 * expand to 1MB without further checks.
-	 */
-	if (address + 0x100000 < vma->vm_end) {
-		struct ppc_inst __user *nip = (struct ppc_inst __user *)regs->nip;
-		/* get user regs even if this fault is in kernel mode */
-		struct pt_regs *uregs = current->thread.regs;
-		if (uregs == NULL)
-			return true;
-
-		/*
-		 * A user-mode access to an address a long way below
-		 * the stack pointer is only valid if the instruction
-		 * is one which would update the stack pointer to the
-		 * address accessed if the instruction completed,
-		 * i.e. either stwu rs,n(r1) or stwux rs,r1,rb
-		 * (or the byte, halfword, float or double forms).
-		 *
-		 * If we don't check this then any write to the area
-		 * between the last mapped region and the stack will
-		 * expand the stack rather than segfaulting.
-		 */
-		if (address + 4096 >= uregs->gpr[1])
-			return false;
-
-		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
-		    access_ok(nip, sizeof(*nip))) {
-			struct ppc_inst inst;
-
-			if (!probe_user_read_inst(&inst, nip))
-				return !store_updates_sp(inst);
-			*must_retry = true;
-		}
-		return true;
-	}
-	return false;
-}
-
 #ifdef CONFIG_PPC_MEM_KEYS
 static bool access_pkey_error(bool is_write, bool is_exec, bool is_pkey,
 			      struct vm_area_struct *vma)
@@ -480,7 +400,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	int is_user = user_mode(regs);
 	int is_write = page_fault_is_write(error_code);
 	vm_fault_t fault, major = 0;
-	bool must_retry = false;
 	bool kprobe_fault = kprobe_page_fault(regs, 11);
 
 	if (unlikely(debugger_fault_handler(regs) || kprobe_fault))
@@ -569,30 +488,15 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	vma = find_vma(mm, address);
 	if (unlikely(!vma))
 		return bad_area(regs, address);
-	if (likely(vma->vm_start <= address))
-		goto good_area;
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
-		return bad_area(regs, address);
 
-	/* The stack is being expanded, check if it's valid */
-	if (unlikely(bad_stack_expansion(regs, address, vma, flags,
-					 &must_retry))) {
-		if (!must_retry)
+	if (unlikely(vma->vm_start > address)) {
+		if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
 			return bad_area(regs, address);
 
-		mmap_read_unlock(mm);
-		if (fault_in_pages_readable((const char __user *)regs->nip,
-					    sizeof(unsigned int)))
-			return bad_area_nosemaphore(regs, address);
-		goto retry;
+		if (unlikely(expand_stack(vma, address)))
+			return bad_area(regs, address);
 	}
 
-	/* Try to expand it */
-	if (unlikely(expand_stack(vma, address)))
-		return bad_area(regs, address);
-
-good_area:
-
 #ifdef CONFIG_PPC_MEM_KEYS
 	if (unlikely(access_pkey_error(is_write, is_exec,
 				       (error_code & DSISR_KEYFAULT), vma)))
-- 
2.25.1

