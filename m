Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D90F5F009D
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiI2Wg3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiI2WfY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:35:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EEE1DB54D;
        Thu, 29 Sep 2022 15:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490709; x=1696026709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=SiBonWtkwMqX0JsNUovdDLOqqHtXkkKku/WhNLKvM50=;
  b=MM7XxBAvYp+uLQRzN92VCjDWqaKi5mdpdF8SFo+cBDFcqoE6kTKWxi6o
   G8sRqK154fY3j0G5mYj9dA72t8/a9hO/apDtxTaRYCTAbKaioC33vD6Qw
   Qc2RNDnwyGz5i5ka2XjI5axabn1fBNAaG2iGykflMU9SPJEyVkw61por0
   usqZ2B8V9DREd4fKlbk4so2fQcRK3jc+2FuNERq8vp7JX+wrlDkv8ytcq
   vtPYtZSCBAg41vYgD/SwnGW+RCMDKt9wmgHNlE17a7INyWmQJH7JRIPwZ
   vDBZiq1lmfQ+LN506LdCS4HXdkBQZgRRWDirzyUhKgTzI4381rC6NEt7x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182109"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182109"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016342"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016342"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:46 -0700
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v2 29/39] x86/cet/shstk: Support wrss for userspace
Date:   Thu, 29 Sep 2022 15:29:26 -0700
Message-Id: <20220929222936.14584-30-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For the current shadow stack implementation, shadow stacks contents easily
be arbitrarily provisioned with data. This property helps apps protect
themselves better, but also restricts any potential apps that may want to
do exotic things at the expense of a little security.

The x86 shadow stack feature introduces a new instruction, wrss, which
can be enabled to write directly to shadow stack permissioned memory from
userspace. Allow it to get enabled via the prctl interface.

Only enable the userspace wrss instruction, which allows writes to
userspace shadow stacks from userspace. Do not allow it to be enabled
independently of shadow stack, as HW does not support using WRSS when
shadow stack is disabled.

From a fault handler perspective, WRSS will behave very similar to WRUSS,
which is treated like a user access from a #PF err code perspective.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v2:
 - Add some commit log verbiage from (Dave Hansen)

v1:
 - New patch.

 arch/x86/include/asm/cet.h        |  2 ++
 arch/x86/include/uapi/asm/prctl.h |  1 +
 arch/x86/kernel/shstk.c           | 34 +++++++++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
index 8c6fab9f402a..edf681d4843a 100644
--- a/arch/x86/include/asm/cet.h
+++ b/arch/x86/include/asm/cet.h
@@ -25,6 +25,7 @@ int shstk_disable(void);
 void reset_thread_shstk(void);
 int setup_signal_shadow_stack(struct ksignal *ksig);
 int restore_signal_shadow_stack(void);
+int wrss_control(bool enable);
 #else
 static inline long cet_prctl(struct task_struct *task, int option,
 		      unsigned long features) { return -EINVAL; }
@@ -38,6 +39,7 @@ static inline int shstk_disable(void) { return -EOPNOTSUPP; }
 static inline void reset_thread_shstk(void) {}
 static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
 static inline int restore_signal_shadow_stack(void) { return 0; }
+static inline int wrss_control(bool enable) { return -EOPNOTSUPP; }
 #endif /* CONFIG_X86_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 41af3a8c4fa4..d811f0c5fc4f 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -27,5 +27,6 @@
 #define ARCH_CET_LOCK			0x4003
 
 #define CET_SHSTK			0x1
+#define CET_WRSS			0x2
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 873830d63adc..fc64a04366aa 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -386,6 +386,36 @@ void shstk_free(struct task_struct *tsk)
 	unmap_shadow_stack(shstk->base, shstk->size);
 }
 
+int wrss_control(bool enable)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Only enable wrss if shadow stack is enabled. If shadow stack is not
+	 * enabled, wrss will already be disabled, so don't bother clearing it
+	 * when disabling.
+	 */
+	if (!feature_enabled(CET_SHSTK))
+		return -EPERM;
+
+	/* Already enabled/disabled? */
+	if (feature_enabled(CET_WRSS) == enable)
+		return 0;
+
+	fpu_lock_and_load();
+	if (enable) {
+		set_clr_bits_msrl(MSR_IA32_U_CET, CET_WRSS_EN, 0);
+		feature_set(CET_WRSS);
+	} else {
+		set_clr_bits_msrl(MSR_IA32_U_CET, 0, CET_WRSS_EN);
+		feature_clr(CET_WRSS);
+	}
+	fpregs_unlock();
+
+	return 0;
+}
+
 int shstk_disable(void)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
@@ -397,12 +427,12 @@ int shstk_disable(void)
 
 	fpu_lock_and_load();
 	/* Disable WRSS too when disabling shadow stack */
-	set_clr_bits_msrl(MSR_IA32_U_CET, 0, CET_SHSTK_EN);
+	set_clr_bits_msrl(MSR_IA32_U_CET, 0, CET_SHSTK_EN | CET_WRSS_EN);
 	wrmsrl(MSR_IA32_PL3_SSP, 0);
 	fpregs_unlock();
 
 	shstk_free(current);
-	feature_clr(CET_SHSTK);
+	feature_clr(CET_SHSTK | CET_WRSS);
 
 	return 0;
 }
-- 
2.17.1

