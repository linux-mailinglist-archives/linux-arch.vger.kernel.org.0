Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64870674503
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 22:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjASVmA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 16:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjASViw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 16:38:52 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C0F10A97;
        Thu, 19 Jan 2023 13:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674163679; x=1705699679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Y8HP+6SI6A4E79h0YyqSt+wn/k0j51I/AMnEXqlWOFs=;
  b=PD1B4p16BOBls0XwR8Y2cdpmts1U9YPGrfE8GvFU1S45++EsnSMBuZ8o
   2m3MWRM0IYKoVc1s5p/dsaRnxYTqeu+fuO+6Y+Y1DRE1/P+8gqe7+z4Mo
   pdjXvTQFkMUmT6QREPzqPu+yN1ZFtHiFkB06cts1pYYS+sVILde0h0Fkg
   +fut8mzK1cURAnspl+OknZENH3sFNIF6eJp2hcg7VACPbkcwg0b00TUV9
   p0vREIpGRJgeT0wWPX2NxWeNJPgmjXk1YP1dBqcbBurTr6OMMSYvApw1O
   MJW0wCsn5Sd59rZ84eFjXBcj1tCra9pgfiBJZq0ZT1kTNNICTDdCIBCom
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323120040"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323120040"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:24:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989139185"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="989139185"
Received: from hossain3-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.252.128.187])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:24:20 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v5 36/39] x86/fpu: Add helper for initing features
Date:   Thu, 19 Jan 2023 13:23:14 -0800
Message-Id: <20230119212317.8324-37-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If an xfeature is saved in a buffer, the xfeature's bit will be set in
xsave->header.xfeatures. The CPU may opt to not save the xfeature if it
is in it's init state. In this case the xfeature buffer address cannot
be retrieved with get_xsave_addr().

Future patches will need to handle the case of writing to an xfeature
that may not be saved. So provide helpers to init an xfeature in an
xsave buffer.

This could of course be done directly by reaching into the xsave buffer,
however this would not be robust against future changes to optimize the
xsave buffer by compacting it. In that case the xsave buffer would need
to be re-arranged as well. So the logic properly belongs encapsulated
in a helper where the logic can be unified.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v2:
 - New patch

 arch/x86/kernel/fpu/xstate.c | 58 +++++++++++++++++++++++++++++-------
 arch/x86/kernel/fpu/xstate.h |  6 ++++
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 13a80521dd51..3ff80be0a441 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -934,6 +934,24 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 	return (void *)xsave + xfeature_get_offset(xcomp_bv, xfeature_nr);
 }
 
+static int xsave_buffer_access_checks(int xfeature_nr)
+{
+	/*
+	 * Do we even *have* xsave state?
+	 */
+	if (!boot_cpu_has(X86_FEATURE_XSAVE))
+		return 1;
+
+	/*
+	 * We should not ever be requesting features that we
+	 * have not enabled.
+	 */
+	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
+		return 1;
+
+	return 0;
+}
+
 /*
  * Given the xsave area and a state inside, this function returns the
  * address of the state.
@@ -954,17 +972,7 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
  */
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 {
-	/*
-	 * Do we even *have* xsave state?
-	 */
-	if (!boot_cpu_has(X86_FEATURE_XSAVE))
-		return NULL;
-
-	/*
-	 * We should not ever be requesting features that we
-	 * have not enabled.
-	 */
-	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
+	if (xsave_buffer_access_checks(xfeature_nr))
 		return NULL;
 
 	/*
@@ -984,6 +992,34 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 	return __raw_xsave_addr(xsave, xfeature_nr);
 }
 
+/*
+ * Given the xsave area and a state inside, this function
+ * initializes an xfeature in the buffer.
+ *
+ * get_xsave_addr() will return NULL if the feature bit is
+ * not present in the header. This function will make it so
+ * the xfeature buffer address is ready to be retrieved by
+ * get_xsave_addr().
+ *
+ * Inputs:
+ *	xstate: the thread's storage area for all FPU data
+ *	xfeature_nr: state which is defined in xsave.h (e.g. XFEATURE_FP,
+ *	XFEATURE_SSE, etc...)
+ * Output:
+ *	1 if the feature cannot be inited, 0 on success
+ */
+int init_xfeature(struct xregs_state *xsave, int xfeature_nr)
+{
+	if (xsave_buffer_access_checks(xfeature_nr))
+		return 1;
+
+	/*
+	 * Mark the feature inited.
+	 */
+	xsave->header.xfeatures |= BIT_ULL(xfeature_nr);
+	return 0;
+}
+
 #ifdef CONFIG_ARCH_HAS_PKEYS
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index a4ecb04d8d64..dc06f63063ee 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -54,6 +54,12 @@ extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system_xstate(unsigned int legacy_size);
 
 extern void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
+extern int init_xfeature(struct xregs_state *xsave, int xfeature_nr);
+
+static inline int xfeature_saved(struct xregs_state *xsave, int xfeature_nr)
+{
+	return xsave->header.xfeatures & BIT_ULL(xfeature_nr);
+}
 
 static inline u64 xfeatures_mask_supervisor(void)
 {
-- 
2.17.1

