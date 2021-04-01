Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C948C352207
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 00:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhDAWLY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 18:11:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:34672 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhDAWLV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 18:11:21 -0400
IronPort-SDR: g26xgPemfKAInxbyLDYNtQK9n2R7tda790BTKOgCB7aqpGv++lSKCKT+3ezhM/QrXl1dlAXxR4
 yz5PBF+YdzoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="189084515"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="189084515"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:20 -0700
IronPort-SDR: LcYuzklxP9W452wH3Yad6VvAaJkeO5UNW2IBhtHGeIiDFjSw84Oda/LPgL5rawJ6fw/8I7UjKx
 4ssZMZBGazig==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="517513843"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:11:20 -0700
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
Subject: [PATCH v24 02/30] x86/cet/shstk: Add Kconfig option for Shadow Stack
Date:   Thu,  1 Apr 2021 15:10:36 -0700
Message-Id: <20210401221104.31584-3-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210401221104.31584-1-yu-cheng.yu@intel.com>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
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
v24:
- Update for the splitting X86_CET to X86_SHADOW_STACK and X86_IBT.

 arch/x86/Kconfig           | 26 ++++++++++++++++++++++++++
 arch/x86/Kconfig.assembler |  5 +++++
 2 files changed, 31 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..f42560b220ef 100644
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
@@ -1941,6 +1942,31 @@ config X86_SGX
 
 	  If unsure, say N.
 
+config ARCH_HAS_SHADOW_STACK
+	def_bool n
+
+config X86_CET
+	def_bool n
+
+config X86_SHADOW_STACK
+	prompt "Intel Shadow Stack"
+	def_bool n
+	depends on AS_WRUSS
+	depends on ARCH_HAS_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select X86_CET
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

