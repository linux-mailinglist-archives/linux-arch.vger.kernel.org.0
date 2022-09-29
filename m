Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8595F00B6
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiI2Whh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiI2Wgn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:36:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBD74D158;
        Thu, 29 Sep 2022 15:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490745; x=1696026745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=z6bKqSpBSm7G4FnjcLcDWt5cOl/k3rfBMUw4ayPxySE=;
  b=dwxH6kv0fMygXixfTtwrohKuYsjP9eARrYOudNiNTMTmf1+lyEqK91g7
   UZfm3WVjfTYCoWI3wtvvTKkcn9MIpymLVMWmqS0cZrTyBU5QKVWtpy9ti
   vZcqjYCzXD4b2AznVRfEHv9ame9EobGTzzvndAC+Nds6uMPta4T7YMPls
   eUeUSnyInIbSeHftcGQEE4u5/11g8RvM8KDCkRH17g44u8uRY0jiN5Myx
   1b7hj4NCJdVDPCt3eozSzjk0G7qjdLKyycKHI64nN67Sj6fALtZ5o+n0d
   fPMRRdh7Lb2D+e7oSLoc5QbxbeLYcbAknKDldzq8hxcR/05N4m3Cg6vjL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182204"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182204"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:31:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016392"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016392"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:59 -0700
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
Subject: [OPTIONAL/RFC v2 36/39] x86/fpu: Add helper for initing features
Date:   Thu, 29 Sep 2022 15:29:33 -0700
Message-Id: <20220929222936.14584-37-rick.p.edgecombe@intel.com>
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

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v2:
 - New patch

 arch/x86/kernel/fpu/xstate.c | 58 +++++++++++++++++++++++++++++-------
 arch/x86/kernel/fpu/xstate.h |  6 ++++
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9258fc1169cc..82cee1f2f0c8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -942,6 +942,24 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
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
@@ -962,17 +980,7 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
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
@@ -992,6 +1000,34 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
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
index 5ad47031383b..fb8aae678e9f 100644
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

