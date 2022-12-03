Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93AB64126F
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiLCAks (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiLCAkO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:40:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0274D2EF4B;
        Fri,  2 Dec 2022 16:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027877; x=1701563877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=OscWK4vBleHDbCii3J5IxRm9vERbNW8+FtcU6Glk4SQ=;
  b=Vfvj2FmofA5LOIcQoMyvroTW6AQxBJduWB986yaRTakap3Aucd9V1rut
   1TtVFUDEn6ijJLr9iqfhp0ZqIUighhudkVK6Q9qFVo0w4JXhJVZ3jmYQq
   ZaON/TfldnztU/iOSwepJYiKQvzvcV61orUbo0NM0HwfGkIO3w8c0fa7e
   T/Tbkby3z6ztjaZubQJxEdMWM/G+y19n4vbjwxb272CTCqnUZPVXq6CYi
   vs/f5qlFw5tSmJl3AJr+Gzqz8SZw8T6ApGisefOEXhQwr0V4P0etoHAIm
   G5wxs6SK/je8My6GlzkQwU1+t0MfPJLofXCz4KdH0JFuqc4kVNv8Wl34p
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313711140"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313711140"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479912"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479912"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:13 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v4 19/39] mm: Add guard pages around a shadow stack.
Date:   Fri,  2 Dec 2022 16:35:46 -0800
Message-Id: <20221203003606.6838-20-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Yu-cheng v24:
 - Instead changing vm_*_gap(), create x86-specific versions.

 include/linux/mm.h | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f10797a1b236..e0991d2fc5a8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2821,15 +2821,36 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
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

