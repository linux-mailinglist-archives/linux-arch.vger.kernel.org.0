Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989784A39E2
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356512AbiA3VV7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:21:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:52019 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356475AbiA3VV4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577716; x=1675113716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HlWo8OKNThkqHwQn3Dphtl6Opo3L/i/03JpsJVaIZ2A=;
  b=g23OBzhbAjNLI4HpENBuTWPqnMFujE1MB7oDuq9Zlk6Y5e2V83S29uLt
   QXbMH7fOyFPTQScz4sK+4nfvptHt/VuCpl2PqIHJg2Y6ph3+UkWnsxya8
   FulV1DrtkeFYtP/XZep21myGdudorw3ckLLlAzoRX/UdTE5O6ojcvix8+
   H9/W/nT44d+2mK+Dx5gJrLe0wDaM3x7MUW3adU5QMdhAAFbP1LvaM0WlF
   5Z1PnCevP4UPvuFjm3a9BI7pB3jP5NXczYomjB2op1QlxSsRDT6o0c4Rq
   9EOgELM9ohx2Fwqbl6L8zz4HH7/xlNZoyKpSY77OJH0H6rN8YX9J/FJi3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104904"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104904"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856715"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:51 -0800
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 07/35] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Date:   Sun, 30 Jan 2022 13:18:10 -0800
Message-Id: <20220130211838.8382-8-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

The x86 family of processors do not directly create read-only and Dirty
PTEs.  These PTEs are created by software.  One such case is that kernel
read-only pages are historically setup as Dirty.

New processors that support Shadow Stack regard read-only and Dirty PTEs as
shadow stack pages.  This results in ambiguity between shadow stack and
kernel read-only pages.  To resolve this, removed Dirty from kernel read-
only pages.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/pgtable_types.h | 6 +++---
 arch/x86/mm/pat/set_memory.c         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 40497a9020c6..3781a79b6388 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -190,10 +190,10 @@ enum page_cache_mode {
 #define _KERNPG_TABLE		 (__PP|__RW|   0|___A|   0|___D|   0|   0| _ENC)
 #define _PAGE_TABLE_NOENC	 (__PP|__RW|_USR|___A|   0|___D|   0|   0)
 #define _PAGE_TABLE		 (__PP|__RW|_USR|___A|   0|___D|   0|   0| _ENC)
-#define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|___D|   0|___G)
-#define __PAGE_KERNEL_ROX	 (__PP|   0|   0|___A|   0|___D|   0|___G)
+#define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|   0|   0|___G)
+#define __PAGE_KERNEL_ROX	 (__PP|   0|   0|___A|   0|   0|   0|___G)
 #define __PAGE_KERNEL_NOCACHE	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __NC)
-#define __PAGE_KERNEL_VVAR	 (__PP|   0|_USR|___A|__NX|___D|   0|___G)
+#define __PAGE_KERNEL_VVAR	 (__PP|   0|_USR|___A|__NX|   0|   0|___G)
 #define __PAGE_KERNEL_LARGE	 (__PP|__RW|   0|___A|__NX|___D|_PSE|___G)
 #define __PAGE_KERNEL_LARGE_EXEC (__PP|__RW|   0|___A|   0|___D|_PSE|___G)
 #define __PAGE_KERNEL_WP	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __WP)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b4072115c8ef..844bb30280b7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1943,7 +1943,7 @@ int set_memory_nx(unsigned long addr, int numpages)
 
 int set_memory_ro(unsigned long addr, int numpages)
 {
-	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_RW), 0);
+	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_RW | _PAGE_DIRTY), 0);
 }
 
 int set_memory_rw(unsigned long addr, int numpages)
-- 
2.17.1

