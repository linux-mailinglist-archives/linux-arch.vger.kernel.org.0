Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D6250D48
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 02:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgHYAai (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 20:30:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:28753 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbgHYAaf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 20:30:35 -0400
IronPort-SDR: SfDDIo80oKs8UwGVqvPxp7Yri6qYd+W8k7tuveWlFvvsd93meiFBqUawJaehvKcXXKMP8kPSFI
 y7IA1dDb3Vmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="174053259"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="174053259"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:30:33 -0700
IronPort-SDR: l8S+XyV+DgtG/kfo6YnlQsapzXqJUuZ7pa5XjdDLqLaT6tRrTlHIWMt8wZ27Z0o1fWuRDt3VFq
 8nW7rO4TwQcg==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="443429296"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:30:33 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v11 1/9] x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
Date:   Mon, 24 Aug 2020 17:26:36 -0700
Message-Id: <20200825002645.3658-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200825002645.3658-1-yu-cheng.yu@intel.com>
References: <20200825002645.3658-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce Kconfig option X86_INTEL_BRANCH_TRACKING_USER.

Indirect Branch Tracking (IBT) provides protection against CALL-/JMP-
oriented programming attacks.  It is active when the kernel has this
feature enabled, and the processor and the application support it.
When this feature is enabled, legacy non-IBT applications continue to
work, but without IBT protection.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
v10:
- Change build-time CET check to config depends on.

 arch/x86/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6b6dad011763..b047e0a8d1c2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1963,6 +1963,22 @@ config X86_INTEL_SHADOW_STACK_USER
 
 	  If unsure, say y.
 
+config X86_INTEL_BRANCH_TRACKING_USER
+	prompt "Intel Indirect Branch Tracking for user-mode"
+	def_bool n
+	depends on CPU_SUP_INTEL && X86_64
+	depends on $(cc-option,-fcf-protection)
+	select X86_INTEL_CET
+	help
+	  Indirect Branch Tracking (IBT) provides protection against
+	  CALL-/JMP-oriented programming attacks.  It is active when
+	  the kernel has this feature enabled, and the processor and
+	  the application support it.  When this feature is enabled,
+	  legacy non-IBT applications continue to work, but without
+	  IBT protection.
+
+	  If unsure, say y
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
-- 
2.21.0

