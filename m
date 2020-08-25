Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DCC250D2F
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 02:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgHYAan (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 20:30:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:28753 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgHYAal (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 20:30:41 -0400
IronPort-SDR: ETmAT1ntNHezUodsKD7XAV2LpICu/LpT1466kZAuiasOzkusvrtv4nKzxLtSsA1DJ9FtcbQKwN
 ps+IRviKGNgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="174053294"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="174053294"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:30:38 -0700
IronPort-SDR: lYjt4wcfMve2UloFv1ZVhYpn9TLEcoQGsrogMIRpRCyCUOWZ2cXw36gxsL2insLMn2J+uDtF9n
 2Af6Rj+f0Ywg==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="443429341"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:30:37 -0700
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
Subject: [PATCH v11 9/9] x86: Disallow vsyscall emulation when CET is enabled
Date:   Mon, 24 Aug 2020 17:26:44 -0700
Message-Id: <20200825002645.3658-10-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200825002645.3658-1-yu-cheng.yu@intel.com>
References: <20200825002645.3658-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "H.J. Lu" <hjl.tools@gmail.com>

Emulation of the legacy vsyscall page is required by some programs built
before 2013.  Newer programs after 2013 don't use it.  Disallow vsyscall
emulation when Control-flow Enforcement (CET) is enabled to enhance
security.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5bd6d6a10047..bbc68ecfae2b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1210,7 +1210,7 @@ config X86_ESPFIX64
 config X86_VSYSCALL_EMULATION
 	bool "Enable vsyscall emulation" if EXPERT
 	default y
-	depends on X86_64
+	depends on X86_64 && !X86_INTEL_CET
 	help
 	 This enables emulation of the legacy vsyscall page.  Disabling
 	 it is roughly equivalent to booting with vsyscall=none, except
@@ -1225,6 +1225,8 @@ config X86_VSYSCALL_EMULATION
 	 Disabling this option saves about 7K of kernel size and
 	 possibly 4K of additional runtime pagetable memory.
 
+	 This option is disabled when Intel CET is enabled.
+
 config X86_IOPL_IOPERM
 	bool "IOPERM and IOPL Emulation"
 	default y
@@ -2361,7 +2363,7 @@ config COMPAT_VDSO
 
 choice
 	prompt "vsyscall table for legacy applications"
-	depends on X86_64
+	depends on X86_64 && !X86_INTEL_CET
 	default LEGACY_VSYSCALL_XONLY
 	help
 	  Legacy user code that does not know how to find the vDSO expects
@@ -2378,6 +2380,8 @@ choice
 
 	  If unsure, select "Emulate execution only".
 
+	  This option is not enabled when Intel CET is enabled.
+
 	config LEGACY_VSYSCALL_EMULATE
 		bool "Full emulation"
 		help
-- 
2.21.0

