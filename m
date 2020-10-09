Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E974328910C
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 20:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390594AbgJISeZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 14:34:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:9530 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390452AbgJISdN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 14:33:13 -0400
IronPort-SDR: ZHiSDTB2n9e6uZzXMtUqMtUXZza21NOJgk/NXBWIgJBxc7XiJe1Wyy8TKcmXdAzdNwHEaCaXEq
 bAWe/0PA7WuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="164736599"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="164736599"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:13 -0700
IronPort-SDR: AnsvOg3ftbUY5GVbbBfdSqHuV+7OId3FEb3JM2h+sl8ejNnxytJ7yCESZofgNo3agZ9uZrFaCG
 rXUU1fYiQsBw==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="529031121"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:12 -0700
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
Subject: [PATCH v14 05/26] x86/cet/shstk: Add Kconfig option for user-mode Shadow Stack
Date:   Fri,  9 Oct 2020 11:32:09 -0700
Message-Id: <20201009183230.26717-6-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201009183230.26717-1-yu-cheng.yu@intel.com>
References: <20201009183230.26717-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Shadow Stack provides protection against function return address
corruption.  It is active when the processor supports it, the kernel has
CONFIG_X86_SHADOW_STACK_USER, and the application is built for the feature.
This is only implemented for the 64-bit kernel.  When it is enabled, legacy
non-shadow stack applications continue to work, but without protection.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

v13:
- Update help text, and change default to N.
- Change X86_INTEL_* to X86_*.

v10:
- Change SHSTK to shadow stack in the help text.
- Change build-time check to config-time check.
- Change ARCH_HAS_SHSTK to ARCH_HAS_SHADOW_STACK.
---
 arch/x86/Kconfig                      | 33 +++++++++++++++++++++++++++
 scripts/as-x86_64-has-shadow-stack.sh |  4 ++++
 2 files changed, 37 insertions(+)
 create mode 100755 scripts/as-x86_64-has-shadow-stack.sh

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..415fcc869afc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1927,6 +1927,39 @@ config X86_INTEL_TSX_MODE_AUTO
 	  side channel attacks- equals the tsx=auto command line parameter.
 endchoice
 
+config AS_HAS_SHADOW_STACK
+	def_bool $(success,$(srctree)/scripts/as-x86_64-has-shadow-stack.sh $(CC))
+	help
+	  Test the assembler for shadow stack instructions.
+
+config X86_CET
+	def_bool n
+
+config ARCH_HAS_SHADOW_STACK
+	def_bool n
+
+config X86_SHADOW_STACK_USER
+	prompt "Intel Shadow Stacks for user-mode"
+	def_bool n
+	depends on CPU_SUP_INTEL && X86_64
+	depends on AS_HAS_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select X86_CET
+	select ARCH_HAS_SHADOW_STACK
+	help
+	  Shadow Stacks provides protection against program stack
+	  corruption.  It's a hardware feature.  This only matters
+	  if you have the right hardware.  It's a security hardening
+	  feature and apps must be enabled to use it.  You get no
+	  protection "for free" on old userspace.  The hardware can
+	  support user and kernel, but this option is for user space
+	  only.
+	  Support for this feature is only known to be present on
+	  processors released in 2020 or later.  CET features are also
+	  known to increase kernel text size by 3.7 KB.
+
+	  If unsure, say N.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/scripts/as-x86_64-has-shadow-stack.sh b/scripts/as-x86_64-has-shadow-stack.sh
new file mode 100755
index 000000000000..fac1d363a1b8
--- /dev/null
+++ b/scripts/as-x86_64-has-shadow-stack.sh
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+echo "wrussq %rax, (%rbx)" | $* -x assembler -c -
-- 
2.21.0

