Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F0C72D600
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbjFMASn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbjFMARe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:17:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B91AF0;
        Mon, 12 Jun 2023 17:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615247; x=1718151247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Src9+kIB+Tfk1ReeJh4vEiYrNG1G01r+lIh28P15+jA=;
  b=QgMsEJA5QLErJ9NSGDjEfYUTb4UJdi6QHUJiFIV9ZPaamI/8fZoskvLg
   EGQkV6D6Ons2i/3Cbxa7uKZlv9LPdIZjFiOdUs/8zMth95uT2TEQ40Cdm
   jGvsuKB04wUHNK/CQKlLUE/gICny38QWl8ekxu+jSYNRshJLPzpHyfvz6
   AWC6oSsbGWDydV0BrjfOcSOPafkmiVh1nB/6uBcV8M3S9KEmkDuTJ9pV+
   bz59jqqvK1l8jYtqIIjXCtknhx9mckcllIReBjBUaPEKa/JkGZPCIQ2+c
   kIw91sYppsJeoQu6M2r+25HotvQFjSKE2un8UpoVJrgitrljEUU3SCWME
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361557487"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361557487"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671131"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671131"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:37 -0700
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
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     rick.p.edgecombe@intel.com, Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v9 35/42] x86/shstk: Support WRSS for userspace
Date:   Mon, 12 Jun 2023 17:11:01 -0700
Message-Id: <20230613001108.3040476-36-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

>From a fault handler perspective, WRSS will behave very similar to WRUSS,
which is treated like a user access from a #PF err code perspective.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/uapi/asm/prctl.h |  1 +
 arch/x86/kernel/shstk.c           | 43 ++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 6a8e0e1bff4a..eedfde3b63be 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -36,5 +36,6 @@
 
 /* ARCH_SHSTK_ features bits */
 #define ARCH_SHSTK_SHSTK		(1ULL <<  0)
+#define ARCH_SHSTK_WRSS			(1ULL <<  1)
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 04c37b33a625..ea0bf113f9cf 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -390,6 +390,47 @@ void shstk_free(struct task_struct *tsk)
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
@@ -406,7 +447,7 @@ static int shstk_disable(void)
 	fpregs_unlock();
 
 	shstk_free(current);
-	features_clr(ARCH_SHSTK_SHSTK);
+	features_clr(ARCH_SHSTK_SHSTK | ARCH_SHSTK_WRSS);
 
 	return 0;
 }
-- 
2.34.1

