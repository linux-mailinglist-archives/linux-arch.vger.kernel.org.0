Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56F86A4E0C
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 23:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjB0Wbb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 17:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjB0Wb3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 17:31:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA5228D09;
        Mon, 27 Feb 2023 14:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677537088; x=1709073088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lXB/Va8eFkKMhXnCWr4ZLsBS0D4WgDtbHK72wob+dBQ=;
  b=FHGat0R3hl16SpK4tBDMcPvefkP/29zFzQr7AzMK7N57TWnr5BembDZa
   cnY0YrkfvpaQj4hgkBbfAzE+RwCIyqTlR8leMs6aT10oyxnwyOVynwr2h
   pp+slKeVWXnfD9b4qWXF/7ZtX5stYIBZGkpSBF25hcqFc2krsfFNP+XV5
   t6ATnR7RsDJ6XjgrMsnrICHixZCw2UnTzf1dgCT98ddPW2zL28+Q53t/F
   I3lRGM6fJsexOypE27/RKtTD46LcnSiinHUvSiDprxczF1xVv+UCJXa8J
   THLFNyT68q1KjxYW73qQ+NNh91+NVSB36O/rf4yGkqhtyYxqsexpEFKbZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313657025"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313657025"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="848024341"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="848024341"
Received: from leonqu-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.72.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:07 -0800
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
Subject: [PATCH v7 02/41] x86/shstk: Add Kconfig option for shadow stack
Date:   Mon, 27 Feb 2023 14:29:18 -0800
Message-Id: <20230227222957.24501-3-rick.p.edgecombe@intel.com>
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

Shadow stack provides protection for applications against function return
address corruption. It is active when the processor supports it, the
kernel has CONFIG_X86_SHADOW_STACK enabled, and the application is built
for the feature. This is only implemented for the 64-bit kernel. When it
is enabled, legacy non-shadow stack applications continue to work, but
without protection.

Since there is another feature that utilizes CET (Kernel IBT) that will
share implementation with shadow stacks, create CONFIG_CET to signify
that at least one CET feature is configured.

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
v5:
 - Remove capitalization of shadow stack (Boris)

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
---
 arch/x86/Kconfig           | 24 ++++++++++++++++++++++++
 arch/x86/Kconfig.assembler |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a825bf031f49..f03791b73f9f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1851,6 +1851,11 @@ config CC_HAS_IBT
 		  (CC_IS_CLANG && CLANG_VERSION >= 140000)) && \
 		  $(as-instr,endbr64)
 
+config X86_CET
+	def_bool n
+	help
+	  CET features configured (Shadow stack or IBT)
+
 config X86_KERNEL_IBT
 	prompt "Indirect Branch Tracking"
 	def_bool y
@@ -1858,6 +1863,7 @@ config X86_KERNEL_IBT
 	# https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
 	depends on !LD_IS_LLD || LLD_VERSION >= 140000
 	select OBJTOOL
+	select X86_CET
 	help
 	  Build the kernel with support for Indirect Branch Tracking, a
 	  hardware support course-grain forward-edge Control Flow Integrity
@@ -1952,6 +1958,24 @@ config X86_SGX
 
 	  If unsure, say N.
 
+config X86_USER_SHADOW_STACK
+	bool "X86 userspace shadow stack"
+	depends on AS_WRUSS
+	depends on X86_64
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select X86_CET
+	help
+	  Shadow stack protection is a hardware feature that detects function
+	  return address corruption.  This helps mitigate ROP attacks.
+	  Applications must be enabled to use it, and old userspace does not
+	  get protection "for free".
+
+	  CPUs supporting shadow stacks were first released in 2020.
+
+	  See Documentation/x86/shstk.rst for more information.
+
+	  If unsure, say N.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index b88f784cb02e..8ad41da301e5 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -24,3 +24,8 @@ config AS_GFNI
 	def_bool $(as-instr,vgf2p8mulb %xmm0$(comma)%xmm1$(comma)%xmm2)
 	help
 	  Supported by binutils >= 2.30 and LLVM integrated assembler
+
+config AS_WRUSS
+	def_bool $(as-instr,wrussq %rax$(comma)(%rbx))
+	help
+	  Supported by binutils >= 2.31 and LLVM integrated assembler
-- 
2.17.1

