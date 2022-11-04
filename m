Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE6161A430
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKDWj1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiKDWjZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:39:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBF2D5F;
        Fri,  4 Nov 2022 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601565; x=1699137565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XjjEWtLkd8LTsXZrdDMhOoWhDojdmFCHoVnaTLWF/ew=;
  b=IQ0xgCAjrUstjmKeNoi8j14w/ZUf4p+uaoUy7YYZV07QP6BM08x21jI2
   +CFeby87wkQu8NxxcL/A9QACwVBcvi2ZsUzLz5QMMLl6iRBo583fTwydl
   NQ0lZvv9stkt+FiSaEVnLfPP7GLFE6ErejH3uwNUUwIO/aQUKZFbumzXu
   /wrmEHrXWsxgg3zCPRDtxffUy1Iq+2/+hUOtdOCH9KSO4NHMf4pstb483
   64FfJFUEfOUen2OhQJPyIbCQWVUqfxb1TWguDhCJ8Oz0OufRQvB55VIcr
   Fvg2gI6zeFriDbXhcB1gkZXPalh7YofFjPWid6fffNMiYveDHdRHMNBGp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840480"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840480"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:23 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668513920"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668513920"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:22 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v3 02/37] x86/cet/shstk: Add Kconfig option for Shadow Stack
Date:   Fri,  4 Nov 2022 15:35:29 -0700
Message-Id: <20221104223604.29615-3-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Shadow Stack provides protection for applications against function return
address corruption. It is active when the processor supports it, the
kernel has CONFIG_X86_SHADOW_STACK enabled, and the application is built
for the feature. This is only implemented for the 64-bit kernel. When it
is enabled, legacy non-Shadow Stack applications continue to work, but
without protection.

Since there is another feature that utilizes CET (Kernel IBT) that will
share implementation with Shadow Stacks, create CONFIG_CET to signify
that at least one CET feature is configured.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---

v3:
 - Add X86_CET (Kees)
 - Add back WRUSS dependency (Kees)
 - Fix verbiage (Dave)
 - Change from promt to bool (Kirill)
 - Add more to commit log

v2:
 - Remove already wrong kernel size increase info (tlgx)
 - Change prompt to remove "Intel" (tglx)
 - Update line about what CPUs are supported (Dave)

Yu-cheng v25:
 - Remove X86_CET and use X86_SHADOW_STACK directly.

Yu-cheng v24:
 - Update for the splitting X86_CET to X86_SHADOW_STACK and X86_IBT.
 arch/x86/Kconfig           | 24 ++++++++++++++++++++++++
 arch/x86/Kconfig.assembler |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ceab0db..f3d14f5accce 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1852,6 +1852,11 @@ config CC_HAS_IBT
 		  (CC_IS_CLANG && CLANG_VERSION >= 140000)) && \
 		  $(as-instr,endbr64)
 
+config X86_CET
+	def_bool n
+	help
+	  CET features configured (Shadow Stack or IBT)
+
 config X86_KERNEL_IBT
 	prompt "Indirect Branch Tracking"
 	bool
@@ -1859,6 +1864,7 @@ config X86_KERNEL_IBT
 	# https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
 	depends on !LD_IS_LLD || LLD_VERSION >= 140000
 	select OBJTOOL
+	select X86_CET
 	help
 	  Build the kernel with support for Indirect Branch Tracking, a
 	  hardware support course-grain forward-edge Control Flow Integrity
@@ -1953,6 +1959,24 @@ config X86_SGX
 
 	  If unsure, say N.
 
+config X86_USER_SHADOW_STACK
+	bool "X86 Userspace Shadow Stack"
+	depends on AS_WRUSS
+	depends on X86_64
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select X86_CET
+	help
+	  Shadow Stack protection is a hardware feature that detects function
+	  return address corruption.  This helps mitigate ROP attacks.
+	  Applications must be enabled to use it, and old userspace does not
+	  get protection "for free".
+
+	  CPUs supporting shadow stacks were first released in 2020.
+
+	  See Documentation/x86/cet.rst for more information.
+
+	  If unsure, say N.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index 26b8c08e2fc4..00c79dd93651 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -19,3 +19,8 @@ config AS_TPAUSE
 	def_bool $(as-instr,tpause %ecx)
 	help
 	  Supported by binutils >= 2.31.1 and LLVM integrated assembler >= V7
+
+config AS_WRUSS
+	def_bool $(as-instr,wrussq %rax$(comma)(%rbx))
+	help
+	  Supported by binutils >= 2.31 and LLVM integrated assembler
-- 
2.17.1

