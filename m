Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6AC6A4E54
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 23:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjB0WcR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 17:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjB0Wbw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 17:31:52 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F107F28D2D;
        Mon, 27 Feb 2023 14:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677537109; x=1709073109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ZIfeT04mKir/YNhHsgsFjFvjvr/0UP7Swg3kZIhAJQw=;
  b=Mrl5nwOMuKKAo9wkPfvKEB+7neim1lcySms1JrkKaU9ySLztoefFugoK
   /ZelKfl+A8yoaohyfVIC4qqjl6ItI3scq0VopnndwGxUgGSBc6rQ0XLS9
   kCrDnCZIOd4EMCz+A/YyNTfzedOU05BkU62MDFg/xqVwsiHLTXksCwTy2
   YRSbys5vN2oL4uRl/HhyeRb+qqQPYH2sfgUBdgm0T97H+H6+DxyjvwXNF
   I/sw3NrHy95O679WaTAm4pmusC2J2WaVWlXZTmW9oW+165/7LkyP4djS8
   Yp6lCNTk7xATIw1zLFvlpsnJduH8D3+GPOj1uafbFodrYH/MRnPWpotHp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313657504"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313657504"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="848024631"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="848024631"
Received: from leonqu-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.72.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:23 -0800
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
Subject: [PATCH v7 22/41] mm/mmap: Add shadow stack pages to memory accounting
Date:   Mon, 27 Feb 2023 14:29:38 -0800
Message-Id: <20230227222957.24501-23-rick.p.edgecombe@intel.com>
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

Account shadow stack pages to stack memory. Do this by adding a
VM_SHADOW_STACK check in is_stack_mapping().

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
v7:
 - Change is_stack_mapping() to know about VM_SHADOW_STACK so the
   additions in vm_stat_account() can be dropped. (David Hildenbrand)

v3:
 - Remove unneeded VM_SHADOW_STACK check in accountable_mapping()
   (Kirill)

v2:
 - Remove is_shadow_stack_mapping() and just change it to directly bitwise
   and VM_SHADOW_STACK.

Yu-cheng v26:
 - Remove redundant #ifdef CONFIG_MMU.

Yu-cheng v25:
 - Remove #ifdef CONFIG_ARCH_HAS_SHADOW_STACK for is_shadow_stack_mapping().
---
 mm/internal.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 7920a8b7982e..1d13d5580f64 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -491,14 +491,14 @@ static inline bool is_exec_mapping(vm_flags_t flags)
 }
 
 /*
- * Stack area - automatically grows in one direction
+ * Stack area
  *
- * VM_GROWSUP / VM_GROWSDOWN VMAs are always private anonymous:
- * do_mmap() forbids all other combinations.
+ * VM_GROWSUP, VM_GROWSDOWN VMAs are always private
+ * anonymous. do_mmap() forbids all other combinations.
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return (flags & VM_STACK) == VM_STACK;
+	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
 }
 
 /*
-- 
2.17.1

