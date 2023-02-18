Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1354B69BC5A
	for <lists+linux-arch@lfdr.de>; Sat, 18 Feb 2023 22:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBRVRB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 16:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjBRVQK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 16:16:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60331166F2;
        Sat, 18 Feb 2023 13:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676754962; x=1708290962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=P0vRMRHavNRGpizZkq3RL8rMxSsVzWcbrEXvoEvUKSg=;
  b=SS+vIpfE72kZ2GLT/RfnSGDmPKYIHEVKxrBDkR2CH0C2J6+9bhNRRQtN
   +AI1HLfIupVKMcMX1palvM8QnFPVzROCXI+b7x3sMVBb5cYwwmswso1nw
   ElggkvPa2IcyWex+aR+tUFGmmXauWGh7jW2qPNmiTi5M9kW2jJH9ObkeN
   RLC3yAKqtdpQk/rdH/N0Yy8sjwmqB3d5Q+hm4MxNy9GUjfAUWnFXkdUWC
   CgG8MzuQSVM68Fa59FHPmnCu+7f4o6mIqLrHVdcxj5rcOnQaG/jmuufmU
   p6kI7zpTMHd1tEZQjb7Y0kvNNeRU1z5s6GAr5vhVS/Ye3fzSUqHSE9UbV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="418427159"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="418427159"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="664241585"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="664241585"
Received: from adityava-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.80.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:15:59 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v6 04/41] x86/cpufeatures: Enable CET CR4 bit for shadow stack
Date:   Sat, 18 Feb 2023 13:13:56 -0800
Message-Id: <20230218211433.26859-5-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---
v5:
 - Remove #ifdeffery (Boris)

v4:
 - Add back dedicated command line disable: "nousershstk" (Boris)

v3:
 - Remove stay new line (Boris)
 - Simplify commit log (Andrew Cooper)

v2:
 - In the shadow stack case, go back to only setting CR4.CET if the
   kernel is compiled with user shadow stack support.
 - Clear MSR_IA32_U_CET as well. (PeterZ)
---
 arch/x86/kernel/cpu/common.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 38646f1b5f14..30c524cd8cad 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -599,27 +599,43 @@ __noendbr void ibt_restore(u64 save)
 
 static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 {
-	u64 msr = CET_ENDBR_EN;
+	bool user_shstk, kernel_ibt;
 
-	if (!HAS_KERNEL_IBT ||
-	    !cpu_feature_enabled(X86_FEATURE_IBT))
+	if (!IS_ENABLED(CONFIG_X86_CET))
 		return;
 
-	wrmsrl(MSR_IA32_S_CET, msr);
+	kernel_ibt = HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT);
+	user_shstk = cpu_feature_enabled(X86_FEATURE_SHSTK) &&
+		     IS_ENABLED(CONFIG_X86_USER_SHADOW_STACK);
+
+	if (!kernel_ibt && !user_shstk)
+		return;
+
+	if (user_shstk)
+		set_cpu_cap(c, X86_FEATURE_USER_SHSTK);
+
+	if (kernel_ibt)
+		wrmsrl(MSR_IA32_S_CET, CET_ENDBR_EN);
+	else
+		wrmsrl(MSR_IA32_S_CET, 0);
+
 	cr4_set_bits(X86_CR4_CET);
 
-	if (!ibt_selftest()) {
+	if (kernel_ibt && !ibt_selftest()) {
 		pr_err("IBT selftest: Failed!\n");
 		wrmsrl(MSR_IA32_S_CET, 0);
 		setup_clear_cpu_cap(X86_FEATURE_IBT);
-		return;
 	}
 }
 
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
@@ -1476,6 +1492,9 @@ static void __init cpu_parse_early_param(void)
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

