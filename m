Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CDF1BEBE4
	for <lists+linux-arch@lfdr.de>; Thu, 30 Apr 2020 00:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgD2WKZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Apr 2020 18:10:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:61300 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgD2WIn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Apr 2020 18:08:43 -0400
IronPort-SDR: ooRKz/M5i/wD0zoUA76PonvrgkrlC89YlgrKQMiPk2FcpxHrUraN9c9DzeIri7Oz9wyJdWA5zI
 DT9WdBl1z3IA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 15:08:43 -0700
IronPort-SDR: NlYnfBlQ5psdLBR6iqozVLAVCQMzWAljpX+34eRUFI+/jP34SmNcB+YT1hYKkUuX24TiMsWy7W
 f+dCLMw55hZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="276308870"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002.jf.intel.com with ESMTP; 29 Apr 2020 15:08:42 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v10 07/26] x86/mm: Remove _PAGE_DIRTY_HW from kernel RO pages
Date:   Wed, 29 Apr 2020 15:07:13 -0700
Message-Id: <20200429220732.31602-8-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200429220732.31602-1-yu-cheng.yu@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kernel read-only PTEs are setup as _PAGE_DIRTY_HW.  Since these become
shadow stack PTEs, remove the dirty bit.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/pgtable_types.h | 6 +++---
 arch/x86/mm/pat/set_memory.c         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b82e0f167879..522b80b952f4 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -193,10 +193,10 @@ enum page_cache_mode {
 #define _KERNPG_TABLE		 (__PP|__RW|   0|___A|   0|___D|   0|   0| _ENC)
 #define _PAGE_TABLE_NOENC	 (__PP|__RW|_USR|___A|   0|___D|   0|   0)
 #define _PAGE_TABLE		 (__PP|__RW|_USR|___A|   0|___D|   0|   0| _ENC)
-#define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|___D|   0|___G)
-#define __PAGE_KERNEL_RX	 (__PP|   0|   0|___A|   0|___D|   0|___G)
+#define __PAGE_KERNEL_RO	 (__PP|   0|   0|___A|__NX|   0|   0|___G)
+#define __PAGE_KERNEL_RX	 (__PP|   0|   0|___A|   0|   0|___G)
 #define __PAGE_KERNEL_NOCACHE	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __NC)
-#define __PAGE_KERNEL_VVAR	 (__PP|   0|_USR|___A|__NX|___D|   0|___G)
+#define __PAGE_KERNEL_VVAR	 (__PP|   0|_USR|___A|__NX|   0|   0|___G)
 #define __PAGE_KERNEL_LARGE	 (__PP|__RW|   0|___A|__NX|___D|_PSE|___G)
 #define __PAGE_KERNEL_LARGE_EXEC (__PP|__RW|   0|___A|   0|___D|_PSE|___G)
 #define __PAGE_KERNEL_WP	 (__PP|__RW|   0|___A|__NX|___D|   0|___G| __WP)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 59eca6a94ce7..87751b7e2131 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1923,7 +1923,7 @@ int set_memory_nx(unsigned long addr, int numpages)
 
 int set_memory_ro(unsigned long addr, int numpages)
 {
-	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_RW), 0);
+	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_RW | _PAGE_DIRTY_HW), 0);
 }
 
 int set_memory_rw(unsigned long addr, int numpages)
-- 
2.21.0

