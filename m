Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB996A4E52
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 23:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjB0WcR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 17:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjB0Wbx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 17:31:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863B8298F9;
        Mon, 27 Feb 2023 14:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677537110; x=1709073110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=iMZ7pHmGnRJHR2PLdV4imtJgm0cCw3zHhRVdTgGS/n0=;
  b=Zx60cAIfb9k8jZSJ4Ei42RmIZz4cr0tAvz/8NwY3DLdE+OcWqdaDhLSI
   zIMywQX29F7MS7L/DvicQE2HepLY8Jm4Fho4pBPpDS1AfyR1UJZ2vZPlZ
   lZ9oRzuMTn5/UY2AAi77bDCssHCrs6RpW2R8PVeT+ktvuAVIfn8XwNXwQ
   Lu2QpF3JWlu7/HQH+YXx1aqprEgMyUL6QRGLm6jiIMPCysWZnwplsEPTT
   uVCtC+J7EPd9g0U0zQQqvwv4He/+0Zrkdf8yo3HdzOGk78XEO+ck/CQPL
   ss/H/ZItPX11ZLFHz0f9eoVmtVPe1eqJ1GVBS8CmG2lJUqeFJv/NWF6M2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313657523"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313657523"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="848024623"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="848024623"
Received: from leonqu-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.72.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:22 -0800
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
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v7 21/41] mm: Add guard pages around a shadow stack.
Date:   Mon, 27 Feb 2023 14:29:37 -0800
Message-Id: <20230227222957.24501-22-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
switching to other shadow stacks. The RSTORSSP can move the ssp to
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
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---
v5:
 - Fix typo in commit log

v4:
 - Drop references to 32 bit instructions
 - Switch to generic code to drop __weak (Peterz)

v2:
 - Use __weak instead of #ifdef (Dave Hansen)
 - Only have start gap on shadow stack (Andy Luto)
 - Create stack_guard_start_gap() to not duplicate code
   in an arch version of vm_start_gap() (Dave Hansen)
 - Improve commit log partly with verbiage from (Dave Hansen)

Yu-cheng v25:
 - Move SHADOW_STACK_GUARD_GAP to arch/x86/mm/mmap.c.
---
 include/linux/mm.h | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 097544afb1aa..6a093daced88 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3107,15 +3107,36 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
 	return mtree_load(&mm->mm_mt, addr);
 }
 
+static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_GROWSDOWN)
+		return stack_guard_gap;
+
+	/*
+	 * Shadow stack pointer is moved by CALL, RET, and INCSSPQ.
+	 * INCSSPQ moves shadow stack pointer up to 255 * 8 = ~2 KB
+	 * and touches the first and the last element in the range, which
+	 * triggers a page fault if the range is not in a shadow stack.
+	 * Because of this, creating 4-KB guard pages around a shadow
+	 * stack prevents these instructions from going beyond.
+	 *
+	 * Creation of VM_SHADOW_STACK is tightly controlled, so a vma
+	 * can't be both VM_GROWSDOWN and VM_SHADOW_STACK
+	 */
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return PAGE_SIZE;
+
+	return 0;
+}
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
 
-- 
2.17.1

