Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED1472D604
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbjFMAQZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbjFMAPq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:15:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03EC269D;
        Mon, 12 Jun 2023 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615202; x=1718151202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L2W4szzCW+qvvywxGcp6uHsWCFDTi4NqV9MxxSUxhGY=;
  b=m2hAgSCIvSKQe7x+o4sP0P0iMTZ8eLiENIOoIE8RAIkvuslNZ2qYuvTF
   +yfZfxnyqMLDiH4LSV3hezfYsQoTKxUx6OVJEpST/sv1yMeeZUSiGbz2L
   liCpQVq4v6XmO4n91rEpMHUONW3w2v2cBAJlmAzK3VGeUU/a6TL4wB5gb
   ug+NDKdeVH6SdRMYAyMthq34o7fifKHJDOZaF/lN1h3yBiDbNYIu+g4mV
   MoBhjFnDP3SimoTpcO8FCtbBqqcFiK4hR+I4jDd38dlxZKTPERcvx7Zz2
   J6wII4D/38ew+5WTtadegZ8G7XCiuYOj7sByjMp2SlLrqP80BdLwTT8K+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361557243"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361557243"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671072"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671072"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:28 -0700
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
Subject: [PATCH v9 25/42] x86/fpu: Add helper for modifying xstate
Date:   Mon, 12 Jun 2023 17:10:51 -0700
Message-Id: <20230613001108.3040476-26-rick.p.edgecombe@intel.com>
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

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/fpu/api.h |  9 +++++++++
 arch/x86/kernel/fpu/core.c     | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

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
index caf33486dc5e..f851558b673f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -753,6 +753,24 @@ void switch_fpu_return(void)
 }
 EXPORT_SYMBOL_GPL(switch_fpu_return);
 
+void fpregs_lock_and_load(void)
+{
+	/*
+	 * fpregs_lock() only disables preemption (mostly). So modifying state
+	 * in an interrupt could screw up some in progress fpregs operation.
+	 * Warn about it.
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
+
 #ifdef CONFIG_X86_DEBUG_FPU
 /*
  * If current FPU state according to its tracking (loaded FPU context on this
-- 
2.34.1

