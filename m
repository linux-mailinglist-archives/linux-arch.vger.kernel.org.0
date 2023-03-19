Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F031E6BFE7F
	for <lists+linux-arch@lfdr.de>; Sun, 19 Mar 2023 01:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCSAXC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Mar 2023 20:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCSAW3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Mar 2023 20:22:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9528CC9;
        Sat, 18 Mar 2023 17:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679185210; x=1710721210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hhZNEhMG5Ur6pBP04hNf9KVjJtSiNiJCBm2RUWbtaSg=;
  b=f8/9aQoja0GcL6hEYim3TTpKEgvc0vJqpEXMwC2UzIakJBG+sqHwWHdj
   e34g3zAqHrSFr4AJESgspOusfeoG8xhYjoE2tpNSinjeiCrQLDtpbj/rM
   9LfQPhpAJKr6Ee+ubz3KTxWkuj3nnyXPJ8g3pu/l+eryZaoqlm9fIl6E+
   dh5DikuwehoW72dWYfoaQuzja4WZ9jwqQAV8+HtBII9yffS6uwFbcvPhz
   8Fzs51rbc7jARH8vQfW2UlfwhzIP6cE346qOyrnnolpKJN6hC09kk6dX0
   UromntTIFfSqva3Ub0aRyNxtSoPlRhashAozycD9viaohJbqvuTozmkWG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="338491490"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="338491490"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="749672971"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="749672971"
Received: from bmahatwo-mobl1.gar.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.135.34.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:50 -0700
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
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v8 34/40] x86/shstk: Support WRSS for userspace
Date:   Sat, 18 Mar 2023 17:15:29 -0700
Message-Id: <20230319001535.23210-35-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
References: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
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
can be enabled to write directly to shadow stack memory from userspace.
Allow it to get enabled via the prctl interface.

Only enable the userspace WRSS instruction, which allows writes to
userspace shadow stacks from userspace. Do not allow it to be enabled
independently of shadow stack, as HW does not support using WRSS when
shadow stack is disabled.

From a fault handler perspective, WRSS will behave very similar to WRUSS,
which is treated like a user access from a #PF err code perspective.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v8:
 - Update commit log verbiage (Boris)
 - Drop set_clr_bits_msrl() (Boris)
 - Fix comments wrss->WRSS (Boris)

v6:
 - Make set_clr_bits_msrl() avoid side effects in 'msr'

v5:
 - Switch to EOPNOTSUPP
 - Move set_clr_bits_msrl() to patch where it is first used
 - Commit log formatting

v3:
 - Make wrss_control() static
 - Fix verbiage in commit log (Kees)
---
 arch/x86/include/uapi/asm/prctl.h |  1 +
 arch/x86/kernel/shstk.c           | 43 ++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

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
index 6d2531ce661c..01b45666f1b6 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -360,6 +360,47 @@ void shstk_free(struct task_struct *tsk)
 	unmap_shadow_stack(shstk->base, shstk->size);
 }
 
+static int wrss_control(bool enable)
+{
+	u64 msrval;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Only enable WRSS if shadow stack is enabled. If shadow stack is not
+	 * enabled, WRSS will already be disabled, so don't bother clearing it
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
+	rdmsrl(MSR_IA32_U_CET, msrval);
+
+	if (enable) {
+		features_set(ARCH_SHSTK_WRSS);
+		msrval |= CET_WRSS_EN;
+	} else {
+		features_clr(ARCH_SHSTK_WRSS);
+		if (!(msrval & CET_WRSS_EN))
+			goto unlock;
+
+		msrval &= ~CET_WRSS_EN;
+	}
+
+	wrmsrl(MSR_IA32_U_CET, msrval);
+
+unlock:
+	fpregs_unlock();
+
+	return 0;
+}
+
 static int shstk_disable(void)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
@@ -376,7 +417,7 @@ static int shstk_disable(void)
 	fpregs_unlock();
 
 	shstk_free(current);
-	features_clr(ARCH_SHSTK_SHSTK);
+	features_clr(ARCH_SHSTK_SHSTK | ARCH_SHSTK_WRSS);
 
 	return 0;
 }
-- 
2.17.1

