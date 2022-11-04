Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90CA61A43B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiKDWj6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKDWj0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:39:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B859275C0;
        Fri,  4 Nov 2022 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601566; x=1699137566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mTVhLRNKpSbmCscJuYNnJ4SsjQqGcAiqFTAkxD22q3I=;
  b=X6x4CBOppF3ITWJobXajbXNzYzIslHOhiTpt1rto7lkvYzBUykATWZNY
   njwmOETrsfOtqGBSmE4wm4m/1hlZT3RExJ2Dzmodglfe5gTlLzWM3FmLM
   JEqYZlQn46YypfR/DpYe3gEIEfB2tB9nQfGyralVpChPsSc8WkyQdNKOE
   TPVSWvD1qbUYJFdgnkCHuC9g+qGDAqYfEdl+VnqNuCf8xCTjd226Ge9EI
   KSZijs0LZpbunwfH5tP5ulaom/dMN2h9CDIPGrwb00qfjJVaHvYReLVyQ
   y8QUAOAEGpL4v6VrOAnM1AdBzoszppN58P969aDwIRn4N+V/NSN/cjflE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840489"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840489"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668513927"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668513927"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:24 -0700
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v3 04/37] x86/cpufeatures: Enable CET CR4 bit for shadow stack
Date:   Fri,  4 Nov 2022 15:35:31 -0700
Message-Id: <20221104223604.29615-5-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---

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

v1:
 - Moved kernel-parameters.txt changes here from patch 1.

 arch/x86/kernel/cpu/common.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f239098..0ba0a136adcb 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -596,28 +596,51 @@ __noendbr void ibt_restore(u64 save)
 
 #endif
 
+#ifdef CONFIG_X86_CET
 static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 {
-	u64 msr = CET_ENDBR_EN;
+	bool kernel_ibt = HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT);
+	bool user_shstk;
+	u64 msr = 0;
 
-	if (!HAS_KERNEL_IBT ||
-	    !cpu_feature_enabled(X86_FEATURE_IBT))
+	/*
+	 * Enable user shadow stack only if the Linux defined user shadow stack
+	 * cap was not cleared by command line.
+	 */
+	user_shstk = cpu_feature_enabled(X86_FEATURE_SHSTK) &&
+		     IS_ENABLED(CONFIG_X86_USER_SHADOW_STACK) &&
+		     !test_bit(X86_FEATURE_USER_SHSTK, (unsigned long *)cpu_caps_cleared);
+
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
-- 
2.17.1

