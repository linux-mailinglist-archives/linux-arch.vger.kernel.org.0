Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46147278B83
	for <lists+linux-arch@lfdr.de>; Fri, 25 Sep 2020 16:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgIYO6R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Sep 2020 10:58:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:47916 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbgIYO6O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Sep 2020 10:58:14 -0400
IronPort-SDR: Oe46mJDGs+3qY9GgVe5mGiqMh5b6dSsZW6RaJzuvRb0MjiOecPx3Ycr1SyUF4osjozSt6BNT1i
 KS53JoKwvprA==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="225704476"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="225704476"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 07:58:13 -0700
IronPort-SDR: dZdetEM4DRg4Hr3m0uJ4dfSizhMqgJIu94nv7NFPov8SDaS6Butg10uJnfPMdKSCpqlxx8PNcf
 FomTkBPzAl2g==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="512916957"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 07:58:13 -0700
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
Subject: [PATCH v13 1/8] x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
Date:   Fri, 25 Sep 2020 07:57:57 -0700
Message-Id: <20200925145804.5821-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925145804.5821-1-yu-cheng.yu@intel.com>
References: <20200925145804.5821-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce Kconfig option X86_BRANCH_TRACKING_USER.

Indirect Branch Tracking (IBT) provides protection against CALL-/JMP-
oriented programming attacks.  It is active when the kernel has this
feature enabled, and the processor and the application support it.
When this feature is enabled, legacy non-IBT applications continue to
work, but without IBT protection.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
v13:
- Update help text, and change default to N.
- Change X86_INTEL_* to X86_*.

v10:
- Change build-time CET check to config depends on.

 arch/x86/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b28a0ce4594..15c7f2606c9d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1966,6 +1966,25 @@ config X86_SHADOW_STACK_USER
 
 	  If unsure, say N.
 
+config X86_BRANCH_TRACKING_USER
+	prompt "Intel Indirect Branch Tracking for user-mode"
+	def_bool n
+	depends on CPU_SUP_INTEL && X86_64
+	depends on $(cc-option,-fcf-protection)
+	select X86_CET
+	help
+	  Indirect Branch Tracking (IBT) provides protection against
+	  CALL-/JMP-oriented programming attacks.  It is active when
+	  the kernel has this feature enabled, and the processor and
+	  the application support it.  When this feature is enabled,
+	  legacy non-IBT applications continue to work, but without
+	  IBT protection.
+	  Support for this feature is only known to be present on
+	  processors released in 2020 or later.  CET features are also
+	  known to increase kernel text size by 3.7 KB.
+
+	  If unsure, say N.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
-- 
2.21.0

