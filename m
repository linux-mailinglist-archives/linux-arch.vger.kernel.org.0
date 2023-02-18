Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19EF69BCF6
	for <lists+linux-arch@lfdr.de>; Sat, 18 Feb 2023 22:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjBRVWh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 16:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjBRVVi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 16:21:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226AC199D4;
        Sat, 18 Feb 2023 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676755139; x=1708291139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qXZkRuAhvszhsNxk9zQmBL4ipRAOhXZVRz3O0rxB2RI=;
  b=aBBBdJLJIdvSiOswaNB5PKi4sbnx4xE2HfZNOp509PJ3jhm5MiHiJBUa
   poZRkx5va8t01jl2iH6TcnFZQsXfwGp8V/XwxG9GwUbQPQA9f42CNMbdS
   +IsxWQbvWGpZoWf1K/U18idPnRj0D8Q1vEQwusA/0pXTBV3Dulh5d2yHg
   BhdbetMXJgvWbhoPGOBq5W7Z+NN6sT/9y3GfFCT8yfIHozSM+RvnOOibr
   XuEZ+47Zw7dj0So0ZO/Tz9NZ0FH7sTVWSO2BpRo+qOSkf/sJEhTrsPDJv
   m5/VH6QjGV6LnhfKCFqSW/f3paYSsbuoNcuOKDtU3ZrKQ5h12HWb4q+76
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="418427828"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="418427828"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="664241735"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="664241735"
Received: from adityava-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.80.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:24 -0800
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v6 34/41] x86/shstk: Support WRSS for userspace
Date:   Sat, 18 Feb 2023 13:14:26 -0800
Message-Id: <20230218211433.26859-35-rick.p.edgecombe@intel.com>
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

For the current shadow stack implementation, shadow stacks contents can't
easily be provisioned with arbitrary data. This property helps apps
protect themselves better, but also restricts any potential apps that may
want to do exotic things at the expense of a little security.

The x86 shadow stack feature introduces a new instruction, WRSS, which
can be enabled to write directly to shadow stack permissioned memory from
userspace. Allow it to get enabled via the prctl interface.

Only enable the userspace WRSS instruction, which allows writes to
userspace shadow stacks from userspace. Do not allow it to be enabled
independently of shadow stack, as HW does not support using WRSS when
shadow stack is disabled.

From a fault handler perspective, WRSS will behave very similar to WRUSS,
which is treated like a user access from a #PF err code perspective.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
v6:
 - Make set_clr_bits_msrl() avoid side affects in 'msr'

v5:
 - Switch to EOPNOTSUPP
 - Move set_clr_bits_msrl() to patch where it is first used
 - Commit log formatting

v3:
 - Make wrss_control() static
 - Fix verbiage in commit log (Kees)

v2:
 - Add some commit log verbiage from (Dave Hansen)

v1:
 - New patch.
---
 arch/x86/include/asm/msr.h        | 11 +++++++++++
 arch/x86/include/uapi/asm/prctl.h |  1 +
 arch/x86/kernel/shstk.c           | 32 ++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 65ec1965cd28..2d3b35c957ad 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -310,6 +310,17 @@ void msrs_free(struct msr *msrs);
 int msr_set_bit(u32 msr, u8 bit);
 int msr_clear_bit(u32 msr, u8 bit);
 
+/* Helper that can never get accidentally un-inlined. */
+#define set_clr_bits_msrl(msr, set, clear)	do {	\
+	u64 __val, __new_val, __msr = msr;		\
+							\
+	rdmsrl(__msr, __val);				\
+	__new_val = (__val & ~(clear)) | (set);		\
+							\
+	if (__new_val != __val)				\
+		wrmsrl(__msr, __new_val);		\
+} while (0)
+
 #ifdef CONFIG_SMP
 int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 7dfd9dc00509..e31495668056 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -28,5 +28,6 @@
 
 /* ARCH_SHSTK_ features bits */
 #define ARCH_SHSTK_SHSTK		(1ULL <<  0)
+#define ARCH_SHSTK_WRSS			(1ULL <<  1)
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 0a3decab70ee..009cb3fa0ae5 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -363,6 +363,36 @@ void shstk_free(struct task_struct *tsk)
 	unmap_shadow_stack(shstk->base, shstk->size);
 }
 
+static int wrss_control(bool enable)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Only enable wrss if shadow stack is enabled. If shadow stack is not
+	 * enabled, wrss will already be disabled, so don't bother clearing it
+	 * when disabling.
+	 */
+	if (!features_enabled(ARCH_SHSTK_SHSTK))
+		return -EPERM;
+
+	/* Already enabled/disabled? */
+	if (features_enabled(ARCH_SHSTK_WRSS) == enable)
+		return 0;
+
+	fpregs_lock_and_load();
+	if (enable) {
+		set_clr_bits_msrl(MSR_IA32_U_CET, CET_WRSS_EN, 0);
+		features_set(ARCH_SHSTK_WRSS);
+	} else {
+		set_clr_bits_msrl(MSR_IA32_U_CET, 0, CET_WRSS_EN);
+		features_clr(ARCH_SHSTK_WRSS);
+	}
+	fpregs_unlock();
+
+	return 0;
+}
+
 static int shstk_disable(void)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
@@ -379,7 +409,7 @@ static int shstk_disable(void)
 	fpregs_unlock();
 
 	shstk_free(current);
-	features_clr(ARCH_SHSTK_SHSTK);
+	features_clr(ARCH_SHSTK_SHSTK | ARCH_SHSTK_WRSS);
 
 	return 0;
 }
-- 
2.17.1

