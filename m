Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998956BFE57
	for <lists+linux-arch@lfdr.de>; Sun, 19 Mar 2023 01:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjCSAUp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Mar 2023 20:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjCSAUQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Mar 2023 20:20:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8232B28F;
        Sat, 18 Mar 2023 17:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679185119; x=1710721119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=opyjBN/VDdKGQFn13MiWP9WuORkQYDUhpnOpss/5QKc=;
  b=Wk3BVtp/wFugqnceAR/D/rFe7gPZ2ivYp4vi8ES2j+NYF15zgU2NKp7M
   u91ksz1EO/fm6I5FVgJhEiQvzma0h7oBXraKeoRR2St07awE7TKbIJwRu
   oxn9Fe9uiBqAT6M01ThElGes8FRr0pWt/xWXbMYdvJAvEKHSEL1BmDhuN
   c9+lE4eoq9viwwZlt1nwP7v11xpujO/dG6nbGmCbTv44N8NjlyTXPm4nt
   lMOXjygUz4Ah31Iv7cKif2zGrv9k2twoLMWjx42NpWspLWfycq2FyR5aa
   h/lDBdGEhdPUGQeadVcBcXhGdN/tDSNhDSUcMujtnAOhVubp5aU/LmWXy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="338491256"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="338491256"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="749672879"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="749672879"
Received: from bmahatwo-mobl1.gar.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.135.34.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:33 -0700
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
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v8 24/40] mm: Don't allow write GUPs to shadow stack memory
Date:   Sat, 18 Mar 2023 17:15:19 -0700
Message-Id: <20230319001535.23210-25-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
References: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The x86 Control-flow Enforcement Technology (CET) feature includes a
new type of memory called shadow stack. This shadow stack memory has
some unusual properties, which requires some core mm changes to
function properly.

In userspace, shadow stack memory is writable only in very specific,
controlled ways. However, since userspace can, even in the limited
ways, modify shadow stack contents, the kernel treats it as writable
memory. As a result, without additional work there would remain many
ways for userspace to trigger the kernel to write arbitrary data to
shadow stacks via get_user_pages(, FOLL_WRITE) based operations. To
help userspace protect their shadow stacks, make this a little less
exposed by blocking writable get_user_pages() operations for shadow
stack VMAs.

Still allow FOLL_FORCE to write through shadow stack protections, as it
does for read-only protections. This is required for debugging use
cases.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v8:
 - Update commit log verbiage (Boris, AndyL)

v3:
 - Add comment in __pte_access_permitted() (Dave)
 - Remove unneeded shadow stack specific check in
   __pte_access_permitted() (Jann)
---
 arch/x86/include/asm/pgtable.h | 5 +++++
 mm/gup.c                       | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index d81e7ec27507..2e3d8cca1195 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1638,6 +1638,11 @@ static inline bool __pte_access_permitted(unsigned long pteval, bool write)
 {
 	unsigned long need_pte_bits = _PAGE_PRESENT|_PAGE_USER;
 
+	/*
+	 * Write=0,Dirty=1 PTEs are shadow stack, which the kernel
+	 * shouldn't generally allow access to, but since they
+	 * are already Write=0, the below logic covers both cases.
+	 */
 	if (write)
 		need_pte_bits |= _PAGE_RW;
 
diff --git a/mm/gup.c b/mm/gup.c
index eab18ba045db..e7c7bcc0e268 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -978,7 +978,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		return -EFAULT;
 
 	if (write) {
-		if (!(vm_flags & VM_WRITE)) {
+		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
-- 
2.17.1

