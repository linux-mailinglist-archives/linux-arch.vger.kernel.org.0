Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539032D4E38
	for <lists+linux-arch@lfdr.de>; Wed,  9 Dec 2020 23:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388648AbgLIWYd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Dec 2020 17:24:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:14580 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388639AbgLIWYa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Dec 2020 17:24:30 -0500
IronPort-SDR: Mx53IUsyXR5JmTKr+ayHHjWStJ8dsZnDVty1g/mNWTeIvxfLduqY0p01+8pK4dG5RWS2RTau6w
 mGxm/bwMz/FA==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="161918055"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="161918055"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 14:23:47 -0800
IronPort-SDR: uclimdvVR2tD5wF0nf91TYXck+W/PPf4mnEQLUGLoYy68dqMmFwq7ldTI6YTy1s+ftRXAmW1LR
 Ir9wdLNWFfEQ==
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="318543510"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 14:23:46 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v16 02/26] x86/cet/shstk: Add Kconfig option for user-mode control-flow protection
Date:   Wed,  9 Dec 2020 14:22:56 -0800
Message-Id: <20201209222320.1724-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201209222320.1724-1-yu-cheng.yu@intel.com>
References: <20201209222320.1724-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Shadow Stack provides protection against function return address
corruption.  It is active when the processor supports it, the kernel has
CONFIG_X86_CET_USER, and the application is built for the feature.
This is only implemented for the 64-bit kernel.  When it is enabled, legacy
non-Shadow Stack applications continue to work, but without protection.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/Kconfig           | 22 ++++++++++++++++++++++
 arch/x86/Kconfig.assembler |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fbf26e0f7a6a..78b4b5bb1272 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1931,6 +1931,28 @@ config X86_INTEL_TSX_MODE_AUTO
 	  side channel attacks- equals the tsx=auto command line parameter.
 endchoice
 
+config ARCH_HAS_SHADOW_STACK
+	def_bool n
+
+config X86_CET_USER
+	prompt "Intel Control-flow protection for user-mode"
+	def_bool n
+	depends on CPU_SUP_INTEL && X86_64
+	depends on AS_WRUSS
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_SHADOW_STACK
+	help
+	  Control-flow protection is a hardware security hardening feature
+	  that detects function-return address or jump target changes by
+	  malicious code.  Applications must be enabled to use it, and old
+	  userspace does not get protection "for free".
+	  Support for this feature is present on processors released in
+	  2020 or later.  Enabling this feature increases kernel text size
+	  by 3.7 KB.
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

