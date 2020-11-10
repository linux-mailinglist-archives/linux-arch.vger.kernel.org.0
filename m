Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B722ADC19
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 17:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgKJQZo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 11:25:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:63836 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732692AbgKJQZE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 11:25:04 -0500
IronPort-SDR: Q1S40emYboo5a7rNz9pWx9+yr0OcMoZ1K7307Cb/MMWGHTY7hwC4Yd8VBZy5zRYNev0ZP3ZUyD
 0CFEa60Srflg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="149278315"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="149278315"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 08:25:02 -0800
IronPort-SDR: xU1nkYA8Tc0c0rIi1q6hQkbJtcav6IxZCYXq5ghL1g5nKJxdopVPW+GVZqL719+oorBvQeXE6a
 8eiU9sYRyzvw==
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="308469029"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 08:25:02 -0800
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
Subject: [PATCH v15 1/7] x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
Date:   Tue, 10 Nov 2020 08:24:42 -0800
Message-Id: <20201110162448.9846-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201110162448.9846-1-yu-cheng.yu@intel.com>
References: <20201110162448.9846-1-yu-cheng.yu@intel.com>
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
 arch/x86/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 18fd8cb549ad..e27f0c19a4b3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1969,6 +1969,25 @@ config X86_SHADOW_STACK_USER
 
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

