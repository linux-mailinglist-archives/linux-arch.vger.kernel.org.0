Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E28136CD19
	for <lists+linux-arch@lfdr.de>; Tue, 27 Apr 2021 22:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbhD0Usy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 16:48:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:56328 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239021AbhD0Usl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Apr 2021 16:48:41 -0400
IronPort-SDR: y379xGZErhfRKSPo7GaDK6AiELiu2U1+wcKIXVLDfkm4us68/+zQV7XZqFMLs8cjWBBTmiEDHI
 F3V7D0h8oNVA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="196699388"
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="196699388"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:47:47 -0700
IronPort-SDR: iogEKj49eNEn3Jj98ysuiJ5T4AT3mLkPcsCQgfuMLmQNMskffVqisSeGgc3tRZuyOjt154vPhf
 3YGKuAScx6dg==
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="457835083"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:47:47 -0700
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
Subject: [PATCH v26 4/9] x86/cet/ibt: Update ELF header parsing for Indirect Branch Tracking
Date:   Tue, 27 Apr 2021 13:47:15 -0700
Message-Id: <20210427204720.25007-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210427204720.25007-1-yu-cheng.yu@intel.com>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

An ELF file's .note.gnu.property indicates features the file supports.
The property is parsed at loading time and passed to arch_setup_elf_
property().  Update it for Indirect Branch Tracking.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v24:
- Update for changes introduced from splitting shadow stack and ibt.

 arch/x86/Kconfig             | 2 ++
 arch/x86/kernel/process_64.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6bb69fba0dad..7436e3a608e8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1970,6 +1970,8 @@ config X86_IBT
 	def_bool n
 	depends on X86_SHADOW_STACK
 	depends on $(cc-option,-fcf-protection)
+	select ARCH_USE_GNU_PROPERTY
+	select ARCH_BINFMT_ELF_STATE
 	help
 	  Indirect Branch Tracking (IBT) provides protection against
 	  CALL-/JMP-oriented programming attacks.  It is active when
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index d71045b29475..bf8ef10e5b78 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -864,6 +864,14 @@ int arch_setup_elf_property(struct arch_elf_state *state)
 			r = shstk_setup();
 	}
 
+	if (r < 0)
+		return r;
+
+	if (cpu_feature_enabled(X86_FEATURE_IBT)) {
+		if (state->gnu_property & GNU_PROPERTY_X86_FEATURE_1_IBT)
+			r = ibt_setup();
+	}
+
 	return r;
 }
 #endif
-- 
2.21.0

