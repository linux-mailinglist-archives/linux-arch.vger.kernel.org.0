Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F07306607
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 22:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbhA0V10 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 16:27:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:48884 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234462AbhA0V0u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 16:26:50 -0500
IronPort-SDR: 1Zd46pBw+eziIx0cYW1wxHOMPNqKo2Y8AKBd/JJn5KWoQi/CrCZ030NxxnUWOSkW+uha0mIw6e
 gSZof/rlK5YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="177573098"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="177573098"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:25:49 -0800
IronPort-SDR: D4aDZfyvo1J+7UBhOQ49iNv7JhMiCuGG+vToy+qRFwayXLng2xzMnNfgwlbNXvFOqgPMTk+lub
 v9NRQYJZNB5g==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="353948187"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:25:48 -0800
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
Subject: [PATCH v18 02/25] x86/cet/shstk: Add Kconfig option for user-mode control-flow protection
Date:   Wed, 27 Jan 2021 13:25:01 -0800
Message-Id: <20210127212524.10188-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210127212524.10188-1-yu-cheng.yu@intel.com>
References: <20210127212524.10188-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Shadow Stack provides protection against function return address
corruption.  It is active when the processor supports it, the kernel has
CONFIG_X86_CET enabled, and the application is built for the feature.
This is only implemented for the 64-bit kernel.  When it is enabled, legacy
non-Shadow Stack applications continue to work, but without protection.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/Kconfig           | 22 ++++++++++++++++++++++
 arch/x86/Kconfig.assembler |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 21f851179ff0..2d080a2335df 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1951,6 +1951,28 @@ config X86_SGX
 
 	  If unsure, say N.
 
+config ARCH_HAS_SHADOW_STACK
+	def_bool n
+
+config X86_CET
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

