Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B0C2E7452
	for <lists+linux-arch@lfdr.de>; Tue, 29 Dec 2020 22:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgL2VdC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Dec 2020 16:33:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:11899 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgL2VdB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Dec 2020 16:33:01 -0500
IronPort-SDR: LALZIeXbYPBtMBLQCSBV0OCDDQ9NmxVWSZ8v9RsbZJB2UzLAGYt5YMedXE+VXXuvsBSScAuyqe
 pJRIn2IVFp6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="176640502"
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="176640502"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 13:32:18 -0800
IronPort-SDR: 0EF0l+ZioqTdS3/TMczLYJzSDBmVH27kyit/J95DYQJm4oOQUx7OhRM2ZOBNW/McaXqp11zxO0
 2x8MHn6/amXQ==
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="376189568"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 13:32:17 -0800
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
Subject: [PATCH v17 02/26] x86/cet/shstk: Add Kconfig option for user-mode control-flow protection
Date:   Tue, 29 Dec 2020 13:30:29 -0800
Message-Id: <20201229213053.16395-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201229213053.16395-1-yu-cheng.yu@intel.com>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Shadow Stack provides protection against function return address
corruption.  It is active when the processor supports it, the kernel has
CONFIG_X86_CET_USER enabled, and the application is built for the feature.
This is only implemented for the 64-bit kernel.  When it is enabled, legacy
non-Shadow Stack applications continue to work, but without protection.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/Kconfig           | 22 ++++++++++++++++++++++
 arch/x86/Kconfig.assembler |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7b6dd10b162a..72cff400b9ae 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1950,6 +1950,28 @@ config X86_SGX
 
 	  If unsure, say N.
 
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

