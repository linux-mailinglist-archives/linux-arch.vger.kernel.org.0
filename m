Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4522641219
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiLCAgl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiLCAgd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:36:33 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AFEF7A23;
        Fri,  2 Dec 2022 16:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027792; x=1701563792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=nPGHwvfvhwh0s+qOYAT9IA/XK2YwRNZRo0Le5Qvnc2o=;
  b=YlOwkxLBIxJ4zgEZb9hGfpkfrYPm7bBLUkSngkARprFxFAbXh7CGyyIW
   wJ1Y3vzgGdfQcDKs3MmqN9/nuLNE+ijyv3wVR3eTwvcO5C1BYQDsvDTsY
   3BwX2npgz5fM3J5ctMysosdzPc8nzU+6xu7LE2Xse0+t6AbsV8Pvx6Tr+
   Iux0+TrRNYuE27dPOV05nrVoRMUQ/U0Xc8Humu4kScMyhb2oIW16MN4MI
   tirmzJ0bGH9gwWiLpr5+j315/rdiHgudEEPxPDvVpcc3YXpKchhp5mFlj
   uEVcTb5x+eKvWLd776PFVIUMU0epRR60hE6EzD9Zfn0zfScjMJwgItpcU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313710667"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313710667"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:36:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479752"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479752"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:36:30 -0800
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
Subject: [PATCH v4 02/39] x86/shstk: Add Kconfig option for Shadow Stack
Date:   Fri,  2 Dec 2022 16:35:29 -0800
Message-Id: <20221203003606.6838-3-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index ae36661cfd81..3c4a8e47cf19 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1853,6 +1853,11 @@ config CC_HAS_IBT
 		  (CC_IS_CLANG && CLANG_VERSION >= 140000)) && \
 		  $(as-instr,endbr64)
 
+config X86_CET
+	def_bool n
+	help
+	  CET features configured (Shadow Stack or IBT)
+
 config X86_KERNEL_IBT
 	prompt "Indirect Branch Tracking"
 	def_bool y
@@ -1860,6 +1865,7 @@ config X86_KERNEL_IBT
 	# https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
 	depends on !LD_IS_LLD || LLD_VERSION >= 140000
 	select OBJTOOL
+	select X86_CET
 	help
 	  Build the kernel with support for Indirect Branch Tracking, a
 	  hardware support course-grain forward-edge Control Flow Integrity
@@ -1954,6 +1960,24 @@ config X86_SGX
 
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

