Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351156BFE64
	for <lists+linux-arch@lfdr.de>; Sun, 19 Mar 2023 01:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCSAV3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Mar 2023 20:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjCSAUo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Mar 2023 20:20:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC8C2A6D7;
        Sat, 18 Mar 2023 17:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679185151; x=1710721151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=5Gp9o9+xrqpZdB7LgH7hV6GLcbn71BAvzGNiD7RQW5E=;
  b=M7Dx0Sn5yZVPFkuv7o9BMjFB+7cQnXcrQRPk8ZesaheNyllnlNyJCW86
   T5hl9zQ9zgQ0w0B4v60HdL6amrpgN+ELpcxYJPRRH6KXZ9Ji8993a2Fty
   vHOdkb41O3Mbt8rNRWJa5wCYqtCJTeufusJHqgMLpoC4EpDkBBiBOyulK
   rtPQ2e/mxMLIueTX73jTPknwsljEKKopU79apFsG/4gYUz9XdamlcGQBn
   +8zYpOS+FA9ovdTzWQro7yz4/O3q54/CkJis3Kn5Fz3VeA/0sM+Tc+IQE
   txHvGU1Ctj+amJVFQoBTAD+EvZGH+W0RxDH5DYdiHfH/wJfvLzkmTpsjE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="338491328"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="338491328"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="749672901"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="749672901"
Received: from bmahatwo-mobl1.gar.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.135.34.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:38 -0700
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
Subject: [PATCH v8 27/40] x86/mm: Warn if create Write=0,Dirty=1 with raw prot
Date:   Sat, 18 Mar 2023 17:15:22 -0700
Message-Id: <20230319001535.23210-28-rick.p.edgecombe@intel.com>
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

When user shadow stack is in use, Write=0,Dirty=1 is treated by the CPU as
shadow stack memory. So for shadow stack memory this bit combination is
valid, but when Dirty=1,Write=1 (conventionally writable) memory is being
write protected, the kernel has been taught to transition the Dirty=1
bit to SavedDirty=1, to avoid inadvertently creating shadow stack
memory. It does this inside pte_wrprotect() because it knows the PTE is
not intended to be a writable shadow stack entry, it is supposed to be
write protected.

However, when a PTE is created by a raw prot using mk_pte(), mk_pte()
can't know whether to adjust Dirty=1 to SavedDirty=1. It can't
distinguish between the caller intending to create a shadow stack PTE or
needing the SavedDirty shift.

The kernel has been updated to not do this, and so Write=0,Dirty=1
memory should only be created by the pte_mkfoo() helpers. Add a warning
to make sure no new mk_pte() start doing this, like, for example,
set_memory_rox() did.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v8:
 - Update commit log verbiage (Boris)

v6:
 - New patch (Note, this has already been a useful warning, it caught the
   newly added set_memory_rox() doing this)
---
 arch/x86/include/asm/pgtable.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e5b3dce0d9fe..7142f99d3fbb 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1032,7 +1032,15 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
  * (Currently stuck as a macro because of indirect forward reference
  * to linux/mm.h:page_to_nid())
  */
-#define mk_pte(page, pgprot)   pfn_pte(page_to_pfn(page), (pgprot))
+#define mk_pte(page, pgprot)						 \
+({									 \
+	pgprot_t __pgprot = pgprot;					 \
+									 \
+	WARN_ON_ONCE(cpu_feature_enabled(X86_FEATURE_USER_SHSTK) &&	 \
+		    (pgprot_val(__pgprot) & (_PAGE_DIRTY | _PAGE_RW)) == \
+		    _PAGE_DIRTY);					 \
+	pfn_pte(page_to_pfn(page), __pgprot);				 \
+})
 
 static inline int pmd_bad(pmd_t pmd)
 {
-- 
2.17.1

