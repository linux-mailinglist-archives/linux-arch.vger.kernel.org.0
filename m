Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BDC4B668C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 09:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiBOIte (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 03:49:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiBOItd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 03:49:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11271133FC;
        Tue, 15 Feb 2022 00:49:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D4C03CE1CB0;
        Tue, 15 Feb 2022 08:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D579CC340EC;
        Tue, 15 Feb 2022 08:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644914960;
        bh=f/WBf8BXhnl6oLHWFWEGJp8LEjoHMw+hzylbSfqI8vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uYiPL1F28I8AaSHXIr4Gnz7p5C7M0Qwpqs2segEiChEb802kz72kgncshaveItrxm
         xdl0TqBo8F8e5Q9QvbxmI/hTu0PCqIWdGA7NQE2lSmHPjYnmhmMzCRQ41IeEiQsEfC
         ZpATU9n5DAqd208xH8Xrx88lTnXzSS43iCgOF5DAi/PPjx2hXj5nfNlt85sdAZwI4B
         FOCrUf2jIESnvuMedwlX3dM7PZUxTAF26EJTDrLK/gOhAMx3NF8L9fRyoKPKBKrqVq
         F9Wn+3lKaTFXwQ2EBMnx1kzAUZFjeosVDVgnVsUAmod2F0GJXDikCbg5mrR/okaoyR
         6xmSufqooLSLw==
Date:   Tue, 15 Feb 2022 09:49:10 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "jannh@google.com" <jannh@google.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH 26/35] x86/process: Change copy_thread() argument 'arg'
 to 'stack_size'
Message-ID: <20220215084910.ldsbhyizssvxvpz6@wittgenstein>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-27-rick.p.edgecombe@intel.com>
 <CAG48ez0_Ng8Fv4ytLK=Y5ANXiDfBPsFFwfxQTzgmDjU1RNFnDw@mail.gmail.com>
 <959707bff94b3a54f05cfcfc09fa809f08152807.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <959707bff94b3a54f05cfcfc09fa809f08152807.camel@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 15, 2022 at 01:22:04AM +0000, Edgecombe, Rick P wrote:
> On Mon, 2022-02-14 at 13:33 +0100, Jann Horn wrote:
> > On Sun, Jan 30, 2022 at 10:22 PM Rick Edgecombe
> > <rick.p.edgecombe@intel.com> wrote:
> > > 
> > > From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > > 
> > > The single call site of copy_thread() passes stack size in
> > > 'arg'.  To make
> > > this clear and in preparation of using this argument for shadow
> > > stack
> > > allocation, change 'arg' to 'stack_size'.  No functional changes.
> > 
> > Actually that name is misleading - the single caller copy_process()
> > indeed does:
> > 
> > retval = copy_thread(clone_flags, args->stack, args->stack_size, p,
> > args->tls);
> > 
> > but the member "stack_size" of "struct kernel_clone_args" can
> > actually
> > also be a pointer argument given to a kthread, see create_io_thread()
> > and kernel_thread():
> > 
> > pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long
> > flags)
> > {
> >   struct kernel_clone_args args = {
> >     .flags    = ((lower_32_bits(flags) | CLONE_VM |
> >             CLONE_UNTRACED) & ~CSIGNAL),
> >     .exit_signal  = (lower_32_bits(flags) & CSIGNAL),
> >     .stack    = (unsigned long)fn,
> >     .stack_size  = (unsigned long)arg,
> >   };
> > 
> >   return kernel_clone(&args);
> > }
> > 
> > And then in copy_thread(), we have:
> > 
> > kthread_frame_init(frame, sp, arg)
> > 
> > 
> > So I'm not sure whether this name change really makes sense, or
> > whether it just adds to the confusion.
> 
> Thanks Jann. Yea I guess this makes it worse.
> 
> Reading a bit of the history, it seems there used to be unwieldy
> argument lists which were replaced by a big "struct kernel_clone_args"
> to be passed around. The re-use of the stack_size argument is from
> before there was the struct. And then the struct just inherited the
> confusion when it was introduced.
> 
> So if a separate *data member was added to kernel_clone_args for
> kernel_thread() and create_io_thread() to use, they wouldn't need to
> re-use stack_size. And copy_thread() could just take a struct
> kernel_clone_args pointer. It might make it more clear.

I'm honestly not sure it makes things that much better but I don't feel
strongly about it either.

> 
> But copy_thread() has a ton of arch specific implementations. So they
> would all need to be updated to do this.

When struct kernel_clone_args was introduced I also removed the
copy_thread_tls() and copy_thread() split. So now we're only left with
copy_thread(). That already allowed us to get rid of some arch-specific
code. I didn't go further in trying to unify more arch-specific code. It
might be worth it but I didn't come to a clear conclusion.

> 
> Just playing around with it, I did this which only makes the change on
> x86. Duplicating it for 21 copy_thread()s seems perfectly doable, but
> I'm not sure how much people care vs renaming arg to
> stacksize_or_data...


> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 11bf09b60f9d..cfbba5b14609 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -132,9 +132,8 @@ static int set_new_tls(struct task_struct *p,
> unsigned long tls)
>                 return do_set_thread_area_64(p, ARCH_SET_FS, tls);
>  }
>  
> -int copy_thread(unsigned long clone_flags, unsigned long sp,
> -               unsigned long stack_size, struct task_struct *p,
> -               unsigned long tls)
> +int copy_thread(unsigned long clone_flags, struct kernel_clone_args
> *args,
> +               struct task_struct *p)
>  {
>         struct inactive_task_frame *frame;
>         struct fork_frame *fork_frame;
> @@ -178,7 +177,7 @@ int copy_thread(unsigned long clone_flags, unsigned
> long sp,
>         if (unlikely(p->flags & PF_KTHREAD)) {
>                 p->thread.pkru = pkru_get_init_value();
>                 memset(childregs, 0, sizeof(struct pt_regs));
> -               kthread_frame_init(frame, sp, stack_size);
> +               kthread_frame_init(frame, args->stack, (unsigned
> long)args->data);
>                 return 0;
>         }
>  
> @@ -191,8 +190,8 @@ int copy_thread(unsigned long clone_flags, unsigned
> long sp,
>         frame->bx = 0;
>         *childregs = *current_pt_regs();
>         childregs->ax = 0;
> -       if (sp)
> -               childregs->sp = sp;
> +       if (args->stack)
> +               childregs->sp = args->stack;
>  
>  #ifdef CONFIG_X86_32
>         task_user_gs(p) = get_user_gs(current_pt_regs());
> @@ -211,17 +210,17 @@ int copy_thread(unsigned long clone_flags,
> unsigned long sp,
>                  */
>                 childregs->sp = 0;
>                 childregs->ip = 0;
> -               kthread_frame_init(frame, sp, stack_size);
> +               kthread_frame_init(frame, args->stack, (unsigned
> long)args->data);
>                 return 0;
>         }
>  
>         /* Set a new TLS for the child thread? */
>         if (clone_flags & CLONE_SETTLS)
> -               ret = set_new_tls(p, tls);
> +               ret = set_new_tls(p, args->tls);
>  
>         /* Allocate a new shadow stack for pthread */
>         if (!ret)
> -               ret = shstk_alloc_thread_stack(p, clone_flags,
> stack_size);
> +               ret = shstk_alloc_thread_stack(p, clone_flags, args-
> >stack_size);
>  
>         if (!ret && unlikely(test_tsk_thread_flag(current,
> TIF_IO_BITMAP)))
>                 io_bitmap_share(p);
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index b9198a1b3a84..f138b23aee50 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -34,6 +34,7 @@ struct kernel_clone_args {
>         int io_thread;
>         struct cgroup *cgrp;
>         struct css_set *cset;
> +       void *data;
>  };
>  
>  /*
> @@ -67,8 +68,8 @@ extern void fork_init(void);
>  
>  extern void release_task(struct task_struct * p);
>  
> -extern int copy_thread(unsigned long, unsigned long, unsigned long,
> -                      struct task_struct *, unsigned long);
> +extern int copy_thread(unsigned long clone_flags, struct
> kernel_clone_args *args,
> +                      struct task_struct *p);
>  
>  extern void flush_thread(void);
>  
> @@ -85,10 +86,10 @@ extern void exit_files(struct task_struct *);
>  extern void exit_itimers(struct signal_struct *);
>  
>  extern pid_t kernel_clone(struct kernel_clone_args *kargs);
> -struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int
> node);
> +struct task_struct *create_io_thread(int (*fn)(void *), void *data,
> int node);
>  struct task_struct *fork_idle(int);
>  struct mm_struct *copy_init_mm(void);
> -extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long
> flags);
> +extern pid_t kernel_thread(int (*fn)(void *), void *data, unsigned
> long flags);
>  extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
>  int kernel_wait(pid_t pid, int *stat);
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d75a528f7b21..8af202e5651e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2170,7 +2170,7 @@ static __latent_entropy struct task_struct
> *copy_process(
>         retval = copy_io(clone_flags, p);
>         if (retval)
>                 goto bad_fork_cleanup_namespaces;
> -       retval = copy_thread(clone_flags, args->stack, args-
> >stack_size, p, args->tls);
> +       retval = copy_thread(clone_flags, args, p);
>         if (retval)
>                 goto bad_fork_cleanup_io;
>  
> @@ -2487,7 +2487,7 @@ struct mm_struct *copy_init_mm(void)
>   * The returned task is inactive, and the caller must fire it up
> through
>   * wake_up_new_task(p). All signals are blocked in the created task.
>   */
> -struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int
> node)
> +struct task_struct *create_io_thread(int (*fn)(void *), void *data,
> int node)
>  {
>         unsigned long flags =
> CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|
>                                 CLONE_IO;
> @@ -2496,7 +2496,7 @@ struct task_struct *create_io_thread(int
> (*fn)(void *), void *arg, int node)
>                                     CLONE_UNTRACED) & ~CSIGNAL),
>                 .exit_signal    = (lower_32_bits(flags) & CSIGNAL),
>                 .stack          = (unsigned long)fn,
> -               .stack_size     = (unsigned long)arg,
> +               .data           = data,
>                 .io_thread      = 1,
>         };
>  
> @@ -2594,14 +2594,14 @@ pid_t kernel_clone(struct kernel_clone_args
> *args)
>  /*
>   * Create a kernel thread.
>   */
> -pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
> +pid_t kernel_thread(int (*fn)(void *), void *data, unsigned long
> flags)
>  {
>         struct kernel_clone_args args = {
>                 .flags          = ((lower_32_bits(flags) | CLONE_VM |
>                                     CLONE_UNTRACED) & ~CSIGNAL),
>                 .exit_signal    = (lower_32_bits(flags) & CSIGNAL),
>                 .stack          = (unsigned long)fn,
> -               .stack_size     = (unsigned long)arg,
> +               .data           = data,
>         };
>  
>         return kernel_clone(&args);
> 
> 
