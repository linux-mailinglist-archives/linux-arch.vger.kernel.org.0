Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46E45F2EDA
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 12:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJCKhV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 06:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiJCKhU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 06:37:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832961DA74;
        Mon,  3 Oct 2022 03:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C8B6B8104F;
        Mon,  3 Oct 2022 10:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF1CC43143;
        Mon,  3 Oct 2022 10:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664793437;
        bh=dewb3mLvV1IqnE1lyvfrRRv9KWdb78cCHePpaZtvzkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLCaZVgNesImD+AGu4Ie8hAJLKSh3Ni0jx3C7mzBtfrrhvy7XGdKdzHI+Yhrw7akR
         PWxY3VZXKtcqsGRRF2ys90uMFRScEpBTHVDyH1oCWnFtHsH2cJgoN86LAn9m9Vayww
         ZqwwPs6HcnZ4gMNZt+2P5wHNEJQpoj384eBb1+Jvp1t3B7aG61OX4XjVZ7SnxTnDoz
         o0VKf7RfwW4qgLJrNCUozzl0H12cdGIWGZ7ELUGw+EMUE7MPsobks4n1fLOs6cMhTL
         8rlDVMRztINBS4Y9XxLQBlZy8NKBI4zkWnhHGXcA5dkJeucmyk46Qfj4Ms60BT1MQ8
         PBd9o8TvOlmAg==
Date:   Mon, 3 Oct 2022 13:36:54 +0300
From:   Mike Rapoport <rppt@kernel.org>
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
        kcc@google.com, eranian@google.com, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 25/39] x86/cet/shstk: Handle thread shadow stack
Message-ID: <Yzq7RjsnM8ix+enT@kernel.org>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-26-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-26-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:22PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> When a process is duplicated, but the child shares the address space with
> the parent, there is potential for the threads sharing a single stack to
> cause conflicts for each other. In the normal non-cet case this is handled
> in two ways.
> 
> With regular CLONE_VM a new stack is provided by userspace such that the
> parent and child have different stacks.
> 
> For vfork, the parent is suspended until the child exits. So as long as
> the child doesn't return from the vfork()/CLONE_VFORK calling function and
> sticks to a limited set of operations, the parent and child can share the
> same stack.
> 
> For shadow stack, these scenarios present similar sharing problems. For the
> CLONE_VM case, the child and the parent must have separate shadow stacks.
> Instead of changing clone to take a shadow stack, have the kernel just
> allocate one and switch to it.
> 
> Use stack_size passed from clone3() syscall for thread shadow stack size. A
> compat-mode thread shadow stack size is further reduced to 1/4. This
> allows more threads to run in a 32-bit address space. The clone() does not
> pass stack_size, which was added to clone3(). In that case, use
> RLIMIT_STACK size and cap to 4 GB.
> 
> For shadow stack enabled vfork(), the parent and child can share the same
> shadow stack, like they can share a normal stack. Since the parent is
> suspended until the child terminates, the child will not interfere with
> the parent while executing as long as it doesn't return from the vfork()
> and overwrite up the shadow stack. The child can safely overwrite down
> the shadow stack, as the parent can just overwrite this later. So CET does
> not add any additional limitations for vfork().
> 
> Userspace implementing posix vfork() can actually prevent the child from
> returning from the vfork() calling function, using CET. Glibc does this
> by adjusting the shadow stack pointer in the child, so that the child
> receives a #CP if it tries to return from vfork() calling function.
> 
> Free the shadow stack on thread exit by doing it in mm_release(). Skip
> this when exiting a vfork() child since the stack is shared in the
> parent.
> 
> During this operation, the shadow stack pointer of the new thread needs
> to be updated to point to the newly allocated shadow stack. Since the
> ability to do this is confined to the FPU subsystem, change
> fpu_clone() to take the new shadow stack pointer, and update it
> internally inside the FPU subsystem. This part was suggested by Thomas
> Gleixner.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> 
> v2:
>  - Have fpu_clone() take new shadow stack pointer and update SSP in
>    xsave buffer for new task. (tglx)
> 
> v1:
>  - Expand commit log.
>  - Add more comments.
>  - Switch to xsave helpers.
> 
> Yu-cheng v30:
>  - Update comments about clone()/clone3(). (Borislav Petkov)
> 
> Yu-cheng v29:
>  - WARN_ON_ONCE() when get_xsave_addr() returns NULL, and update comments.
>    (Dave Hansen)
> 
>  arch/x86/include/asm/cet.h         |  7 +++++
>  arch/x86/include/asm/fpu/sched.h   |  3 +-
>  arch/x86/include/asm/mmu_context.h |  2 ++
>  arch/x86/kernel/fpu/core.c         | 40 ++++++++++++++++++++++++-
>  arch/x86/kernel/process.c          | 17 ++++++++++-
>  arch/x86/kernel/shstk.c            | 48 +++++++++++++++++++++++++++++-
>  6 files changed, 113 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 778d3054ccc7..f332e9b42b6d 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -555,8 +555,40 @@ static inline void fpu_inherit_perms(struct fpu *dst_fpu)
>  	}
>  }
>  
> +#ifdef CONFIG_X86_SHADOW_STACK
> +static int update_fpu_shstk(struct task_struct *dst, unsigned long ssp)
> +{
> +	struct cet_user_state *xstate;
> +
> +	/* If ssp update is not needed. */
> +	if (!ssp)
> +		return 0;
> +
> +	xstate = get_xsave_addr(&dst->thread.fpu.fpstate->regs.xsave,
> +				XFEATURE_CET_USER);
> +
> +	/*
> +	 * If there is a non-zero ssp, then 'dst' must be configured with a shadow
> +	 * stack and the fpu state should be up to date since it was just copied
> +	 * from the parent in fpu_clone(). So there must be a valid non-init CET
> +	 * state location in the buffer.
> +	 */
> +	if (WARN_ON_ONCE(!xstate))
> +		return 1;
> +
> +	xstate->user_ssp = (u64)ssp;
> +
> +	return 0;
> +}
> +#else
> +static int update_fpu_shstk(struct task_struct *dst, unsigned long shstk_addr)
> +{

return 0; ?

> +}
> +#endif
> +

-- 
Sincerely yours,
Mike.
