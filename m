Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E6961A4A8
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKDWov (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiKDWnu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:43:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E1D66CB0;
        Fri,  4 Nov 2022 15:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601633; x=1699137633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=xYUN5lPpKChBVK2npDRqZ1rxSFprNl3Bqg8OsGm5TD4=;
  b=Y/9xKPT/urutBBTIw034vEp2FgtuQIIzaKcVyTr/FhFEoHlRk2Hwz/4W
   4T1CC4ovM8B0e8gyohRB1cpCIkMah1BTfOzJrBgkCfM8SRHDhSUifNI17
   4X7VB6kO1FgfG81HtP62C0s/JZMagaUnDbpgi/WlbBtYQsgvWwI+CKq/q
   ix1NgPZOgQRH+oE9gJWUN4K3SIF7rOp56hvL5ZQb0eddrv4VroTa2TaLu
   6QuVmODe1Dsg0A+mqD4p77VcbvY2yJv3S9MMkouP3wyuOIe832/Th5y94
   ReN1yyqGHmQQUDiDFRGOIRsS/ubHtvFvLaeWMM3jMXMlsmaVOvykDXsG5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840596"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840596"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668514139"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668514139"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:48 -0700
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v3 30/37] x86/shstk: Support wrss for userspace
Date:   Fri,  4 Nov 2022 15:35:57 -0700
Message-Id: <20221104223604.29615-31-rick.p.edgecombe@intel.com>
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

For the current shadow stack implementation, shadow stacks contents can't
easily be provisioned with arbitrary data. This property helps apps
protect themselves better, but also restricts any potential apps that may
want to do exotic things at the expense of a little security.

The x86 shadow stack feature introduces a new instruction, wrss, which
can be enabled to write directly to shadow stack permissioned memory from
userspace. Allow it to get enabled via the prctl interface.

Only enable the userspace wrss instruction, which allows writes to
userspace shadow stacks from userspace. Do not allow it to be enabled
independently of shadow stack, as HW does not support using WRSS when
shadow stack is disabled.

From a fault handler perspective, WRSS will behave very similar to WRUSS,
which is treated like a user access from a #PF err code perspective.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v3:
 - Make wrss_control() static
 - Fix verbiage in commit log (Kees)

v2:
 - Add some commit log verbiage from (Dave Hansen)

v1:
 - New patch.

 arch/x86/include/uapi/asm/prctl.h |  1 +
 arch/x86/kernel/shstk.c           | 33 +++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index dad5288bf086..5f1d3181e4a1 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -28,5 +28,6 @@
 
 /* ARCH_CET_ features bits */
 #define CET_SHSTK			(1ULL <<  0)
+#define CET_WRSS			(1ULL <<  1)
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 9a025eea520f..cbd0970b26d7 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -364,6 +364,35 @@ void shstk_free(struct task_struct *tsk)
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
+	if (!features_enabled(CET_SHSTK))
+		return -EPERM;
+
+	/* Already enabled/disabled? */
+	if (features_enabled(CET_WRSS) == enable)
+		return 0;
+
+	fpregs_lock_and_load();
+	if (enable) {
+		set_clr_bits_msrl(MSR_IA32_U_CET, CET_WRSS_EN, 0);
+		features_set(CET_WRSS);
+	} else {
+		set_clr_bits_msrl(MSR_IA32_U_CET, 0, CET_WRSS_EN);
+		features_clr(CET_WRSS);
+	}
+	fpregs_unlock();
+
+	return 0;
+}
 
 static int shstk_disable(void)
 {
@@ -376,12 +405,12 @@ static int shstk_disable(void)
 
 	fpregs_lock_and_load();
 	/* Disable WRSS too when disabling shadow stack */
-	set_clr_bits_msrl(MSR_IA32_U_CET, 0, CET_SHSTK_EN);
+	set_clr_bits_msrl(MSR_IA32_U_CET, 0, CET_SHSTK_EN | CET_WRSS_EN);
 	wrmsrl(MSR_IA32_PL3_SSP, 0);
 	fpregs_unlock();
 
 	shstk_free(current);
-	features_clr(CET_SHSTK);
+	features_clr(CET_SHSTK | CET_WRSS);
 
 	return 0;
 }
-- 
2.17.1

