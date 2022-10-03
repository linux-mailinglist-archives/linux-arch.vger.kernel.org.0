Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8EF5F3719
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 22:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJCU3L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 16:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJCU3J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 16:29:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4518D4A81B
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 13:29:06 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e129so10607290pgc.9
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sjiHVMgSJ5/4IaH3w5MgZlrFfbHSvGJ0QZv2CX5Q/Ws=;
        b=EcvIJqz3OKy+EfBwdQWABPnlwEoIn9TPS4LhPVQBLaYr92fAI04h6e0GN7Hvkhm3PT
         wSq+TKMvX4ENAjG/nSaud29ZGjfSaaHS6uMaHt3EhLLWZ5oSFWdSsGUVpfYlmUied/Ex
         0Ses9zSA3UbzwJ0ZpnEKSo+vR5Hq5Uf2WCakE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sjiHVMgSJ5/4IaH3w5MgZlrFfbHSvGJ0QZv2CX5Q/Ws=;
        b=cQhU9TUNMauLrict/rgKPTBqmFTXdQp6D3be7OcLyZ3N4rKw9EigXiSRGT4+flE3Ge
         3g6QjXuzOOFOfpWY0BKRfg1D+8Hw8n81xP3X9djg/i/16BYgkYVm4NTy3q8eMMNjzITp
         5veQypuoMzJuELgWz2EbfZlqzG9q44qZky8wes/KvXYEsT69nGPySVXWorksC/cM+B/u
         ZDNkCxj5FVQcnsESlML9XPwC0Qle7kSTVBa9n0GlBx3py9djIA9AdYBiTea+pcMUGgUg
         tRjzgxrq+yFEBSak+gDOAuSpdUTjqG3EOTJQryC/AwJlSrIFUeRWu6qkxTvCF9gNu4Dv
         T0eQ==
X-Gm-Message-State: ACrzQf1d35NxrXTwVHLtMuCq1SWK8hJGzwKQUVX76uPLVd3GfCqQrpef
        tGTQosg8X8mU4nLncstoGshRtg==
X-Google-Smtp-Source: AMsMyM4Gba8ZMDrS0NKETmREdN+X/ll6WDjF1VgZV8Lxe7Gg1+jFfe0zg0hHJQqHTr4zbWkyx69aNw==
X-Received: by 2002:a05:6a00:2402:b0:52c:81cf:8df2 with SMTP id z2-20020a056a00240200b0052c81cf8df2mr23916900pfh.40.1664828945594;
        Mon, 03 Oct 2022 13:29:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902a50c00b001785a72d285sm7661699plq.48.2022.10.03.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 13:29:04 -0700 (PDT)
Date:   Mon, 3 Oct 2022 13:29:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 25/39] x86/cet/shstk: Handle thread shadow stack
Message-ID: <202210031317.4611D6A1E7@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-26-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-26-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:22PM -0700, Rick Edgecombe wrote:
> [...]
> +#ifdef CONFIG_X86_SHADOW_STACK
> +static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
> +{
> +	struct cet_user_state *xstate;
> +
> +	/* If ssp update is not needed. */
> +	if (!ssp)
> +		return 0;

My brain will work to undo the collision of Shadow Stack Pointer with
Stack Smashing Protection. ;)

> [...]
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index a0b8d4adb2bf..db4e53f9fdaf 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -118,6 +118,46 @@ void reset_thread_shstk(void)
>  	current->thread.features_locked = 0;
>  }
>  
> +int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
> +			     unsigned long stack_size, unsigned long *shstk_addr)

Er, arg 3 is "stack_size". From later:

> +     ret = shstk_alloc_thread_stack(p, clone_flags, args->flags, &shstk_addr);
                                                       ^^^^^^^^^^^

clone_flags and args->flags are identical ... this must be accidentally
working. I was expecting 0 there.

> +{
> +	struct thread_shstk *shstk = &tsk->thread.shstk;
> +	unsigned long addr;
> +
> +	/*
> +	 * If shadow stack is not enabled on the new thread, skip any
> +	 * switch to a new shadow stack.
> +	 */
> +	if (!feature_enabled(CET_SHSTK))
> +		return 0;
> +
> +	/*
> +	 * clone() does not pass stack_size, which was added to clone3().
> +	 * Use RLIMIT_STACK and cap to 4 GB.
> +	 */
> +	if (!stack_size)
> +		stack_size = min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G);

Again, perhaps the clamp should happen in alloc_shstk()?

> +
> +	/*
> +	 * For CLONE_VM, except vfork, the child needs a separate shadow
> +	 * stack.
> +	 */
> +	if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
> +		return 0;
> +
> +
> +	stack_size = PAGE_ALIGN(stack_size);

Uhm, I think a line went missing here. :P

"x86/cet/shstk: Introduce map_shadow_stack syscall" adds the missing:

+	addr = alloc_shstk(0, stack_size, 0, false);

Please add back the original. :)

> +	if (IS_ERR_VALUE(addr))
> +		return PTR_ERR((void *)addr);
> +
> +	shstk->base = addr;
> +	shstk->size = stack_size;
> +
> +	*shstk_addr = addr + stack_size;
> +
> +	return 0;
> +}
> +
>  void shstk_free(struct task_struct *tsk)
>  {
>  	struct thread_shstk *shstk = &tsk->thread.shstk;
> @@ -126,7 +166,13 @@ void shstk_free(struct task_struct *tsk)
>  	    !feature_enabled(CET_SHSTK))
>  		return;
>  
> -	if (!tsk->mm)
> +	/*
> +	 * When fork() with CLONE_VM fails, the child (tsk) already has a
> +	 * shadow stack allocated, and exit_thread() calls this function to
> +	 * free it.  In this case the parent (current) and the child share
> +	 * the same mm struct.
> +	 */
> +	if (!tsk->mm || tsk->mm != current->mm)
>  		return;
>  
>  	unmap_shadow_stack(shstk->base, shstk->size);
> -- 
> 2.17.1
> 

-- 
Kees Cook
