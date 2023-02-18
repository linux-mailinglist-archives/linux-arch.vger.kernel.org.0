Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A8B69BC8C
	for <lists+linux-arch@lfdr.de>; Sat, 18 Feb 2023 22:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjBRVSk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 16:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjBRVSQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 16:18:16 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2DC199F3;
        Sat, 18 Feb 2023 13:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676755002; x=1708291002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qGE9eRR2bKBJP4DHmA8A12HCtfd+hwPFDkFpADpJ44g=;
  b=h3uKo/uAaPknWXGMr3gWWNIwUfE79SCPvpkMJ+9vfNgCn//YWpcPrD/h
   deNHFAVXm6w44tp+vnxh6Af/Uf9fQXe2shx2kZ/gbUsrUZ5jbQDIwXj0B
   tnJtrreZPzJj/lJ8aFJZbZFVXEBHceLs0NBjJCOZIemkkUNtjNh6zebuH
   FYIFBG1IpX68VBaagooGx7HrocE+Hu5tlb/taPxWZFWnLCHMLs9m5UxPD
   znXgG6Vo5vsloDH04QdBAZTQZ4I0/IldpmyT9/Cao7f1fB7DeGsLNqQ/D
   YQLdlynwtwEjdaMJVWrvhTTWvU/MtRvGEpLN+0zlU0qSPtFtyTYS8/2L1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="418427337"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="418427337"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="664241629"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="664241629"
Received: from adityava-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.80.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:05 -0800
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
Cc:     rick.p.edgecombe@intel.com, linux-s390@vger.kernel.org
Subject: [PATCH v6 12/41] s390/mm: Introduce pmd_mkwrite_kernel()
Date:   Sat, 18 Feb 2023 13:14:04 -0800
Message-Id: <20230218211433.26859-13-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

One of these changes is to allow for pmd_mkwrite() to create different
types of writable memory (the existing conventionally writable type and
also the new shadow stack type). Future patches will convert pmd_mkwrite()
to take a VMA in order to facilitate this, however there are places in the
kernel where pmd_mkwrite() is called outside of the context of a VMA.
These are for kernel memory. So create a new variant called
pmd_mkwrite_kernel() and switch the kernel users over to it. Have
pmd_mkwrite() and pmd_mkwrite_kernel() be the same for now. Future patches
will introduce changes to make pmd_mkwrite() take a VMA.

Only do this for architectures that need it because they call pmd_mkwrite()
in arch code without an associated VMA. Since it will only currently be
used in arch code, so do not include it in arch_pgtable_helpers.rst.

Cc: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
Hi Non-x86 Arch’s,

x86 has a feature that allows for the creation of a special type of
writable memory (shadow stack) that is only writable in limited specific
ways. Previously, changes were proposed to core MM code to teach it to
decide when to create normally writable memory or the special shadow stack
writable memory, but David Hildenbrand suggested[0] to change
pXX_mkwrite() to take a VMA, so awareness of shadow stack memory can be
moved into x86 code.

Since pXX_mkwrite() is defined in every arch, it requires some tree-wide
changes. So that is why you are seeing some patches out of a big x86
series pop up in your arch mailing list. There is no functional change.
After this refactor, the shadow stack series goes on to use the arch
helpers to push shadow stack memory details inside arch/x86.

Testing was just 0-day build testing.

Hopefully that is enough context. Thanks!

[0] https://lore.kernel.org/lkml/0e29a2d0-08d8-bcd6-ff26-4bea0e4037b0@redhat.com/#t

v6:
 - New patch
---
 arch/s390/include/asm/pgtable.h | 7 ++++++-
 arch/s390/mm/pageattr.c         | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 29522418b5f4..c48a447d1432 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1425,7 +1425,7 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
 	return set_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_PROTECT));
 }
 
-static inline pmd_t pmd_mkwrite(pmd_t pmd)
+static inline pmd_t pmd_mkwrite_kernel(pmd_t pmd)
 {
 	pmd = set_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_WRITE));
 	if (pmd_val(pmd) & _SEGMENT_ENTRY_DIRTY)
@@ -1433,6 +1433,11 @@ static inline pmd_t pmd_mkwrite(pmd_t pmd)
 	return pmd;
 }
 
+static inline pmd_t pmd_mkwrite(pmd_t pmd)
+{
+	return pmd_mkwrite_kernel(pmd);
+}
+
 static inline pmd_t pmd_mkclean(pmd_t pmd)
 {
 	pmd = clear_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_DIRTY));
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 4ee5fe5caa23..7b6967dfacd0 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -146,7 +146,7 @@ static void modify_pmd_page(pmd_t *pmdp, unsigned long addr,
 	if (flags & SET_MEMORY_RO)
 		new = pmd_wrprotect(new);
 	else if (flags & SET_MEMORY_RW)
-		new = pmd_mkwrite(pmd_mkdirty(new));
+		new = pmd_mkwrite_kernel(pmd_mkdirty(new));
 	if (flags & SET_MEMORY_NX)
 		new = set_pmd_bit(new, __pgprot(_SEGMENT_ENTRY_NOEXEC));
 	else if (flags & SET_MEMORY_X)
-- 
2.17.1

