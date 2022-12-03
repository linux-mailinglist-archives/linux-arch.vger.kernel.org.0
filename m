Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A0641223
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiLCAhI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiLCAgk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:36:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68E7F8195;
        Fri,  2 Dec 2022 16:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027796; x=1701563796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1p8FHxMuOhfc16cs1vrqOb7DIxgTV33DBoFY9Xhugz0=;
  b=jUeMQQflHEcxsbs34tlNnqtrseFeJz+6SdzihZsC5LYQ1nglIecbPHJz
   YEJj6eqOwfumdgFmF4J0JlwqwzWQLLrtrdrse8Rse1s4iCXi2cymjhR14
   9qN1TvHLrOV7p/ioi8+1Zqr4wwFhDJMt3ZpW6nFGoiSdVFyESBa523ipW
   QBaLW78TiOxPh3RT3wuQzMW4fK3PB9Ccnli/WorfsVWg4JsjRmjxb1MHz
   u9cc7yam7gEsGNOcQnLNlkN2NgHgauMlcLeXTt+PvXSu7Lh0qcv28hCj0
   UvQp6Tp6GcYuWdH7C1FWd8wlKQQ95fl6DAO4GPm7vtbZWoh5y7ACKGj5k
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313710722"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313710722"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:36:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479762"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479762"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:36:34 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v4 04/39] x86/cpufeatures: Enable CET CR4 bit for shadow stack
Date:   Fri,  2 Dec 2022 16:35:31 -0800
Message-Id: <20221203003606.6838-5-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Setting CR4.CET is a prerequisite for utilizing any CET features, most of
which also require setting MSRs.

Kernel IBT already enables the CET CR4 bit when it detects IBT HW support
and is configured with kernel IBT. However, future patches that enable
userspace shadow stack support will need the bit set as well. So change
the logic to enable it in either case.

Clear MSR_IA32_U_CET in cet_disable() so that it can't live to see
userspace in a new kexec-ed kernel that has CR4.CET set from kernel IBT.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---

v4:
 - Add back dedicated command line disable: "nousershtk" (Boris)

v3:
 - Remove stay new line (Boris)
 - Simplify commit log (Andrew Cooper)

v2:
 - In the shadow stack case, go back to only setting CR4.CET if the
   kernel is compiled with user shadow stack support.
 - Clear MSR_IA32_U_CET as well. (PeterZ)

KVM refresh:
 - Set CR4.CET if SHSTK or IBT are supported by HW, so that KVM can
   support CET even if IBT is disabled.
 - Drop no_user_shstk (Dave Hansen)
 - Elaborate on what the CR4 bit does in the commit log
 - Integrate with Kernel IBT logic

 arch/x86/kernel/cpu/common.c | 37 ++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 73cc546e024d..579f10222432 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -597,29 +597,51 @@ __noendbr void ibt_restore(u64 save)
 
 #endif
 
+#ifdef CONFIG_X86_CET
 static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 {
-	u64 msr = CET_ENDBR_EN;
+	bool kernel_ibt = HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT);
+	bool user_shstk;
+	u64 msr = 0;
+
+	/*
+	 * Enable user shadow stack only if the Linux defined user shadow stack
+	 * cap was not cleared by command line.
+	 */
+	user_shstk = cpu_feature_enabled(X86_FEATURE_SHSTK) &&
+		     IS_ENABLED(CONFIG_X86_USER_SHADOW_STACK);
 
-	if (!HAS_KERNEL_IBT ||
-	    !cpu_feature_enabled(X86_FEATURE_IBT))
+	if (!kernel_ibt && !user_shstk)
 		return;
 
+	if (user_shstk)
+		set_cpu_cap(c, X86_FEATURE_USER_SHSTK);
+
+	if (kernel_ibt)
+		msr = CET_ENDBR_EN;
+
 	wrmsrl(MSR_IA32_S_CET, msr);
 	cr4_set_bits(X86_CR4_CET);
 
-	if (!ibt_selftest()) {
+	if (kernel_ibt && !ibt_selftest()) {
 		pr_err("IBT selftest: Failed!\n");
 		wrmsrl(MSR_IA32_S_CET, 0);
 		setup_clear_cpu_cap(X86_FEATURE_IBT);
 		return;
 	}
 }
+#else /* CONFIG_X86_CET */
+static inline void setup_cet(struct cpuinfo_x86 *c) {}
+#endif
 
 __noendbr void cet_disable(void)
 {
-	if (cpu_feature_enabled(X86_FEATURE_IBT))
-		wrmsrl(MSR_IA32_S_CET, 0);
+	if (!(cpu_feature_enabled(X86_FEATURE_IBT) ||
+	      cpu_feature_enabled(X86_FEATURE_SHSTK)))
+		return;
+
+	wrmsrl(MSR_IA32_S_CET, 0);
+	wrmsrl(MSR_IA32_U_CET, 0);
 }
 
 /*
@@ -1470,6 +1492,9 @@ static void __init cpu_parse_early_param(void)
 	if (cmdline_find_option_bool(boot_command_line, "noxsaves"))
 		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
 
+	if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
+		setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
+
 	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
 	if (arglen <= 0)
 		return;
-- 
2.17.1

