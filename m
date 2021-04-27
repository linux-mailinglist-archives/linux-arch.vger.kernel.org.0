Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7236CC96
	for <lists+linux-arch@lfdr.de>; Tue, 27 Apr 2021 22:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbhD0UpE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 16:45:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:31779 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239038AbhD0Uow (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Apr 2021 16:44:52 -0400
IronPort-SDR: 0vx8tUf41OlnCihQhl1GQVjY2f9JPPYzlCxF5a6wiABAOpdOau3SBF/3siDJKsrS3LYKY/ofO7
 RDNg+MCZn+mQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="281922446"
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="281922446"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:44:07 -0700
IronPort-SDR: 7P8jTrq4zYxq3ucQoaAPWtoyBHLoKd1I1fXA8lTvxqFOvUSMbpYdEh7z1PHiAdeYJM27K219Id
 VJ/nB5nqJdKQ==
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="465623429"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:44:06 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v26 02/30] x86/cet/shstk: Add Kconfig option for Shadow Stack
Date:   Tue, 27 Apr 2021 13:42:47 -0700
Message-Id: <20210427204315.24153-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210427204315.24153-1-yu-cheng.yu@intel.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Shadow Stack provides protection against function return address
corruption.  It is active when the processor supports it, the kernel has
CONFIG_X86_SHADOW_STACK enabled, and the application is built for the
feature.  This is only implemented for the 64-bit kernel.  When it is
enabled, legacy non-Shadow Stack applications continue to work, but without
protection.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v25:
- Remove X86_CET and use X86_SHADOW_STACK directly.

v24:
- Update for the splitting X86_CET to X86_SHADOW_STACK and X86_IBT.

 arch/x86/Kconfig           | 22 ++++++++++++++++++++++
 arch/x86/Kconfig.assembler |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..41283f82fd87 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -28,6 +28,7 @@ config X86_64
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_HAS_SHADOW_STACK
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
@@ -1941,6 +1942,27 @@ config X86_SGX
 
 	  If unsure, say N.
 
+config ARCH_HAS_SHADOW_STACK
+	def_bool n
+
+config X86_SHADOW_STACK
+	prompt "Intel Shadow Stack"
+	def_bool n
+	depends on AS_WRUSS
+	depends on ARCH_HAS_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	help
+	  Shadow Stack protection is a hardware feature that detects function
+	  return address corruption.  This helps mitigate ROP attacks.
+	  Applications must be enabled to use it, and old userspace does not
+	  get protection "for free".
+	  Support for this feature is present on Tiger Lake family of
+	  processors released in 2020 or later.  Enabling this feature
+	  increases kernel text size by 3.7 KB.
+	  See Documentation/x86/intel_cet.rst for more information.
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
2.21.0

