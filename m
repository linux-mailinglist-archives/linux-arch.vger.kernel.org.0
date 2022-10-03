Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9825F3759
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 22:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJCUwj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 16:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJCUwg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 16:52:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EFF47B90
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 13:52:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h10so7998321plb.2
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8ffUlHkSjB1PAHGl9/RU9+eAvU4W3MS9YfacwqGrUYs=;
        b=R8SPL4pbrpY73g71S77B4NcBTS41NGBC4RYk2iZ49PCLH1gtakir+cCS5l0lIgw9iv
         Xxoo8zueXn6IyedMrA0nwnXjtNWYE1TlfblH23f/SyGZTcNI8eTt7gfTQDmO/w6xx7hv
         XaO0n42ruxYNS9W2k5Y7IaK+KigjLUiZdFSa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8ffUlHkSjB1PAHGl9/RU9+eAvU4W3MS9YfacwqGrUYs=;
        b=Fn9e3LMdNm4bd4M/h3makke3c0LHsjKnr4JoKFZudQ4s4w8HRvFIocc3UTrgLKnR+h
         LouegrWwArRNjxr+qyGkzN7WHHcvov6u8fbPCl8kpAUkDAS5GgN6PZCfUSemXYOq5WLT
         ADkxHLqzm0DSyMgT8iTKhB972Co5CZBn+uyi++Dkg5BpY9lBf8kBoB/9xi5W9WoxKjK/
         ZdTRwFOJFNA4X5bpClmxvbj8LYoX8Lc1UWJ9+kukL83R7BJR3nJ6HrgcAQBfhA+6igMU
         AU2TZN/joluiEqb73Mgf/3Eexe/Ztfo1led0JMXaMvUlGkCga6YbtjqV15Z22aQeSWhx
         AqpA==
X-Gm-Message-State: ACrzQf2rGpYgDO5sedcQQiWdhpeeAGnZBSIc787RMBsQNgYNHEm4tLgQ
        dbk29Byj2jemiAzTHsWryz/FIQ==
X-Google-Smtp-Source: AMsMyM5ap3cu1yiQByhDqspB/OFSaaducCy6qGDxDqArY/L8+b0bcwim0v3UCdiAZIBDDd6WZTlMiA==
X-Received: by 2002:a17:902:da8a:b0:17b:df43:9235 with SMTP id j10-20020a170902da8a00b0017bdf439235mr20146511plx.137.1664830353447;
        Mon, 03 Oct 2022 13:52:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p28-20020a634f5c000000b0044db4f3f7ecsm2979268pgl.20.2022.10.03.13.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 13:52:32 -0700 (PDT)
Date:   Mon, 3 Oct 2022 13:52:31 -0700
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
Subject: Re: [PATCH v2 27/39] x86/cet/shstk: Handle signals for shadow stack
Message-ID: <202210031347.6DBE61199@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-28-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-28-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:24PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> When a signal is handled normally the context is pushed to the stack
> before handling it. For shadow stacks, since the shadow stack only track's
> return addresses, there isn't any state that needs to be pushed. However,
> there are still a few things that need to be done. These things are
> userspace visible and which will be kernel ABI for shadow stacks.
> 
> One is to make sure the restorer address is written to shadow stack, since
> the signal handler (if not changing ucontext) returns to the restorer, and
> the restorer calls sigreturn. So add the restorer on the shadow stack
> before handling the signal, so there is not a conflict when the signal
> handler returns to the restorer.
> 
> The other thing to do is to place some type of checkable token on the
> thread's shadow stack before handling the signal and check it during
> sigreturn. This is an extra layer of protection to hamper attackers
> calling sigreturn manually as in SROP-like attacks.
> 
> For this token we can use the shadow stack data format defined earlier.
> Have the data pushed be the previous SSP. In the future the sigreturn
> might want to return back to a different stack. Storing the SSP (instead
> of a restore offset or something) allows for future functionality that
> may want to restore to a different stack.
> 
> So, when handling a signal push
>  - the SSP pointing in the shadow stack data format
>  - the restorer address below the restore token.
> 
> In sigreturn, verify SSP is stored in the data format and pop the shadow
> stack.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Cyrill Gorcunov <gorcunov@gmail.com>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> ---
> 
> v2:
>  - Switch to new shstk signal format
> 
> v1:
>  - Use xsave helpers.
>  - Expand commit log.
> 
> Yu-cheng v27:
>  - Eliminate saving shadow stack pointer to signal context.
> 
> Yu-cheng v25:
>  - Update commit log/comments for the sc_ext struct.
>  - Use restorer address already calculated.
>  - Change CONFIG_X86_CET to CONFIG_X86_SHADOW_STACK.
>  - Change X86_FEATURE_CET to X86_FEATURE_SHSTK.
>  - Eliminate writing to MSR_IA32_U_CET for shadow stack.
>  - Change wrmsrl() to wrmsrl_safe() and handle error.
> 
>  arch/x86/ia32/ia32_signal.c |   1 +
>  arch/x86/include/asm/cet.h  |   5 ++
>  arch/x86/kernel/shstk.c     | 126 ++++++++++++++++++++++++++++++------
>  arch/x86/kernel/signal.c    |  10 +++
>  4 files changed, 123 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> index c9c3859322fa..88d71b9de616 100644
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -34,6 +34,7 @@
>  #include <asm/sigframe.h>
>  #include <asm/sighandling.h>
>  #include <asm/smap.h>
> +#include <asm/cet.h>
>  
>  static inline void reload_segments(struct sigcontext_32 *sc)
>  {
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> index 924de99e0c61..8c6fab9f402a 100644
> --- a/arch/x86/include/asm/cet.h
> +++ b/arch/x86/include/asm/cet.h
> @@ -6,6 +6,7 @@
>  #include <linux/types.h>
>  
>  struct task_struct;
> +struct ksignal;
>  
>  struct thread_shstk {
>  	u64	base;
> @@ -22,6 +23,8 @@ int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
>  void shstk_free(struct task_struct *p);
>  int shstk_disable(void);
>  void reset_thread_shstk(void);
> +int setup_signal_shadow_stack(struct ksignal *ksig);
> +int restore_signal_shadow_stack(void);
>  #else
>  static inline long cet_prctl(struct task_struct *task, int option,
>  		      unsigned long features) { return -EINVAL; }
> @@ -33,6 +36,8 @@ static inline int shstk_alloc_thread_stack(struct task_struct *p,
>  static inline void shstk_free(struct task_struct *p) {}
>  static inline int shstk_disable(void) { return -EOPNOTSUPP; }
>  static inline void reset_thread_shstk(void) {}
> +static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
> +static inline int restore_signal_shadow_stack(void) { return 0; }
>  #endif /* CONFIG_X86_SHADOW_STACK */
>  
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 8904aef487bf..04442134aadd 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -227,41 +227,129 @@ static int get_shstk_data(unsigned long *data, unsigned long __user *addr)
>  }
>  
>  /*
> - * Verify the user shadow stack has a valid token on it, and then set
> - * *new_ssp according to the token.
> + * Create a restore token on shadow stack, and then push the user-mode
> + * function return address.
>   */
> -static int shstk_check_rstor_token(unsigned long *new_ssp)
> +static int shstk_setup_rstor_token(unsigned long ret_addr, unsigned long *new_ssp)

Oh, hrm. Prior patch defines shstk_check_rstor_token() and
doesn't call it. This patch removes it. :P Can you please remove
shstk_check_rstor_token() from the prior patch?

>  {
> -	unsigned long token_addr;
> -	unsigned long token;
> +	unsigned long ssp, token_addr;
> +	int err;
> +
> +	if (!ret_addr)
> +		return -EINVAL;
> +
> +	ssp = get_user_shstk_addr();
> +	if (!ssp)
> +		return -EINVAL;
> +
> +	err = create_rstor_token(ssp, &token_addr);
> +	if (err)
> +		return err;
> +
> +	ssp = token_addr - sizeof(u64);
> +	err = write_user_shstk_64((u64 __user *)ssp, (u64)ret_addr);
> +
> +	if (!err)
> +		*new_ssp = ssp;
> +
> +	return err;
> +}
> +
> +static int shstk_push_sigframe(unsigned long *ssp)
> +{
> +	unsigned long target_ssp = *ssp;
> +
> +	/* Token must be aligned */
> +	if (!IS_ALIGNED(*ssp, 8))
> +		return -EINVAL;
>  
> -	token_addr = get_user_shstk_addr();
> -	if (!token_addr)
> +	if (!IS_ALIGNED(target_ssp, 8))
>  		return -EINVAL;
>  
> -	if (get_user(token, (unsigned long __user *)token_addr))
> +	*ssp -= SS_FRAME_SIZE;
> +	if (put_shstk_data((void *__user)*ssp, target_ssp))
>  		return -EFAULT;
>  
> -	/* Is mode flag correct? */
> -	if (!(token & BIT(0)))
> +	return 0;
> +}
> +
> +
> +static int shstk_pop_sigframe(unsigned long *ssp)
> +{
> +	unsigned long token_addr;
> +	int err;
> +
> +	err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
> +	if (unlikely(err))
> +		return err;
> +
> +	/* Restore SSP aligned? */
> +	if (unlikely(!IS_ALIGNED(token_addr, 8)))
>  		return -EINVAL;

Why doesn't this always fail, given BIT(0) being set? I don't see it
getting cleared until the end of this function.

>  
> -	/* Is busy flag set? */
> -	if (token & BIT(1))
> +	/* SSP in userspace? */
> +	if (unlikely(token_addr >= TASK_SIZE_MAX))
>  		return -EINVAL;

BIT(63) already got cleared by here (in get_shstk_data(), but yes,
this is still a reasonable check.

>  
> -	/* Mask out flags */
> -	token &= ~3UL;
> +	*ssp = token_addr;
> +
> +	return 0;
> +}

-- 
Kees Cook
