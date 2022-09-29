Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F21C5F002B
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiI2WaT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiI2W35 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:29:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164181F2FE;
        Thu, 29 Sep 2022 15:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490596; x=1696026596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=aQ5z6eOsVvFJ2Mg3fViTs1TwTvR0tJtyuBHvl8Ak6H4=;
  b=TZpiebivFzsDhzr7GB9vvHEpdJY5FVN+tJX1n3GGp450G/NUKnszi0n3
   EZcs9T3P4A1+b1alZjePgBi6hOgIA9AdBAWA3oHtGDCsl763zhN0be66g
   Po0uOQlPbvwd2HlNHfktS/ngM71LSyvJIdeBT+p0+FQMkiCD31pj7bd8c
   2jlIdvF8IYtq1M2wQmesQZO56CGfw7Oilh0sutlv3A2PfzAnn4ELGXhed
   Y1/bnTaGrjgseoqGN2NO+yyHgdokbeKMAyyxJmAaQpQgFoAhtlrxY33FE
   8EjdCD43wCosSgsYtvYxB4ZNpKgivLWwzGwM5ymsLAT+8qUGZ1nB2zYyY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303531331"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="303531331"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:29:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016087"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016087"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:29:52 -0700
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
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v2 04/39] x86/cpufeatures: Enable CET CR4 bit for shadow stack
Date:   Thu, 29 Sep 2022 15:29:01 -0700
Message-Id: <20220929222936.14584-5-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Utilizing CET features requires a CR4 bit to be enabled as well as bits
to be set in CET MSRs. Setting the CR4 bit does two things:
 1. Enables the usage of WRUSS instruction, which the kernel can use to
    write to userspace shadow stacks.
 2. Allows those individual aspects of CET to be enabled later via the MSR.
 3. Allows CET to be enabled in guests

While future patches will allow the MSR values to be saved and restored
per task, the CR4 bit will allow for WRUSS to be used regardless of if a
tasks CET MSRs have been restored.

Kernel IBT already enables the CET CR4 bit when it detects IBT HW support
and is configured with kernel IBT. However future patches that enable
userspace shadow stack support will need the bit set as well. So change
the logic to enable it in either case.

Clear MSR_IA32_U_CET in cet_disable() so that it can't live to see
userspace in a new kexec-ed kernel that has CR4.CET set from kernel IBT.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---

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

Yu-cheng v25:
 - Remove software-defined X86_FEATURE_CET.

 arch/x86/kernel/cpu/common.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f239098..d7415bb556b2 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -598,16 +598,21 @@ __noendbr void ibt_restore(u64 save)
 
 static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 {
-	u64 msr = CET_ENDBR_EN;
+	bool kernel_ibt = HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT);
+	bool user_shstk = IS_ENABLED(CONFIG_X86_SHADOW_STACK) &&
+			  cpu_feature_enabled(X86_FEATURE_SHSTK);
+	u64 msr = 0;
 
-	if (!HAS_KERNEL_IBT ||
-	    !cpu_feature_enabled(X86_FEATURE_IBT))
+	if (!kernel_ibt && !user_shstk)
 		return;
 
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
@@ -616,10 +621,15 @@ static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 
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
 
+
 /*
  * Some CPU features depend on higher CPUID levels, which may not always
  * be available due to CPUID level capping or broken virtualization
-- 
2.17.1

