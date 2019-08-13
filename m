Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3B98C2AB
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 23:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfHMVDl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 17:03:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:18658 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbfHMVDk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:03:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="194275962"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga001.fm.intel.com with ESMTP; 13 Aug 2019 14:03:38 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 01/14] x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
Date:   Tue, 13 Aug 2019 13:53:46 -0700
Message-Id: <20190813205359.12196-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813205359.12196-1-yu-cheng.yu@intel.com>
References: <20190813205359.12196-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The user-mode indirect branch tracking support is done mostly by GCC
to insert ENDBR64/ENDBR32 instructions at branch targets.  The kernel
provides CPUID enumeration and feature setup.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/Kconfig  | 16 ++++++++++++++++
 arch/x86/Makefile |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7d13ba326962..666dc66a382e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1940,6 +1940,9 @@ config X86_INTEL_CET
 config ARCH_HAS_SHSTK
 	def_bool n
 
+config ARCH_HAS_AS_LIMIT
+	def_bool n
+
 config X86_INTEL_SHADOW_STACK_USER
 	prompt "Intel Shadow Stack for user-mode"
 	def_bool n
@@ -1961,6 +1964,19 @@ config X86_INTEL_SHADOW_STACK_USER
 
 	  If unsure, say y.
 
+config X86_INTEL_BRANCH_TRACKING_USER
+	prompt "Intel Indirect Branch Tracking for user-mode"
+	def_bool n
+	depends on CPU_SUP_INTEL && X86_64
+	select X86_INTEL_CET
+	select ARCH_HAS_AS_LIMIT
+	select ARCH_USE_GNU_PROPERTY
+	---help---
+	  Indirect Branch Tracking provides hardware protection against return-/jmp-
+	  oriented programming attacks.
+
+	  If unsure, say y
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 0b2e9df48907..25372cc4a303 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -155,6 +155,13 @@ ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
   endif
 endif
 
+# Check compiler ibt support
+ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
+  ifeq ($(call cc-option-yn, -fcf-protection=branch), n)
+      $(error CONFIG_X86_INTEL_BRANCH_TRACKING_USER not supported by compiler)
+  endif
+endif
+
 #
 # If the function graph tracer is used with mcount instead of fentry,
 # '-maccumulate-outgoing-args' is needed to prevent a GCC bug
-- 
2.17.1

