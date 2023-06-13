Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA572D5F7
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239025AbjFMAPT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbjFMAN4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:13:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BA81BDC;
        Mon, 12 Jun 2023 17:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615155; x=1718151155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ioNZyjx88vkgqQos5HBjwuXN8Qld1af278Y586V7kGQ=;
  b=jrL0WHpcBkHj3QYgXv2hBY/Ru0gbYbl9aOhT0ffF8Yxx9A7RpOEezA7d
   4drBnPu33Qj9l1tAypE4TJl0cAru7b1OxQckh31A5sYUja3AJyEnmipMG
   CzyT2JOxbh3IMStaROCNNwRVCQb4hWAyx99qG6MypQ2RsRRK2/lZGsd+Z
   f8jbOvNVBPoRgNMJ7E9C4PL2qZWhM22glD3JFWBywa6eznOzM6tDHSN5Q
   jsmnxb3Z2loQFm+wCVhCgY93pErg05k6vDxfcqSJrtEgWKXpfO5McKxd/
   3nnGLFPOEwTByd6Yy9785wKchaGjP0F3nU/TWWUzGyEMNmn4bjp8bcsHo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361557071"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361557071"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671040"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671040"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:22 -0700
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
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     rick.p.edgecombe@intel.com, Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v9 18/42] x86/mm: Warn if create Write=0,Dirty=1 with raw prot
Date:   Mon, 12 Jun 2023 17:10:44 -0700
Message-Id: <20230613001108.3040476-19-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v9:
 - Always do the check since 32 bit now supports SavedDirty
---
 arch/x86/include/asm/pgtable.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 89cfa93d0ad6..5383f7282f89 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1032,7 +1032,14 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
  * (Currently stuck as a macro because of indirect forward reference
  * to linux/mm.h:page_to_nid())
  */
-#define mk_pte(page, pgprot)   pfn_pte(page_to_pfn(page), (pgprot))
+#define mk_pte(page, pgprot)						  \
+({									  \
+	pgprot_t __pgprot = pgprot;					  \
+									  \
+	WARN_ON_ONCE((pgprot_val(__pgprot) & (_PAGE_DIRTY | _PAGE_RW)) == \
+		    _PAGE_DIRTY);					  \
+	pfn_pte(page_to_pfn(page), __pgprot);				  \
+})
 
 static inline int pmd_bad(pmd_t pmd)
 {
-- 
2.34.1

