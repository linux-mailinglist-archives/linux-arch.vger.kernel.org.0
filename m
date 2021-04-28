Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4569936DEA9
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 19:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbhD1Rx1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243187AbhD1Rx0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Apr 2021 13:53:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DB2C061573;
        Wed, 28 Apr 2021 10:52:40 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c1700f2769e812f937597.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1700:f276:9e81:2f93:7597])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2BB431EC0242;
        Wed, 28 Apr 2021 19:52:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619632359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uNuSRpt+Nn8E1Ie1R3utO4unCBUpAQGFbeK/Hl3lbwA=;
        b=f66CoGete6UVNGpfGs/Fm2JVHxdlkjHe22uMROZcu8rr0x2vEvFY/1wCWVsC5/+qsG2d20
        OC+P3YZqbuPB/ykR8uGOFeBXsaI3T1EXVnAIl5+CHOile1nSbGtjmvFoWjfMD3TKeplfm3
        J6jPvXnOnMA5cMOUbp3RdC1kckLGAZU=
Date:   Wed, 28 Apr 2021 19:52:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v26 22/30] x86/cet/shstk: Add user-mode shadow stack
 support
Message-ID: <YImg5hmBnTZTkYIp@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-23-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427204315.24153-23-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 27, 2021 at 01:43:07PM -0700, Yu-cheng Yu wrote:
> @@ -535,6 +536,10 @@ struct thread_struct {
>  
>  	unsigned int		sig_on_uaccess_err:1;
>  
> +#ifdef CONFIG_X86_SHADOW_STACK
> +	struct cet_status	cet;

A couple of versions ago I said:

"	struct shstk_desc       shstk;

or so"

but no movement here. That thing is still called cet_status even though
there's nothing status-related with it.

So what's up?

> +static unsigned long alloc_shstk(unsigned long size)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long addr, populate;
> +	int flags = MAP_ANONYMOUS | MAP_PRIVATE;

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

Please fix it up everywhere.

> +	mmap_write_lock(mm);
> +	addr = do_mmap(NULL, 0, size, PROT_READ, flags, VM_SHADOW_STACK, 0,
> +		       &populate, NULL);
> +	mmap_write_unlock(mm);
> +
> +	return addr;
> +}
> +
> +int shstk_setup(void)
> +{
> +	unsigned long addr, size;
> +	struct cet_status *cet = &current->thread.cet;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return -EOPNOTSUPP;
> +
> +	size = round_up(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G), PAGE_SIZE);
> +	addr = alloc_shstk(size);
> +	if (IS_ERR_VALUE(addr))
> +		return PTR_ERR((void *)addr);
> +
> +	cet->shstk_base = addr;
> +	cet->shstk_size = size;
> +
> +	start_update_msrs();
> +	wrmsrl(MSR_IA32_PL3_SSP, addr + size);
> +	wrmsrl(MSR_IA32_U_CET, CET_SHSTK_EN);
> +	end_update_msrs();

<---- newline here.

> +	return 0;
> +}
> +
> +void shstk_free(struct task_struct *tsk)
> +{
> +	struct cet_status *cet = &tsk->thread.cet;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK) ||
> +	    !cet->shstk_size ||
> +	    !cet->shstk_base)
> +		return;
> +
> +	if (!tsk->mm)
> +		return;

Where are the comments you said you wanna add:

https://lkml.kernel.org/r/b05ee7eb-1b5d-f84f-c8f3-bfe9426e8a7d@intel.com

?

> +
> +	while (1) {
> +		int r;
> +
> +		r = vm_munmap(cet->shstk_base, cet->shstk_size);

		int r = vm_munmap...

> +
> +		/*
> +		 * vm_munmap() returns -EINTR when mmap_lock is held by
> +		 * something else, and that lock should not be held for a
> +		 * long time.  Retry it for the case.
> +		 */
> +		if (r == -EINTR) {
> +			cond_resched();
> +			continue;
> +		}
> +		break;
> +	}

vm_munmap() can return other negative error values, where are you
handling those?

> +
> +	cet->shstk_base = 0;
> +	cet->shstk_size = 0;
> +}
> +
> +void shstk_disable(void)
> +{
> +	struct cet_status *cet = &current->thread.cet;

Same question as before: what guarantees that current doesn't change
from under you here?

One of the worst thing to do is to ignore review comments. I'd strongly
suggest you pay more attention and avoid that in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
