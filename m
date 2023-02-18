Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADF269BC62
	for <lists+linux-arch@lfdr.de>; Sat, 18 Feb 2023 22:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBRVRN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 16:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBRVQO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 16:16:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A66717140;
        Sat, 18 Feb 2023 13:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676754964; x=1708290964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=5VUE7h8Acx3iz1NYmWp0nvOV1gNofXGCRfQNxNEPRuQ=;
  b=RJmFFz1bVkag1a890c4DutZ56OEbALufUbKY+uoKEJVBs3EAMEJK/z41
   Dp/MwiZ8+px5+utaE3aMW64vd7cHWS887rovcvQvgaci6XyLera6SX1HY
   d304US/ApMBNKKgzZ74OJLbiTheL5YbQS7wTGXqUVEvLjwzhKQFNNsV7O
   Cf1bABvmfh6daGWY5MP5DndIz/H1W19gfbTdM99j4HsasreBC7Gv2o4Dv
   ZQCxZSlE5KVyRESH3jCk6tD4cBtgGsfVSBSqtRJOzqODgSaij+bAXOLa/
   dO4pRtpmFwkoA8F5J3x1HqQxoDNCi0sEXHZ/Bs71NY8RZ79KpRpQcnbZB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="418427182"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="418427182"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="664241589"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="664241589"
Received: from adityava-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.80.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:00 -0800
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
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v6 05/41] x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states
Date:   Sat, 18 Feb 2023 13:13:57 -0800
Message-Id: <20230218211433.26859-6-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Shadow stack register state can be managed with XSAVE. The registers
can logically be separated into two groups:
        * Registers controlling user-mode operation
        * Registers controlling kernel-mode operation

The architecture has two new XSAVE state components: one for each group
of those groups of registers. This lets an OS manage them separately if
it chooses. Future patches for host userspace and KVM guests will only
utilize the user-mode registers, so only configure XSAVE to save
user-mode registers. This state will add 16 bytes to the xsave buffer
size.

Future patches will use the user-mode XSAVE area to save guest user-mode
CET state. However, VMCS includes new fields for guest CET supervisor
states. KVM can use these to save and restore guest supervisor state, so
host supervisor XSAVE support is not required.

Adding this exacerbates the already unwieldy if statement in
check_xstate_against_struct() that handles warning about un-implemented
xfeatures. So refactor these check's by having XCHECK_SZ() set a bool when
it actually check's the xfeature. This ends up exceeding 80 chars, but was
better on balance than other options explored. Pass the bool as pointer to
make it clear that XCHECK_SZ() can change the variable.

While configuring user-mode XSAVE, clarify kernel-mode registers are not
managed by XSAVE by defining the xfeature in
XFEATURE_MASK_SUPERVISOR_UNSUPPORTED, like is done for XFEATURE_MASK_PT.
This serves more of a documentation as code purpose, and functionally,
only enables a few safety checks.

Both XSAVE state components are supervisor states, even the state
controlling user-mode operation. This is a departure from earlier features
like protection keys where the PKRU state is a normal user
(non-supervisor) state. Having the user state be supervisor-managed
ensures there is no direct, unprivileged access to it, making it harder
for an attacker to subvert CET.

To facilitate this privileged access, define the two user-mode CET MSRs,
and the bits defined in those MSRs relevant to future shadow stack
enablement patches.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---
v5:
 - Move comments from end of lines in cet_user_state struct (Boris)

v3:
 - Add missing "is" in commit log (Boris)
 - Change to case statement for struct size checking (Boris)
 - Adjust commas on xfeature_names (Kees, Boris)

v2:
 - Change name to XFEATURE_CET_KERNEL_UNUSED (peterz)

KVM refresh:
 - Reword commit log using some verbiage posted by Dave Hansen
 - Remove unlikely to be used supervisor cet xsave struct
 - Clarify that supervisor cet state is not saved by xsave
 - Remove unused supervisor MSRs
---
 arch/x86/include/asm/fpu/types.h  | 16 +++++-
 arch/x86/include/asm/fpu/xstate.h |  6 ++-
 arch/x86/kernel/fpu/xstate.c      | 90 +++++++++++++++----------------
 3 files changed, 61 insertions(+), 51 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 7f6d858ff47a..eb810074f1e7 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -115,8 +115,8 @@ enum xfeature {
 	XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
 	XFEATURE_PKRU,
 	XFEATURE_PASID,
-	XFEATURE_RSRVD_COMP_11,
-	XFEATURE_RSRVD_COMP_12,
+	XFEATURE_CET_USER,
+	XFEATURE_CET_KERNEL_UNUSED,
 	XFEATURE_RSRVD_COMP_13,
 	XFEATURE_RSRVD_COMP_14,
 	XFEATURE_LBR,
@@ -138,6 +138,8 @@ enum xfeature {
 #define XFEATURE_MASK_PT		(1 << XFEATURE_PT_UNIMPLEMENTED_SO_FAR)
 #define XFEATURE_MASK_PKRU		(1 << XFEATURE_PKRU)
 #define XFEATURE_MASK_PASID		(1 << XFEATURE_PASID)
+#define XFEATURE_MASK_CET_USER		(1 << XFEATURE_CET_USER)
+#define XFEATURE_MASK_CET_KERNEL	(1 << XFEATURE_CET_KERNEL_UNUSED)
 #define XFEATURE_MASK_LBR		(1 << XFEATURE_LBR)
 #define XFEATURE_MASK_XTILE_CFG		(1 << XFEATURE_XTILE_CFG)
 #define XFEATURE_MASK_XTILE_DATA	(1 << XFEATURE_XTILE_DATA)
@@ -252,6 +254,16 @@ struct pkru_state {
 	u32				pad;
 } __packed;
 
+/*
+ * State component 11 is Control-flow Enforcement user states
+ */
+struct cet_user_state {
+	/* user control-flow settings */
+	u64 user_cet;
+	/* user shadow stack pointer */
+	u64 user_ssp;
+};
+
 /*
  * State component 15: Architectural LBR configuration state.
  * The size of Arch LBR state depends on the number of LBRs (lbr_depth).
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index cd3dd170e23a..d4427b88ee12 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -50,7 +50,8 @@
 #define XFEATURE_MASK_USER_DYNAMIC	XFEATURE_MASK_XTILE_DATA
 
 /* All currently supported supervisor features */
-#define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
+#define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID | \
+					    XFEATURE_MASK_CET_USER)
 
 /*
  * A supervisor state component may not always contain valuable information,
@@ -77,7 +78,8 @@
  * Unsupported supervisor features. When a supervisor feature in this mask is
  * supported in the future, move it to the supported supervisor feature mask.
  */
-#define XFEATURE_MASK_SUPERVISOR_UNSUPPORTED (XFEATURE_MASK_PT)
+#define XFEATURE_MASK_SUPERVISOR_UNSUPPORTED (XFEATURE_MASK_PT | \
+					      XFEATURE_MASK_CET_KERNEL)
 
 /* All supervisor states including supported and unsupported states. */
 #define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 714166cc25f2..13a80521dd51 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -39,26 +39,26 @@
  */
 static const char *xfeature_names[] =
 {
-	"x87 floating point registers"	,
-	"SSE registers"			,
-	"AVX registers"			,
-	"MPX bounds registers"		,
-	"MPX CSR"			,
-	"AVX-512 opmask"		,
-	"AVX-512 Hi256"			,
-	"AVX-512 ZMM_Hi256"		,
-	"Processor Trace (unused)"	,
+	"x87 floating point registers",
+	"SSE registers",
+	"AVX registers",
+	"MPX bounds registers",
+	"MPX CSR",
+	"AVX-512 opmask",
+	"AVX-512 Hi256",
+	"AVX-512 ZMM_Hi256",
+	"Processor Trace (unused)",
 	"Protection Keys User registers",
 	"PASID state",
-	"unknown xstate feature"	,
-	"unknown xstate feature"	,
-	"unknown xstate feature"	,
-	"unknown xstate feature"	,
-	"unknown xstate feature"	,
-	"unknown xstate feature"	,
-	"AMX Tile config"		,
-	"AMX Tile data"			,
-	"unknown xstate feature"	,
+	"Control-flow User registers",
+	"Control-flow Kernel registers (unused)",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"unknown xstate feature",
+	"AMX Tile config",
+	"AMX Tile data",
+	"unknown xstate feature",
 };
 
 static unsigned short xsave_cpuid_features[] __initdata = {
@@ -73,6 +73,7 @@ static unsigned short xsave_cpuid_features[] __initdata = {
 	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	= X86_FEATURE_INTEL_PT,
 	[XFEATURE_PKRU]				= X86_FEATURE_PKU,
 	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
+	[XFEATURE_CET_USER]			= X86_FEATURE_SHSTK,
 	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
 	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
 };
@@ -276,6 +277,7 @@ static void __init print_xstate_features(void)
 	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
 	print_xstate_feature(XFEATURE_MASK_PKRU);
 	print_xstate_feature(XFEATURE_MASK_PASID);
+	print_xstate_feature(XFEATURE_MASK_CET_USER);
 	print_xstate_feature(XFEATURE_MASK_XTILE_CFG);
 	print_xstate_feature(XFEATURE_MASK_XTILE_DATA);
 }
@@ -344,6 +346,7 @@ static __init void os_xrstor_booting(struct xregs_state *xstate)
 	 XFEATURE_MASK_BNDREGS |		\
 	 XFEATURE_MASK_BNDCSR |			\
 	 XFEATURE_MASK_PASID |			\
+	 XFEATURE_MASK_CET_USER |		\
 	 XFEATURE_MASK_XTILE)
 
 /*
@@ -446,14 +449,15 @@ static void __init __xstate_dump_leaves(void)
 	}									\
 } while (0)
 
-#define XCHECK_SZ(sz, nr, nr_macro, __struct) do {			\
-	if ((nr == nr_macro) &&						\
-	    WARN_ONCE(sz != sizeof(__struct),				\
-		"%s: struct is %zu bytes, cpu state %d bytes\n",	\
-		__stringify(nr_macro), sizeof(__struct), sz)) {		\
+#define XCHECK_SZ(sz, nr, __struct) ({					\
+	if (WARN_ONCE(sz != sizeof(__struct),				\
+	    "[%s]: struct is %zu bytes, cpu state %d bytes\n",		\
+	    xfeature_names[nr], sizeof(__struct), sz)) {		\
 		__xstate_dump_leaves();					\
 	}								\
-} while (0)
+	true;								\
+})
+
 
 /**
  * check_xtile_data_against_struct - Check tile data state size.
@@ -527,36 +531,28 @@ static bool __init check_xstate_against_struct(int nr)
 	 * Ask the CPU for the size of the state.
 	 */
 	int sz = xfeature_size(nr);
+
 	/*
 	 * Match each CPU state with the corresponding software
 	 * structure.
 	 */
-	XCHECK_SZ(sz, nr, XFEATURE_YMM,       struct ymmh_struct);
-	XCHECK_SZ(sz, nr, XFEATURE_BNDREGS,   struct mpx_bndreg_state);
-	XCHECK_SZ(sz, nr, XFEATURE_BNDCSR,    struct mpx_bndcsr_state);
-	XCHECK_SZ(sz, nr, XFEATURE_OPMASK,    struct avx_512_opmask_state);
-	XCHECK_SZ(sz, nr, XFEATURE_ZMM_Hi256, struct avx_512_zmm_uppers_state);
-	XCHECK_SZ(sz, nr, XFEATURE_Hi16_ZMM,  struct avx_512_hi16_state);
-	XCHECK_SZ(sz, nr, XFEATURE_PKRU,      struct pkru_state);
-	XCHECK_SZ(sz, nr, XFEATURE_PASID,     struct ia32_pasid_state);
-	XCHECK_SZ(sz, nr, XFEATURE_XTILE_CFG, struct xtile_cfg);
-
-	/* The tile data size varies between implementations. */
-	if (nr == XFEATURE_XTILE_DATA)
-		check_xtile_data_against_struct(sz);
-
-	/*
-	 * Make *SURE* to add any feature numbers in below if
-	 * there are "holes" in the xsave state component
-	 * numbers.
-	 */
-	if ((nr < XFEATURE_YMM) ||
-	    (nr >= XFEATURE_MAX) ||
-	    (nr == XFEATURE_PT_UNIMPLEMENTED_SO_FAR) ||
-	    ((nr >= XFEATURE_RSRVD_COMP_11) && (nr <= XFEATURE_RSRVD_COMP_16))) {
+	switch (nr) {
+	case XFEATURE_YMM:	  return XCHECK_SZ(sz, nr, struct ymmh_struct);
+	case XFEATURE_BNDREGS:	  return XCHECK_SZ(sz, nr, struct mpx_bndreg_state);
+	case XFEATURE_BNDCSR:	  return XCHECK_SZ(sz, nr, struct mpx_bndcsr_state);
+	case XFEATURE_OPMASK:	  return XCHECK_SZ(sz, nr, struct avx_512_opmask_state);
+	case XFEATURE_ZMM_Hi256:  return XCHECK_SZ(sz, nr, struct avx_512_zmm_uppers_state);
+	case XFEATURE_Hi16_ZMM:	  return XCHECK_SZ(sz, nr, struct avx_512_hi16_state);
+	case XFEATURE_PKRU:	  return XCHECK_SZ(sz, nr, struct pkru_state);
+	case XFEATURE_PASID:	  return XCHECK_SZ(sz, nr, struct ia32_pasid_state);
+	case XFEATURE_XTILE_CFG:  return XCHECK_SZ(sz, nr, struct xtile_cfg);
+	case XFEATURE_CET_USER:	  return XCHECK_SZ(sz, nr, struct cet_user_state);
+	case XFEATURE_XTILE_DATA: check_xtile_data_against_struct(sz); return true;
+	default:
 		XSTATE_WARN_ON(1, "No structure for xstate: %d\n", nr);
 		return false;
 	}
+
 	return true;
 }
 
-- 
2.17.1

