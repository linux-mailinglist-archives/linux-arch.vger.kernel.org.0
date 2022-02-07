Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085F04ACD0D
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 02:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiBHBF1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 20:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245717AbiBGX2Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 18:28:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17393C0612A4;
        Mon,  7 Feb 2022 15:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644276504; x=1675812504;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=HOtSxOsxsg3P8RM3tbFgDc9I3beqaq6pdDO0U9LNiiQ=;
  b=lWU/SvhkCVjNdveIr1NuCqmwF/eSttiPX952/qx5g4JhipzxopX0JKO3
   90v4g9LL3kGkvVZo9jNiPzZkmHVar2OI0W8TwhfbhU50QxLwNB6wlaOnS
   7+9TO/rqVFBYkJxBDq1IneeA6XJ/eFVTPjn4DEc7CG+tVPQOZRv1746Bx
   W2GgAndlFCVSVr8eCMwzGsWcNapjpwDigkxM3vS6SNkBulUynW2Mj3NJw
   HDX4WPz79+sXYxlMB3Oygu/gfSJoOhmNw8gNs1J4hHIjP4zjC2wjVpP7E
   +k3dDnHy9eF1w69x9m+aycGGgpWuOG9nZnRs4Xqp4eSvACqvH4yQKCIvw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="247665155"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="247665155"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:28:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="525319051"
Received: from hgrunes-mobl1.amr.corp.intel.com (HELO [10.251.3.57]) ([10.251.3.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:28:22 -0800
Message-ID: <9ad0f7f7-e034-eb6d-eee4-1e977123efe7@intel.com>
Date:   Mon, 7 Feb 2022 15:28:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-6-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 05/35] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
In-Reply-To: <20220130211838.8382-6-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/22 13:18, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Control-flow Enforcement Technology (CET) introduces these MSRs:
> 
>     MSR_IA32_U_CET (user-mode CET settings),
>     MSR_IA32_PL3_SSP (user-mode shadow stack pointer),
> 
>     MSR_IA32_PL0_SSP (kernel-mode shadow stack pointer),
>     MSR_IA32_PL1_SSP (Privilege Level 1 shadow stack pointer),
>     MSR_IA32_PL2_SSP (Privilege Level 2 shadow stack pointer),
>     MSR_IA32_S_CET (kernel-mode CET settings),
>     MSR_IA32_INT_SSP_TAB (exception shadow stack table).

To be honest, I'm not sure this is very valuable.  It's *VERY* close to
the exact information in the structure definitions.  It's also not
obviously related to XSAVE.  It's more of the "what" this patch does
than the "why".  Good changelogs talk about "why".

> The two user-mode MSRs belong to XFEATURE_CET_USER.  The first three of
> kernel-mode MSRs belong to XFEATURE_CET_KERNEL.  Both XSAVES states are
> supervisor states.  This means that there is no direct, unprivileged access
> to these states, making it harder for an attacker to subvert CET.

Forgive me while I go into changelog lecture mode for a moment.

I was constantly looking up at the list of MSRs and trying to reconcile
them with this paragraph.  Imagine if you had started out this changelog
by saying:

	Shadow stack register state can be managed with XSAVE.  The
	registers can logically be separated into two groups:

		* Registers controlling user-mode operation
		* Registers controlling kernel-mode operation

	The architecture has two new XSAVE state components: one for
	each group of registers.  This _lets_ an OS manage them
	separately if it chooses.  Linux chooses to ... <explain the
	design choice here, or why we don't care yet>.

	Both XSAVE state components are supervisor states, even the
	state controlling user-mode operation.  This is a departure from
	earlier features like protection keys where the PKRU state is
	a normal user (non-supervisor) state.  Having the user state be	
	supervisor-managed ensures there is no direct, unprivileged
	access to it, making it harder for an attacker to subvert CET.

Also, IBT gunk is in here too, right?  Let's at least *mention* that in
the changelog.

...
>  /* All supervisor states including supported and unsupported states. */
>  #define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 3faf0f97edb1..0ee77ce4c753 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -362,6 +362,26 @@
>  
>  
>  #define MSR_CORE_PERF_LIMIT_REASONS	0x00000690
> +
> +/* Control-flow Enforcement Technology MSRs */
> +#define MSR_IA32_U_CET			0x000006a0 /* user mode cet setting */
> +#define MSR_IA32_S_CET			0x000006a2 /* kernel mode cet setting */
> +#define CET_SHSTK_EN			BIT_ULL(0)
> +#define CET_WRSS_EN			BIT_ULL(1)
> +#define CET_ENDBR_EN			BIT_ULL(2)
> +#define CET_LEG_IW_EN			BIT_ULL(3)
> +#define CET_NO_TRACK_EN			BIT_ULL(4)
> +#define CET_SUPPRESS_DISABLE		BIT_ULL(5)
> +#define CET_RESERVED			(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9))

Would GENMASK_ULL() look any nicer here?  I guess it's pretty clear
as-is that bits 6->9 are reserved.

> +#define CET_SUPPRESS			BIT_ULL(10)
> +#define CET_WAIT_ENDBR			BIT_ULL(11)

Are those bit fields common for both registers?  It might be worth a
comment to mention that.

> +#define MSR_IA32_PL0_SSP		0x000006a4 /* kernel shadow stack pointer */
> +#define MSR_IA32_PL1_SSP		0x000006a5 /* ring-1 shadow stack pointer */
> +#define MSR_IA32_PL2_SSP		0x000006a6 /* ring-2 shadow stack pointer */

Are PL1/2 ever used in this implementation?  If not, let's axe these
definitions.

> +#define MSR_IA32_PL3_SSP		0x000006a7 /* user shadow stack pointer */
> +#define MSR_IA32_INT_SSP_TAB		0x000006a8 /* exception shadow stack table */
> +
>  #define MSR_GFX_PERF_LIMIT_REASONS	0x000006B0
>  #define MSR_RING_PERF_LIMIT_REASONS	0x000006B1
>  
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 02b3ddaf4f75..44397202762b 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -50,6 +50,8 @@ static const char *xfeature_names[] =
>  	"Processor Trace (unused)"	,
>  	"Protection Keys User registers",
>  	"PASID state",
> +	"Control-flow User registers"	,
> +	"Control-flow Kernel registers"	,
>  	"unknown xstate feature"	,
>  	"unknown xstate feature"	,
>  	"unknown xstate feature"	,
> @@ -73,6 +75,8 @@ static unsigned short xsave_cpuid_features[] __initdata = {
>  	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	= X86_FEATURE_INTEL_PT,
>  	[XFEATURE_PKRU]				= X86_FEATURE_PKU,
>  	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
> +	[XFEATURE_CET_USER]			= X86_FEATURE_SHSTK,
> +	[XFEATURE_CET_KERNEL]			= X86_FEATURE_SHSTK,
>  	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
>  	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
>  };
> @@ -250,6 +254,8 @@ static void __init print_xstate_features(void)
>  	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
>  	print_xstate_feature(XFEATURE_MASK_PKRU);
>  	print_xstate_feature(XFEATURE_MASK_PASID);
> +	print_xstate_feature(XFEATURE_MASK_CET_USER);
> +	print_xstate_feature(XFEATURE_MASK_CET_KERNEL);
>  	print_xstate_feature(XFEATURE_MASK_XTILE_CFG);
>  	print_xstate_feature(XFEATURE_MASK_XTILE_DATA);
>  }
> @@ -405,6 +411,7 @@ static __init void os_xrstor_booting(struct xregs_state *xstate)
>  	 XFEATURE_MASK_BNDREGS |		\
>  	 XFEATURE_MASK_BNDCSR |			\
>  	 XFEATURE_MASK_PASID |			\
> +	 XFEATURE_MASK_CET_USER |		\
>  	 XFEATURE_MASK_XTILE)
>  
>  /*
> @@ -621,6 +628,8 @@ static bool __init check_xstate_against_struct(int nr)
>  	XCHECK_SZ(sz, nr, XFEATURE_PKRU,      struct pkru_state);
>  	XCHECK_SZ(sz, nr, XFEATURE_PASID,     struct ia32_pasid_state);
>  	XCHECK_SZ(sz, nr, XFEATURE_XTILE_CFG, struct xtile_cfg);
> +	XCHECK_SZ(sz, nr, XFEATURE_CET_USER,   struct cet_user_state);
> +	XCHECK_SZ(sz, nr, XFEATURE_CET_KERNEL, struct cet_kernel_state);
>  
>  	/* The tile data size varies between implementations. */
>  	if (nr == XFEATURE_XTILE_DATA)
> @@ -634,7 +643,9 @@ static bool __init check_xstate_against_struct(int nr)
>  	if ((nr < XFEATURE_YMM) ||
>  	    (nr >= XFEATURE_MAX) ||
>  	    (nr == XFEATURE_PT_UNIMPLEMENTED_SO_FAR) ||
> -	    ((nr >= XFEATURE_RSRVD_COMP_11) && (nr <= XFEATURE_RSRVD_COMP_16))) {
> +	    (nr == XFEATURE_RSRVD_COMP_13) ||
> +	    (nr == XFEATURE_RSRVD_COMP_14) ||
> +	    (nr == XFEATURE_RSRVD_COMP_16)) {
>  		WARN_ONCE(1, "no structure for xstate: %d\n", nr);
>  		XSTATE_WARN_ON(1);
>  		return false;

That if() is getting unweildy.  While I generally despise macros
implicitly modifying variables, this might be worth it.  We could have a
local function variable:

	bool feature_checked = false;

and then muck with it in the macro:

#define XCHECK_SZ(sz, nr, nr_macro, __struct) do {
	if (nr == nr_macro)) {
		feature_checked = true;
		if (WARN_ONCE(sz != sizeof(__struct), ... ) {
			__xstate_dump_leaves();
		}
        }
} while (0)

Then the if() just makes sure the feature was checked instead of
checking for reserved features explicitly.  We could also do:

	bool c = false;

	...

        c |= XCHECK_SZ(sz, nr, XFEATURE_YMM,       struct ymmh_struct);
        c |= XCHECK_SZ(sz, nr, XFEATURE_BNDREGS,   struct ...
        c |= XCHECK_SZ(sz, nr, XFEATURE_BNDCSR,    struct ...
	...

but that starts to run into 80 columns.  Those are both nice because
they mean you don't have to maintain a list of reserved features in the
code.  Another option would be to define a:

bool xfeature_is_reserved(int nr)
{
	switch (nr) {
		case XFEATURE_RSRVD_COMP_13:
		...

so the if() looks nicer and won't grow; the function will grow instead.

Either way, I think this needs some refactoring.
