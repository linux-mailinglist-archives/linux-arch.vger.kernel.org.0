Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED968379072
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbhEJOSt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 10:18:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59686 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232009AbhEJORD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 May 2021 10:17:03 -0400
Received: from zn.tnic (p200300ec2f066d00159cc50318b4d41b.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:6d00:159c:c503:18b4:d41b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CCFD1EC0350;
        Mon, 10 May 2021 16:15:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620656146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=o2aoaH2RymU6wxi8X7V+6fjKICNEkCYu8vfZLJTg/WM=;
        b=r4xTua/evyV7MIbUF+KfrYv8m7oot0Y5Z+nHZRk9uPtU1XfbM2yO8UnOjpCQOMi8FzBIwA
        PUewBV0RTv/uqtgZbIlCXnskJ1wspzZu6DiFOn9gKpKLxni5yqrf3Pk2xKgia/oY21j8pf
        PjDV2UJsf4y20ufm418bw+P+7VMh8O4=
Date:   Mon, 10 May 2021 16:15:43 +0200
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
Subject: Re: [PATCH v26 23/30] x86/cet/shstk: Handle thread shadow stack
Message-ID: <YJlADyc/9pn8Sjkn@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-24-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427204315.24153-24-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 27, 2021 at 01:43:08PM -0700, Yu-cheng Yu wrote:
> @@ -181,6 +184,12 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>  	if (clone_flags & CLONE_SETTLS)
>  		ret = set_new_tls(p, tls);
>  
> +#ifdef CONFIG_X86_64

IS_ENABLED

> +	/* Allocate a new shadow stack for pthread */
> +	if (!ret)
> +		ret = shstk_setup_thread(p, clone_flags, stack_size);
> +#endif
> +

And why is this addition here...

>  	if (!ret && unlikely(test_tsk_thread_flag(current, TIF_IO_BITMAP)))
>  		io_bitmap_share(p);

... instead of here?

<---

>  
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index c815c7507830..d387df84b7f1 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -70,6 +70,55 @@ int shstk_setup(void)
>  	return 0;
>  }

> +int shstk_setup_thread(struct task_struct *tsk, unsigned long clone_flags,

Judging by what this function does, its name wants to be

shstk_alloc_thread_stack()

or so?

> +		       unsigned long stack_size)
> +{
> +	unsigned long addr, size;
> +	struct cet_user_state *state;
> +	struct cet_status *cet = &tsk->thread.cet;

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

> +
> +	if (!cet->shstk_size)
> +		return 0;
> +

This check needs a comment.

> +	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
> +		return 0;
> +
> +	state = get_xsave_addr(&tsk->thread.fpu.state.xsave,
> +			       XFEATURE_CET_USER);

Let that line stick out.

> +
> +	if (!state)
> +		return -EINVAL;
> +
> +	if (stack_size == 0)

	if (!stack_size)

> +		return -EINVAL;

and that test needs to be done first in the function.

> +
> +	/* Cap shadow stack size to 4 GB */

Why?

> +	size = min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G);
> +	size = min(size, stack_size);
> +
> +	/*
> +	 * Compat-mode pthreads share a limited address space.
> +	 * If each function call takes an average of four slots
> +	 * stack space, allocate 1/4 of stack size for shadow stack.
> +	 */
> +	if (in_compat_syscall())
> +		size /= 4;

<---- newline here.

> +	size = round_up(size, PAGE_SIZE);
> +	addr = alloc_shstk(size);
> +

^ Superfluous newline.

> +	if (IS_ERR_VALUE(addr)) {
> +		cet->shstk_base = 0;
> +		cet->shstk_size = 0;
> +		return PTR_ERR((void *)addr);
> +	}
> +
> +	fpu__prepare_write(&tsk->thread.fpu);
> +	state->user_ssp = (u64)(addr + size);

cet_user_state has u64, cet_status has unsigned longs. Make them all u64.

And since cet_status is per thread, but I had suggested struct
shstk_desc, I think now that that should be called

struct thread_shstk

or so to denote *exactly* what it is.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
