Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3409E4B31F9
	for <lists+linux-arch@lfdr.de>; Sat, 12 Feb 2022 01:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354398AbiBLA1u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 19:27:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354397AbiBLA1t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 19:27:49 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C38B129;
        Fri, 11 Feb 2022 16:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644625667; x=1676161667;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=JnVsh9XoDVOYZL62w9WLXV6Np+XHCqYefzRHWFleKnU=;
  b=eD/64GCuCSCkXQAd8kpnfZ3XEbg0Ef2EC/QMJQJXGc58ChPJZ24WkKF9
   TN15GgZzrXz59eepUCFVeDAJRs91MAwiwnR/hAgCrg9uiUb2+hZXWVa8T
   NIqXRhk3Eyr3q0taqDltOHUbMD+m506x5GrwWGsCvXh2AaffnZ738HhD9
   L8mL1LbnMORc+pf7kIwx9+wm+GlDrimAgWnwS5f1jqkWcvYSOR5LDBYSU
   Lz106MP0vlMWfqZ1HrZC9A5UJmC9t4CbLUNMn4PTbV8HizGiOTa7A2iTt
   Mx9IQJdGhTbT9kzKIqRXU5UMy8+P9G5/IuU6hlnn5/MHcuxGjr2AsNoWt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="313116259"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="313116259"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 16:27:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="542298930"
Received: from nsmdimra-mobl.amr.corp.intel.com (HELO [10.209.96.127]) ([10.209.96.127])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 16:27:40 -0800
Message-ID: <d22f9dfc-cb7b-94f6-8585-bb39ed04536b@intel.com>
Date:   Fri, 11 Feb 2022 16:27:37 -0800
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
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-24-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 23/35] x86/fpu: Add helpers for modifying supervisor
 xstate
In-Reply-To: <20220130211838.8382-24-rick.p.edgecombe@intel.com>
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
> Add helpers that can be used to modify supervisor xstate safely for the
> current task.

This should be at the end of the changelog.

> State for supervisors xstate based features can be live and
> accesses via MSR's, or saved in memory in an xsave buffer. When the
> kernel needs to modify this state it needs to be sure to operate on it
> in the right place, so the modifications don't get clobbered.

We tend to call these "supervisor xfeatures".  The "state is in the
registers" we call "active".  Maybe:

	Just like user xfeatures, supervisor xfeatures can be either
	active in the registers or inactive and present in the task FPU
	buffer.  If the registers are active, the registers can be
	modified directly.  If the registers are not active, the
	modification must be performed on the task FPU buffer.


> In the past supervisor xstate features have used get_xsave_addr()
> directly, and performed open coded logic handle operating on the saved
> state correctly. This has posed two problems:
>  1. It has logic that has been gotten wrong more than once.
>  2. To reduce code, less common path's are not optimized. Determination

			   "paths" ^


> xstate = start_update_xsave_msrs(XFEATURE_FOO);
> r = xsave_rdmsrl(state, MSR_IA32_FOO_1, &val)
> if (r)
> 	xsave_wrmsrl(state, MSR_IA32_FOO_2, FOO_ENABLE);
> end_update_xsave_msrs();

This looks OK.  I'm not thrilled about it.  The
start_update_xsave_msrs() can probably drop the "_msrs".  Maybe:

	start_xfeature_update(...);

Also, if you have to do the address lookup in xsave_rdmsrl() anyway, I
wonder if the 'xstate' should just be a full fledged 'struct xregs_state'.

The other option would be to make a little on-stack structure like:

	struct xsave_update {
		int feature;
		struct xregs_state *xregs;
	};

Then you do:

	struct xsave_update xsu;
	...
	start_update_xsave_msrs(&xsu, XFEATURE_FOO);

and then pass it along to each of the other operations:

	r = xsave_rdmsrl(xsu, MSR_IA32_FOO_1, &val)

It's slightly less likely to get type confused as a 'void *';

> +static u64 *__get_xsave_member(void *xstate, u32 msr)
> +{
> +	switch (msr) {
> +	/* Currently there are no MSR's supported */
> +	default:
> +		WARN_ONCE(1, "x86/fpu: unsupported xstate msr (%u)\n", msr);
> +		return NULL;
> +	}
> +}

Just to get an idea what this is doing, it's OK to include the shadow
stack MSRs in here.

Are you sure this should return a u64*?  We have lots of <=64-bit XSAVE
fields.

> +/*
> + * Return a pointer to the xstate for the feature if it should be used, or NULL
> + * if the MSRs should be written to directly. To do this safely, using the
> + * associated read/write helpers is required.
> + */
> +void *start_update_xsave_msrs(int xfeature_nr)
> +{
> +	void *xstate;
> +
> +	/*
> +	 * fpregs_lock() only disables preemption (mostly). So modifing state

							 modifying ^
	
> +	 * in an interrupt could screw up some in progress fpregs operation,

						^ in-progress

> +	 * but appear to work. Warn about it.
> +	 */
> +	WARN_ON_ONCE(!in_task());
> +	WARN_ON_ONCE(current->flags & PF_KTHREAD);

This might also be a good spot to check that xfeature_nr is in
fpstate.xfeatures.

> +	fpregs_lock();
> +
> +	fpregs_assert_state_consistent();
> +
> +	/*
> +	 * If the registers don't need to be reloaded. Go ahead and operate on the
> +	 * registers.
> +	 */
> +	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
> +		return NULL;
> +
> +	xstate = get_xsave_addr(&current->thread.fpu.fpstate->regs.xsave, xfeature_nr);
> +
> +	/*
> +	 * If regs are in the init state, they can't be retrieved from
> +	 * init_fpstate due to the init optimization, but are not nessarily

							necessarily ^

Spell checker time.  ":set spell" in vim works for me nicely.

> +	 * zero. The only option is to restore to make everything live and
> +	 * operate on registers. This will clear TIF_NEED_FPU_LOAD.
> +	 *
> +	 * Otherwise, if not in the init state but TIF_NEED_FPU_LOAD is set,
> +	 * operate on the buffer. The registers will be restored before going
> +	 * to userspace in any case, but the task might get preempted before
> +	 * then, so this possibly saves an xsave.
> +	 */
> +	if (!xstate)
> +		fpregs_restore_userregs();

Won't fpregs_restore_userregs() end up setting TIF_NEED_FPU_LOAD=0?
Isn't that a case where a "return NULL" is needed?

In any case, this makes me think this code should start out stupid and
slow.  Keep the API as-is, but make the first patch unconditionally do
the WRMSR.  Leave the "fast" buffer modifications for a follow-on patch.
