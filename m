Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BCC6A4E73
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 23:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjB0Wcc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 17:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjB0WcI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 17:32:08 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF0728D09;
        Mon, 27 Feb 2023 14:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677537116; x=1709073116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=06DYB189OojzsE4lYBG6K2Lo6kRqspO9hy4UYyXmLjM=;
  b=g04XAbBWZsC2PLZu00SMtAMUnOXjwjvu7tNCKNExctQoCa9nWM2K8wtI
   zkGKlpehdnadnkLXADnyiXLo0qJNN2y6+QrddaIyW1d3a5VeXqwVQPhDy
   X4uYjCBG9gEkF+SN1qE3vl6PVS5xxMQNWqOogqx8nl/s7Yditm0S92VX3
   7r/5fxbY8OnUEk87Hfaqpl/pXiItGN1tsXtjzNMduhHLTTHULW0LXOXL5
   x5YD3wjFM7c8mACvhALIxD82tIuTBRS8l8Oukyn6YuJ4yedAgVkIcp+jL
   67KOatmwtr851JitUXg5MGDa7X++CXsIYYHt+eo/FMCxnZspBldmTEHgT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313657646"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313657646"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="848024693"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="848024693"
Received: from leonqu-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.72.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:27 -0800
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v7 27/41] x86/mm: Warn if create Write=0,Dirty=1 with raw prot
Date:   Mon, 27 Feb 2023 14:29:43 -0800
Message-Id: <20230227222957.24501-28-rick.p.edgecombe@intel.com>
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

When user shadow stack is use, Write=0,Dirty=1 is treated by the CPU as
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
to make sure no new mk_pte() start doing this.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
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

