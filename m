Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94E061A442
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKDWkK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKDWj3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:39:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2A432075;
        Fri,  4 Nov 2022 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601568; x=1699137568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4/pxGAyl97+5ZD5/gTFtyEZLTubfAza59sVFqeoJNMY=;
  b=P75ynLi4f3CdcPkP7sRcOKQ0h31R5kobQGfvmHpXcm9EBkELTSWoCmO/
   pQFjJn0OUt6SD77u9ONGIOJTPzx0hwk7A8AVHmcah7/dNsyNcjM00ajdg
   Hr0SYxyDd0aTkddqBulwv19WPoKH1u7/YDfIx57PsJtVviuYQld8AtciS
   JvOMAuLXkf817hkB34EKTU2oS3u+1vpR3HZA+YBVjJ+IkUWBu+PAFyS4k
   TJuautssz1TTffvmTLM3tpClUDiFiA9e/9yVCkmN3N5bEY+qjuoI56lsX
   d60AbM/PHzfUJ/IGy/Btq9sEjxc99V/XthBXCFmzqDR2nFfGX1WABKsfn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840500"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840500"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668513959"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668513959"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:26 -0700
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
Subject: [PATCH v3 06/37] x86/fpu: Add helper for modifying xstate
Date:   Fri,  4 Nov 2022 15:35:33 -0700
Message-Id: <20221104223604.29615-7-rick.p.edgecombe@intel.com>
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

Just like user xfeatures, supervisor xfeatures can be active in the
registers or present in the task FPU buffer. If the registers are
active, the registers can be modified directly. If the registers are
not active, the modification must be performed on the task FPU buffer.

When the state is not active, the kernel could perform modifications
directly to the buffer. But in order for it to do that, it needs
to know where in the buffer the specific state it wants to modify is
located. Doing this is not robust against optimizations that compact
the FPU buffer, as each access would require computing where in the
buffer it is.

The easiest way to modify supervisor xfeature data is to force restore
the registers and write directly to the MSRs. Often times this is just fine
anyway as the registers need to be restored before returning to userspace.
Do this for now, leaving buffer writing optimizations for the future.

Add a new function fpregs_lock_and_load() that can simultaneously call
fpregs_lock() and do this restore. Also perform some extra sanity
checks in this function since this will be used in non-fpu focused code.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v3:
 - Rename to fpregs_lock_and_load() to match the unlocking
   fpregs_unlock(). (Kees)
 - Elaborate in comment about helper. (Dave)

v2:
 - Drop optimization of writing directly the buffer, and change API
   accordingly.
 - fpregs_lock_and_load() suggested by tglx
 - Some commit log verbiage from dhansen

v1:
 - New patch.

 arch/x86/include/asm/fpu/api.h |  9 +++++++++
 arch/x86/kernel/fpu/core.c     | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 503a577814b2..aadc6893dcaa 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -82,6 +82,15 @@ static inline void fpregs_unlock(void)
 		preempt_enable();
 }
 
+/*
+ * FPU state gets lazily restored before returning to userspace. So when in the
+ * kernel, the valid FPU state may be kept in the buffer. This function will force
+ * restore all the fpu state to the registers early if needed, and lock them from
+ * being automatically saved/restored. Then FPU state can be modified safely in the
+ * registers, before unlocking with fpregs_unlock().
+ */
+void fpregs_lock_and_load(void);
+
 #ifdef CONFIG_X86_DEBUG_FPU
 extern void fpregs_assert_state_consistent(void);
 #else
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3b28c5b25e12..8b3162badab7 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -756,6 +756,25 @@ void switch_fpu_return(void)
 }
 EXPORT_SYMBOL_GPL(switch_fpu_return);
 
+void fpregs_lock_and_load(void)
+{
+	/*
+	 * fpregs_lock() only disables preemption (mostly). So modifing state
+	 * in an interrupt could screw up some in progress fpregs operation,
+	 * but appear to work. Warn about it.
+	 */
+	WARN_ON_ONCE(!irq_fpu_usable());
+	WARN_ON_ONCE(current->flags & PF_KTHREAD);
+
+	fpregs_lock();
+
+	fpregs_assert_state_consistent();
+
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		fpregs_restore_userregs();
+}
+EXPORT_SYMBOL_GPL(fpregs_lock_and_load);
+
 #ifdef CONFIG_X86_DEBUG_FPU
 /*
  * If current FPU state according to its tracking (loaded FPU context on this
-- 
2.17.1

