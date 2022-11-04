Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5361A477
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiKDWmZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiKDWlf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:41:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B88A4B9AF;
        Fri,  4 Nov 2022 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601580; x=1699137580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jeXRfJlKrlPUUKU7HYMbOtf6yG0qFBUWZwuPnRIvISw=;
  b=eDoBbnBJCuqQNGf6vc8cF6xjiDOnD/CQKDSrrEtF5JlfH0lnJpReNqDD
   +847OjwkI5JHCsH4Uf44j1U95ypgHsk3uI8WY2xxROfEr90bmqSfxMzOP
   iOpNmjPUnHfTXet7ZekE2QyoFHV7YekE0v7yyD2dEGi+Pm6z+KK4GZxOf
   pTUNBDZ6QWeBfn7vQ2XemQTZrbf6D6vr5qqUgIAi8C5RRWtAqQI8bxRMg
   RYUyLpFyyJCzCuw6Km6dWfvAL9bAQAoNViVk0AzURK2g3K8FykcIkpMQU
   8rMKXihcLTFRVtbznihsnuPqU1aAoOCrMGbXarhdn3FIc2/waCO+7MHMp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840554"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840554"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668514077"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668514077"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:37 -0700
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
Subject: [PATCH v3 18/37] mm: Add guard pages around a shadow stack.
Date:   Fri,  4 Nov 2022 15:35:45 -0700
Message-Id: <20221104223604.29615-19-rick.p.edgecombe@intel.com>
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

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

The architecture of shadow stack constrains the ability of userspace to
move the shadow stack pointer (SSP) in order to  prevent corrupting or
switching to other shadow stacks. The RSTORSSP can move the spp to
different shadow stacks, but it requires a specially placed token in order
to do this. However, the architecture does not prevent incrementing the
stack pointer to wander onto an adjacent shadow stack. To prevent this in
software, enforce guard pages at the beginning of shadow stack vmas, such
that there will always be a gap between adjacent shadow stacks.

Make the gap big enough so that no userspace SSP changing operations
(besides RSTORSSP), can move the SSP from one stack to the next. The
SSP can increment or decrement by CALL, RET  and INCSSP. CALL and RET
can move the SSP by a maximum of 8 bytes, at which point the shadow
stack would be accessed.

The INCSSP instruction can also increment the shadow stack pointer. It
is the shadow stack analog of an instruction like:

	addq    $0x80, %rsp

However, there is one important difference between an ADD on %rsp and
INCSSP. In addition to modifying SSP, INCSSP also reads from the memory
of the first and last elements that were "popped". It can be thought of
as acting like this:

READ_ONCE(ssp);       // read+discard top element on stack
ssp += nr_to_pop * 8; // move the shadow stack
READ_ONCE(ssp-8);     // read+discard last popped stack element

The maximum distance INCSSP can move the SSP is 2040 bytes, before it
would read the memory. Therefore a single page gap will be enough to
prevent any operation from shifting the SSP to an adjacent stack, since
it would have to land in the gap at least once, causing a fault.

This could be accomplished by using VM_GROWSDOWN, but this has a
downside. The behavior would allow shadow stack's to grow, which is
unneeded and adds a strange difference to how most regular stacks work.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---

v2:
 - Use __weak instead of #ifdef (Dave Hansen)
 - Only have start gap on shadow stack (Andy Luto)
 - Create stack_guard_start_gap() to not duplicate code
   in an arch version of vm_start_gap() (Dave Hansen)
 - Improve commit log partly with verbiage from (Dave Hansen)

Yu-cheng v25:
 - Move SHADOW_STACK_GUARD_GAP to arch/x86/mm/mmap.c.

Yu-cheng v24:
 - Instead changing vm_*_gap(), create x86-specific versions.

 arch/x86/mm/mmap.c | 23 +++++++++++++++++++++++
 include/linux/mm.h | 11 ++++++-----
 mm/mmap.c          |  7 +++++++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index c90c20904a60..66da1f3298b0 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -248,3 +248,26 @@ bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
 		return false;
 	return true;
 }
+
+unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_GROWSDOWN)
+		return stack_guard_gap;
+
+	/*
+	 * Shadow stack pointer is moved by CALL, RET, and INCSSP(Q/D).
+	 * INCSSPQ moves shadow stack pointer up to 255 * 8 = ~2 KB
+	 * (~1KB for INCSSPD) and touches the first and the last element
+	 * in the range, which triggers a page fault if the range is not
+	 * in a shadow stack. Because of this, creating 4-KB guard pages
+	 * around a shadow stack prevents these instructions from going
+	 * beyond.
+	 *
+	 * Creation of VM_SHADOW_STACK is tightly controlled, so a vma
+	 * can't be both VM_GROWSDOWN and VM_SHADOW_STACK
+	 */
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return PAGE_SIZE;
+
+	return 0;
+}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5d9536fa860a..0a3f7e2b32df 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2832,15 +2832,16 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
 	return mtree_load(&mm->mm_mt, addr);
 }
 
+unsigned long stack_guard_start_gap(struct vm_area_struct *vma);
+
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 {
+	unsigned long gap = stack_guard_start_gap(vma);
 	unsigned long vm_start = vma->vm_start;
 
-	if (vma->vm_flags & VM_GROWSDOWN) {
-		vm_start -= stack_guard_gap;
-		if (vm_start > vma->vm_start)
-			vm_start = 0;
-	}
+	vm_start -= gap;
+	if (vm_start > vma->vm_start)
+		vm_start = 0;
 	return vm_start;
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 2def55555e05..f67606fbc464 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -281,6 +281,13 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return origbrk;
 }
 
+unsigned long __weak stack_guard_start_gap(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_GROWSDOWN)
+		return stack_guard_gap;
+	return 0;
+}
+
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 extern void mt_validate(struct maple_tree *mt);
 extern void mt_dump(const struct maple_tree *mt);
-- 
2.17.1

