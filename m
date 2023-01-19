Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D077B6744A9
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 22:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjASVgn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 16:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjASVer (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 16:34:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4F94A1E0;
        Thu, 19 Jan 2023 13:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674163619; x=1705699619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+3N34QEERZNcvQNJAARc1au4ZPtrpENbiq/H3U3EHgE=;
  b=no/aVTuC4lT7oAPeDGhAvjU3xIb4ro4QSJgI/FApFptenkK5ErT3tJes
   t0B9M7xQTQKWWoE2o85bZzhNAvPnCaL0S3x1CKxS2QPUcLBF19XVwpboM
   itPhwqs+c5T44F4eE5Wg9YX0BLyX7kS0w85WaeemNnlXPmSslNmcam5th
   jsb8mnf1YFOTPcRcFmXDRJfjKBo9ZxXVMgaZfna0qQin4B2of9PqpCFeT
   q8mdcD8EsnjR0UxI25EnNBqdUwnhbgFA5uv0TORZY4Bbhwq5HnoReLj71
   Frx85Juh8Uai6OsyfBqIBUxrHXEK/el/JRLbHE6aFW3lR2U9RUCqTTOej
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323119634"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323119634"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989139093"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="989139093"
Received: from hossain3-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.252.128.187])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:55 -0800
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
Subject: [PATCH v5 20/39] mm: Add guard pages around a shadow stack.
Date:   Thu, 19 Jan 2023 13:22:58 -0800
Message-Id: <20230119212317.8324-21-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 include/linux/mm.h | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 139a682d243b..3f980d4823ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2987,15 +2987,36 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
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

