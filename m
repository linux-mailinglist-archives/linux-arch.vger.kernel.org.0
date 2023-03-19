Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A76BFE8F
	for <lists+linux-arch@lfdr.de>; Sun, 19 Mar 2023 01:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCSAX6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Mar 2023 20:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCSAXV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Mar 2023 20:23:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BC42C644;
        Sat, 18 Mar 2023 17:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679185253; x=1710721253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vzjvLf4i3g21tZUx0No2irY3Y9uThaxbSSa7EUI0VaM=;
  b=NsGne9sC8MfVPTp/BxZNE4Q2u/+TcbeOBk8lOIzyV39w/L4O7adgjq3D
   lgRr6c7qiwRinTSWktoC8lGIRFRB8zbWwvZyq6sRCg2b6/lUutII3NcjN
   T92aE7MblV3it8nMwXoif42u3BSfW03GdiThxiBrV6KDbgBBdQUJ2urRx
   TBJ1J8wZ24a6sSvuBSrGZRNfD2NOqF2d6i/pCVeVOmU3egaZuMLq4ADYK
   7VMB/vh3QXb33q5QzMLFCzZAi1mZMrYU3wlEy5IAiejUEk/y6AlVOD5c+
   3Kgc9i40VrROOeJp9IzxnfowG6ww/bZZConHYuwjlCQFkK6EXP+U/OHSB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="338491580"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="338491580"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="749673008"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="749673008"
Received: from bmahatwo-mobl1.gar.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.135.34.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:56 -0700
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
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 38/40] x86: Add PTRACE interface for shadow stack
Date:   Sat, 18 Mar 2023 17:15:33 -0700
Message-Id: <20230319001535.23210-39-rick.p.edgecombe@intel.com>
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

Some applications (like GDB) would like to tweak shadow stack state via
ptrace. This allows for existing functionality to continue to work for
seized shadow stack applications. Provide a regset interface for
manipulating the shadow stack pointer (SSP).

There is already ptrace functionality for accessing xstate, but this
does not include supervisor xfeatures. So there is not a completely
clear place for where to put the shadow stack state. Adding it to the
user xfeatures regset would complicate that code, as it currently shares
logic with signals which should not have supervisor features.

Don't add a general supervisor xfeature regset like the user one,
because it is better to maintain flexibility for other supervisor
xfeatures to define their own interface. For example, an xfeature may
decide not to expose all of it's state to userspace, as is actually the
case for  shadow stack ptrace functionality. A lot of enum values remain
to be used, so just put it in dedicated shadow stack regset.

The only downside to not having a generic supervisor xfeature regset,
is that apps need to be enlightened of any new supervisor xfeature
exposed this way (i.e. they can't try to have generic save/restore
logic). But maybe that is a good thing, because they have to think
through each new xfeature instead of encountering issues when a new
supervisor xfeature was added.

By adding a shadow stack regset, it also has the effect of including the
shadow stack state in a core dump, which could be useful for debugging.

The shadow stack specific xstate includes the SSP, and the shadow stack
and WRSS enablement status. Enabling shadow stack or WRSS in the kernel
involves more than just flipping the bit. The kernel is made aware that
it has to do extra things when cloning or handling signals. That logic
is triggered off of separate feature enablement state kept in the task
struct. So the flipping on HW shadow stack enforcement without notifying
the kernel to change its behavior would severely limit what an application
could do without crashing, and the results would depend on kernel
internal implementation details. There is also no known use for controlling
this state via ptrace today. So only expose the SSP, which is something
that userspace already has indirect control over.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v8:
 - Update commit log verbiage (Boris)
 - Stop using init_xfeature() and just return an error if the init state
   is encountered, since it shouldn't be. (Boris)

v5:
 - Check shadow stack enablement status for tracee (rppt)
 - Fix typo in comment

v4:
 - Make shadow stack only. Reduce to only supporting SSP register, and
   remove CET references (peterz)
 - Add comment to not use 0x203, because binutils already looks for it in
   coredumps. (Christina Schimpe)

v3:
 - Drop dependence on thread.shstk.size, and use thread.features bits
 - Drop 32 bit support
---
 arch/x86/include/asm/fpu/regset.h |  7 +--
 arch/x86/kernel/fpu/regset.c      | 78 +++++++++++++++++++++++++++++++
 arch/x86/kernel/ptrace.c          | 12 +++++
 include/uapi/linux/elf.h          |  2 +
 4 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/regset.h b/arch/x86/include/asm/fpu/regset.h
index 4f928d6a367b..697b77e96025 100644
--- a/arch/x86/include/asm/fpu/regset.h
+++ b/arch/x86/include/asm/fpu/regset.h
@@ -7,11 +7,12 @@
 
 #include <linux/regset.h>
 
-extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active;
+extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active,
+				ssp_active;
 extern user_regset_get2_fn fpregs_get, xfpregs_get, fpregs_soft_get,
-				 xstateregs_get;
+				 xstateregs_get, ssp_get;
 extern user_regset_set_fn fpregs_set, xfpregs_set, fpregs_soft_set,
-				 xstateregs_set;
+				 xstateregs_set, ssp_set;
 
 /*
  * xstateregs_active == regset_fpregs_active. Please refer to the comment
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 6d056b68f4ed..f0a8eaf7c52e 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -8,6 +8,7 @@
 #include <asm/fpu/api.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
+#include <asm/prctl.h>
 
 #include "context.h"
 #include "internal.h"
@@ -174,6 +175,83 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	return ret;
 }
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+int ssp_active(struct task_struct *target, const struct user_regset *regset)
+{
+	if (target->thread.features & ARCH_SHSTK_SHSTK)
+		return regset->n;
+
+	return 0;
+}
+
+int ssp_get(struct task_struct *target, const struct user_regset *regset,
+	    struct membuf to)
+{
+	struct fpu *fpu = &target->thread.fpu;
+	struct cet_user_state *cetregs;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return -ENODEV;
+
+	sync_fpstate(fpu);
+	cetregs = get_xsave_addr(&fpu->fpstate->regs.xsave, XFEATURE_CET_USER);
+	if (WARN_ON(!cetregs)) {
+		/*
+		 * This shouldn't ever be NULL because shadow stack was
+		 * verified to be enabled above. This means
+		 * MSR_IA32_U_CET.CET_SHSTK_EN should be 1 and so
+		 * XFEATURE_CET_USER should not be in the init state.
+		 */
+		return -ENODEV;
+	}
+
+	return membuf_write(&to, (unsigned long *)&cetregs->user_ssp,
+			    sizeof(cetregs->user_ssp));
+}
+
+int ssp_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf)
+{
+	struct fpu *fpu = &target->thread.fpu;
+	struct xregs_state *xsave = &fpu->fpstate->regs.xsave;
+	struct cet_user_state *cetregs;
+	unsigned long user_ssp;
+	int r;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !ssp_active(target, regset))
+		return -ENODEV;
+
+	r = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &user_ssp, 0, -1);
+	if (r)
+		return r;
+
+	/*
+	 * Some kernel instructions (IRET, etc) can cause exceptions in the case
+	 * of disallowed CET register values. Just prevent invalid values.
+	 */
+	if (user_ssp >= TASK_SIZE_MAX || !IS_ALIGNED(user_ssp, 8))
+		return -EINVAL;
+
+	fpu_force_restore(fpu);
+
+	cetregs = get_xsave_addr(xsave, XFEATURE_CET_USER);
+	if (WARN_ON(!cetregs)) {
+		/*
+		 * This shouldn't ever be NULL because shadow stack was
+		 * verified to be enabled above. This means
+		 * MSR_IA32_U_CET.CET_SHSTK_EN should be 1 and so
+		 * XFEATURE_CET_USER should not be in the init state.
+		 */
+		return -ENODEV;
+	}
+
+	cetregs->user_ssp = user_ssp;
+	return 0;
+}
+#endif /* CONFIG_X86_USER_SHADOW_STACK */
+
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 
 /*
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index dfaa270a7cc9..095f04bdabdc 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -58,6 +58,7 @@ enum x86_regset_64 {
 	REGSET64_FP,
 	REGSET64_IOPERM,
 	REGSET64_XSTATE,
+	REGSET64_SSP,
 };
 
 #define REGSET_GENERAL \
@@ -1267,6 +1268,17 @@ static struct user_regset x86_64_regsets[] __ro_after_init = {
 		.active		= ioperm_active,
 		.regset_get	= ioperm_get
 	},
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+	[REGSET64_SSP] = {
+		.core_note_type	= NT_X86_SHSTK,
+		.n		= 1,
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.active		= ssp_active,
+		.regset_get	= ssp_get,
+		.set		= ssp_set
+	},
+#endif
 };
 
 static const struct user_regset_view user_x86_64_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index ac3da855fb19..fa1ceeae2596 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -406,6 +406,8 @@ typedef struct elf64_shdr {
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
+/* Old binutils treats 0x203 as a CET state */
+#define NT_X86_SHSTK	0x204		/* x86 SHSTK state */
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
 #define NT_S390_TIMER	0x301		/* s390 timer register */
 #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
-- 
2.17.1

