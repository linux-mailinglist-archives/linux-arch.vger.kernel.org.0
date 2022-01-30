Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09524A3A53
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357011AbiA3V0E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:26:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:52047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356508AbiA3VZe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577934; x=1675113934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=AKky5ODZPWXr+Y60awjhLEp8vC5Ov5UFi7xn02fKIeA=;
  b=W4j/1Hzj27wxvyBkudBZA4TdOp0FgHefSNV/4Bia556bFFAH/eSutVG7
   pK3SiuGIyf15XK0l0+7wk5ir+uRiUf46of/biRyQ80sAWCsJ02L+pQgHf
   IicxXAzOnhu4ekvg2QycepLBLtIVExNP7yz24tnooLF+wwfCvXsJaOEE+
   OmUFMAeBdB0FJ5ZZBvbEPptghU1sDjAVFQTB4VC6AIXmrhLipvqVRg2J/
   Oh/OiVt26QzzHOjs9XQ1/CWId1OzKn+3MZCk7ZG/dUbw7Xf0j4S/srR1n
   P3eo99kSJ4XJtIiDuCzRNBdMYO0ABMv8xYcCO/6gNGRbPNN92/AziQfLB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104974"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104974"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856924"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:07 -0800
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH 27/35] x86/fpu: Add unsafe xsave buffer helpers
Date:   Sun, 30 Jan 2022 13:18:30 -0800
Message-Id: <20220130211838.8382-28-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

CET will need to modify the xsave buffer of a new FPU that was just
created in the process of copying a thread. In this case the normal
helpers will not work, because they operate on the current thread's FPU.

So add unsafe helpers to allow for this kind of modification. Make the
unsafe helpers operate on the MSR like the safe helpers for symmetry and
to avoid exposing the underling xsave structures. Don't add a read
helper because it is not needed at this time.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/fpu/api.h |  9 ++++++---
 arch/x86/kernel/fpu/xstate.c   | 27 ++++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 6aec27984b62..5cb557b9d118 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -167,7 +167,10 @@ extern long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long
 
 void *start_update_xsave_msrs(int xfeature_nr);
 void end_update_xsave_msrs(void);
-int xsave_rdmsrl(void *state, unsigned int msr, unsigned long long *p);
-int xsave_wrmsrl(void *state, u32 msr, u64 val);
-int xsave_set_clear_bits_msrl(void *state, u32 msr, u64 set, u64 clear);
+int xsave_rdmsrl(void *xstate, unsigned int msr, unsigned long long *p);
+int xsave_wrmsrl(void *xstate, u32 msr, u64 val);
+int xsave_set_clear_bits_msrl(void *xstate, u32 msr, u64 set, u64 clear);
+
+void *get_xsave_buffer_unsafe(struct fpu *fpu, int xfeature_nr);
+int xsave_wrmsrl_unsafe(void *xstate, u32 msr, u64 val);
 #endif /* _ASM_X86_FPU_API_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 25b1b0c417fd..71b08026474c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1881,6 +1881,17 @@ static u64 *__get_xsave_member(void *xstate, u32 msr)
 	}
 }
 
+/*
+ * Operate on the xsave buffer directly. It makes no gaurantees that the
+ * buffer will stay valid now or in the futre. This function is pretty
+ * much only useful when the caller knows the fpu's thread can't be
+ * scheduled or otherwise operated on concurrently.
+ */
+void *get_xsave_buffer_unsafe(struct fpu *fpu, int xfeature_nr)
+{
+	return get_xsave_addr(&fpu->fpstate->regs.xsave, xfeature_nr);
+}
+
 /*
  * Return a pointer to the xstate for the feature if it should be used, or NULL
  * if the MSRs should be written to directly. To do this safely, using the
@@ -1971,14 +1982,11 @@ int xsave_rdmsrl(void *xstate, unsigned int msr, unsigned long long *p)
 	return 0;
 }
 
-int xsave_wrmsrl(void *xstate, u32 msr, u64 val)
+
+int xsave_wrmsrl_unsafe(void *xstate, u32 msr, u64 val)
 {
 	u64 *member_ptr;
 
-	__xsave_msrl_prepare_write();
-	if (!xstate)
-		return wrmsrl_safe(msr, val);
-
 	member_ptr = __get_xsave_member(xstate, msr);
 	if (!member_ptr)
 		return 1;
@@ -1988,6 +1996,15 @@ int xsave_wrmsrl(void *xstate, u32 msr, u64 val)
 	return 0;
 }
 
+int xsave_wrmsrl(void *xstate, u32 msr, u64 val)
+{
+	__xsave_msrl_prepare_write();
+	if (!xstate)
+		return wrmsrl_safe(msr, val);
+
+	return xsave_wrmsrl_unsafe(xstate, msr, val);
+}
+
 int xsave_set_clear_bits_msrl(void *xstate, u32 msr, u64 set, u64 clear)
 {
 	u64 val, new_val;
-- 
2.17.1

