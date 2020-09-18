Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4847F270558
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 21:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgIRTYR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 15:24:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:44701 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIRTYO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Sep 2020 15:24:14 -0400
IronPort-SDR: eDAPw26xU4BCdW1uhWBP1P56PUqz83NfDf1hsE4oBoMK7c+Vhsak0HGGqZ+zL9bCpW3v8Cq+7O
 XxiOUHjS+q9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="159330618"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="159330618"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:23:30 -0700
IronPort-SDR: ImL7SPJ85D04MoBJQKtfrY5bdV9+R3VtlvS/XuxKBDEKgQIvwGViS/Zt72oqhYvbrMi5RElAdY
 b7Uqh8S/83NQ==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="484332775"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:23:29 -0700
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
Subject: [PATCH v12 4/8] x86/cet/ibt: ELF header parsing for Indirect Branch Tracking
Date:   Fri, 18 Sep 2020 12:23:08 -0700
Message-Id: <20200918192312.25978-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200918192312.25978-1-yu-cheng.yu@intel.com>
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Update arch_setup_elf_property() for Indirect Branch Tracking.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
v9:
- Change cpu_feature_enabled() to static_cpu_has().

 arch/x86/Kconfig             | 2 ++
 arch/x86/kernel/process_64.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b047e0a8d1c2..5bd6d6a10047 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1969,6 +1969,8 @@ config X86_INTEL_BRANCH_TRACKING_USER
 	depends on CPU_SUP_INTEL && X86_64
 	depends on $(cc-option,-fcf-protection)
 	select X86_INTEL_CET
+	select ARCH_USE_GNU_PROPERTY
+	select ARCH_BINFMT_ELF_STATE
 	help
 	  Indirect Branch Tracking (IBT) provides protection against
 	  CALL-/JMP-oriented programming attacks.  It is active when
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index fd4644865a3b..c084e1a37d11 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -866,6 +866,14 @@ int arch_setup_elf_property(struct arch_elf_state *state)
 			r = cet_setup_shstk();
 	}
 
+	if (r < 0)
+		return r;
+
+	if (static_cpu_has(X86_FEATURE_IBT)) {
+		if (state->gnu_property & GNU_PROPERTY_X86_FEATURE_1_IBT)
+			r = cet_setup_ibt();
+	}
+
 	return r;
 }
 #endif
-- 
2.21.0

