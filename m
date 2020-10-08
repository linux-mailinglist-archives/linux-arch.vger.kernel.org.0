Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F20287BE8
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 20:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgJHSyl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 14:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJHSyl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 14:54:41 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57614C061755
        for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2020 11:54:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j30so5336791lfp.4
        for <linux-arch@vger.kernel.org>; Thu, 08 Oct 2020 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ky2WD21wQid72+NsO6WdQlBNNtvzkIpw6bTgDjeYT3w=;
        b=DWa8l22j70joc7ItS2bai63vUYAKqyE/nonnBdVp92bX/AQNlGIFPXWqzdv4nv8NXX
         ALWhcnGsxcev21Zi1AcR8XzDt+sLJ+wpKDDtwwM2uChX5c3Wd+bvsEdomG69PUvsuxvT
         KLqyFniznkFjim9a3TmC7Yx4Cx5WtkKlyppq65gxabwbKLKFcb+zwWJyG3kF4ggZuQQ5
         VDxankrvuQEQ/g/JlcrOgCxllanr5whymr5mJ7YgSPZmft7qbYAOGvKyoFhE/ntJXFiF
         RKiSGWgym+REgKcKBKobaPSty2/mKT+FIumJGexNcccimWql7W2DWuvkvgm6xehX+AG2
         bvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ky2WD21wQid72+NsO6WdQlBNNtvzkIpw6bTgDjeYT3w=;
        b=M9FaA2yRSdbmbNDQEl8ygV0fxC8DOpk6iLiDXFsnBk+hDAhMWuPeo6aj6AEBdPN/02
         Db5n7SS744I4IlzUVN0yczgjI3QLU5I38xGDa7NSkYW4zcWebxc4aMaP11mhu1d6TWvg
         j1Q/mIGBmavdtbGXZXdC4Yo7TW1HDc894ei/FFLXoJbHoUtHi/Q+gf0euT0lhWpGIv6w
         uk3bW+Zy8hgWOMozqChsygyQaUNsK23b5FQ+vUZwvnH6RSh0VDpj/ndSR0I79+80Xz6v
         EpQBSUBjKjJHZr4iOeGaAkVBY5NoIzaKhJSvRpjgBUVjyA1mzJyHw3M8whvkDEkt2Z+7
         FQ9Q==
X-Gm-Message-State: AOAM530zSAAzAT3NN+8aSx5DgPptIW32EtOnY8B17Z8wZ8qti1lk3+PX
        4mJjG57WNidw3gFKtYz/VDra5k+WvO3opZIK1ydFmXSEGIBl2g==
X-Google-Smtp-Source: ABdhPJyuWReaTjCrGmLDuqcoc4tUIrjsVQomOU0J5sHtGkU1FBHuQ2yWPMVcoIMtjCh9QH1DiwzoL2Gj+ij46qSDlKA=
X-Received: by 2002:ac2:59d9:: with SMTP id x25mr2895843lfn.4.1602183279506;
 Thu, 08 Oct 2020 11:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com> <ff2087f4983a2b93abef0a4ad31c1309f71ea52d.1601960644.git.thehajime@gmail.com>
 <295bff3f6ddc941dbf3933e8e310ad641da3ce01.camel@sipsolutions.net>
In-Reply-To: <295bff3f6ddc941dbf3933e8e310ad641da3ce01.camel@sipsolutions.net>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Thu, 8 Oct 2020 21:54:28 +0300
Message-ID: <CAMoF9u3n-FyumX0S7vbjN-e+fWNe6k8aLeR-_BVJa7sR7qcFHg@mail.gmail.com>
Subject: Re: [RFC v7 11/21] um: nommu: kernel thread support
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 7, 2020 at 9:57 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> > nommu mode does not support user processes
>
> I find this really confusing. I'm not sure why you ended up calling this
> "nommu mode", but there *are* (still) (other) nommu arches, and they
> *do* support userspace processes.
>
> Isn't this really just "LKL mode" or something like that?
>

This is a very good point, while some other patches make sense in the
nommu mode, this one does not - it is rather needed because of the
"library mode".

Not sure what we can do other than creating a new "library mode" in
addition to the "nommu mode". Any suggestions?

> >  #define TIF_SYSCALL_TRACE    0       /* syscall trace active */
> > @@ -63,6 +85,8 @@ static inline struct thread_info *current_thread_info(void)
> >  #define TIF_RESTORE_SIGMASK  7
> >  #define TIF_NOTIFY_RESUME    8
> >  #define TIF_SECCOMP          9       /* secure computing */
> > +#define TIF_SCHED_JB         10
> > +#define TIF_HOST_THREAD              11
>
> It'd be nice to document what those mean, and even what "JB" means ... I
> saw something about "jump buffer" somewhere, but I have no idea why that
> should be a thread flag.
>
> > @@ -16,11 +16,65 @@ struct lkl_jmp_buf {
> >   * These operations must be provided by a host library or by the application
> >   * itself.
> >   *
> > + * @sem_alloc - allocate a host semaphore an initialize it to count
> > + * @sem_free - free a host semaphore
> > + * @sem_up - perform an up operation on the semaphore
> > + * @sem_down - perform a down operation on the semaphore
> > + *
> > + * @mutex_alloc - allocate and initialize a host mutex; the recursive parameter
> > + * determines if the mutex is recursive or not
> > + * @mutex_free - free a host mutex
> > + * @mutex_lock - acquire the mutex
> > + * @mutex_unlock - release the mutex
> > + *
> > + * @thread_create - create a new thread and run f(arg) in its context; returns a
> > + * thread handle or 0 if the thread could not be created
> > + * @thread_detach - on POSIX systems, free up resources held by
> > + * pthreads. Noop on Win32.
> > + * @thread_exit - terminates the current thread
> > + * @thread_join - wait for the given thread to terminate. Returns 0
> > + * for success, -1 otherwise
> > + *
> > + * @gettid - returns the host thread id of the caller, which need not
> > + * be the same as the handle returned by thread_create
> > + *
> > + * @jmp_buf_set - runs the give function and setups a jump back point by saving
> > + * the context in the jump buffer; jmp_buf_longjmp can be called from the give
> > + * function or any callee in that function to return back to the jump back
> > + * point
> > + *
> > + * NOTE: we can't return from jmp_buf_set before calling jmp_buf_longjmp or
> > + * otherwise the saved context (stack) is not going to be valid, so we must pass
> > + * the function that will eventually call longjmp here
> > + *
> > + * @jmp_buf_longjmp - perform a jump back to the saved jump buffer
> > + *
> >   * @mem_alloc - allocate memory
> >   * @mem_free - free memory
>
> again, kernel-doc.
>
> But I'm starting to doubt the value of having this struct at all. Care
> you explain? You're doing everything else already with weak functions,
> and you can't very well have _two_ hosts compiled anyway, so what's the
> point?
>
> IOW, why isn't this just
>
> void lkl_sem_free(struct lkl_sem *sem);
> void lkl_sem_up(struct lkl_sem *sem);
> ...
>
> and then posix-host.c just includes the header file and implements those
> functions?
>
> I don't see any reason for this to be allowed to have multiple variants
> linked and then picking them at runtime?
>

We could try that and see how it goes. This was baked liked this long
time ago, when we wanted to support Windows and there was no proper
support for weak functions in mingw for PE/COFF (it still not
supported but at least we do have a few patches that fix that).

> > +/*
> > + * This structure is used to get access to the "LKL CPU" that allows us to run
>
> Are you trying to implement SMP? This seems ... rather complex?
>
> > + * Linux code. Because we have to deal with various synchronization requirements
> > + * between idle thread, system calls, interrupts, "reentrancy", CPU shutdown,
> > + * imbalance wake up (i.e. acquire the CPU from one thread and release it from
> > + * another), we can't use a simple synchronization mechanism such as (recursive)
> > + * mutex or semaphore. Instead, we use a mutex and a bunch of status data plus a
> > + * semaphore.
> > + */
> > +static struct lkl_cpu {
> > +     /* lock that protects the CPU status data */
> > +     struct lkl_mutex *lock;
> > +     /*
> > +      * Since we must free the cpu lock during shutdown we need a
> > +      * synchronization algorithm between lkl_cpu_shutdown() and the CPU
> > +      * access functions since lkl_cpu_get() gets called from thread
> > +      * destructor callback functions which may be scheduled after
> > +      * lkl_cpu_shutdown() has freed the cpu lock.
> > +      *
> > +      * An atomic counter is used to keep track of the number of running
> > +      * CPU access functions and allow the shutdown function to wait for
> > +      * them.
> > +      *
> > +      * The shutdown functions adds MAX_THREADS to this counter which allows
> > +      * the CPU access functions to check if the shutdown process has
> > +      * started.
> > +      *
> > +      * This algorithm assumes that we never have more the MAX_THREADS
> > +      * requesting CPU access.
> > +      */
> > +     #define MAX_THREADS 1000000
> > +     unsigned int shutdown_gate;
> > +     bool irqs_pending;
> > +     /* no of threads waiting the CPU */
> > +     unsigned int sleepers;
> > +     /* no of times the current thread got the CPU */
> > +     unsigned int count;
> > +     /* current thread that owns the CPU */
> > +     lkl_thread_t owner;
> > +     /* semaphore for threads waiting the CPU */
> > +     struct lkl_sem *sem;
> > +     /* semaphore used for shutdown */
> > +     struct lkl_sem *shutdown_sem;
> > +} cpu;
> > +
> > +static int __cpu_try_get_lock(int n)
> > +{
> > +     lkl_thread_t self;
> > +
> > +     if (__sync_fetch_and_add(&cpu.shutdown_gate, n) >= MAX_THREADS)
> > +             return -2;
> > +
> > +     lkl_ops->mutex_lock(cpu.lock);
> > +
> > +     if (cpu.shutdown_gate >= MAX_THREADS)
> > +             return -1;
> > +
> > +     self = lkl_ops->thread_self();
> > +
> > +     if (cpu.owner && !lkl_ops->thread_equal(cpu.owner, self))
> > +             return 0;
> > +
> > +     cpu.owner = self;
> > +     cpu.count++;
> > +
> > +     return 1;
> > +}
> > +
> > +static void __cpu_try_get_unlock(int lock_ret, int n)
> > +{
> > +     if (lock_ret >= -1)
> > +             lkl_ops->mutex_unlock(cpu.lock);
> > +     __sync_fetch_and_sub(&cpu.shutdown_gate, n);
> > +}
> > +
> > +void lkl_cpu_change_owner(lkl_thread_t owner)
> > +{
> > +     lkl_ops->mutex_lock(cpu.lock);
> > +     if (cpu.count > 1)
> > +             lkl_bug("bad count while changing owner\n");
> > +     cpu.owner = owner;
> > +     lkl_ops->mutex_unlock(cpu.lock);
> > +}
> > +
> > +int lkl_cpu_get(void)
> > +{
> > +     int ret;
> > +
> > +     ret = __cpu_try_get_lock(1);
> > +
> > +     while (ret == 0) {
> > +             cpu.sleepers++;
> > +             __cpu_try_get_unlock(ret, 0);
> > +             lkl_ops->sem_down(cpu.sem);
> > +             ret = __cpu_try_get_lock(0);
> > +     }
> > +
> > +     __cpu_try_get_unlock(ret, 1);
> > +
> > +     return ret;
> > +}
> > +
> > +void lkl_cpu_put(void)
> > +{
> > +     lkl_ops->mutex_lock(cpu.lock);
> > +
> > +     if (!cpu.count || !cpu.owner ||
> > +         !lkl_ops->thread_equal(cpu.owner, lkl_ops->thread_self()))
> > +             lkl_bug("%s: unbalanced put\n", __func__);
> > +
> > +     while (cpu.irqs_pending && !irqs_disabled()) {
> > +             cpu.irqs_pending = false;
> > +             lkl_ops->mutex_unlock(cpu.lock);
> > +             run_irqs();
> > +             lkl_ops->mutex_lock(cpu.lock);
> > +     }
> > +
> > +     if (test_ti_thread_flag(current_thread_info(), TIF_HOST_THREAD) &&
> > +         !single_task_running() && cpu.count == 1) {
> > +             if (in_interrupt())
> > +                     lkl_bug("%s: in interrupt\n", __func__);
> > +             lkl_ops->mutex_unlock(cpu.lock);
> > +             thread_sched_jb();
> > +             return;
> > +     }
> > +
> > +     if (--cpu.count > 0) {
> > +             lkl_ops->mutex_unlock(cpu.lock);
> > +             return;
> > +     }
> > +
> > +     if (cpu.sleepers) {
> > +             cpu.sleepers--;
> > +             lkl_ops->sem_up(cpu.sem);
> > +     }
> > +
> > +     cpu.owner = 0;
> > +
> > +     lkl_ops->mutex_unlock(cpu.lock);
> > +}
> > +
> > +int lkl_cpu_try_run_irq(int irq)
> > +{
> > +     int ret;
> > +
> > +     ret = __cpu_try_get_lock(1);
> > +     if (!ret) {
> > +             set_irq_pending(irq);
> > +             cpu.irqs_pending = true;
> > +     }
> > +     __cpu_try_get_unlock(ret, 1);
> > +
> > +     return ret;
> > +}
> > +
> > +static void lkl_cpu_shutdown(void)
> > +{
> > +     __sync_fetch_and_add(&cpu.shutdown_gate, MAX_THREADS);
> > +}
> > +__uml_exitcall(lkl_cpu_shutdown);
> > +
> > +void lkl_cpu_wait_shutdown(void)
> > +{
> > +     lkl_ops->sem_down(cpu.shutdown_sem);
> > +     lkl_ops->sem_free(cpu.shutdown_sem);
> > +}
> > +
> > +static void lkl_cpu_cleanup(bool shutdown)
> > +{
> > +     while (__sync_fetch_and_add(&cpu.shutdown_gate, 0) > MAX_THREADS)
> > +             ;
> > +
> > +     if (shutdown)
> > +             lkl_ops->sem_up(cpu.shutdown_sem);
> > +     else if (cpu.shutdown_sem)
> > +             lkl_ops->sem_free(cpu.shutdown_sem);
> > +     if (cpu.sem)
> > +             lkl_ops->sem_free(cpu.sem);
> > +     if (cpu.lock)
> > +             lkl_ops->mutex_free(cpu.lock);
> > +}
>
> Yeah, what? That's an incomprehensible piece of code. At least add
> comments, if it _really_ is necessary?
>

Yeah, sorry about that. We missed adding a bunch of comments in the
commit message. It got this complicated because of optimizations to
avoid context switching between the native thread running the
application and the kernel thread running the system call or interrupt
handler.

Maybe we should revert to the initial simpler implementation for now
and add it later?

> > +#ifdef doesntwork
> > +     /* switch to idle_host_task */
> > +     wakeup_idle_host_task();
> > +#endif
>
> Well ...
>
> > +/**
> > + * This is called before the kernel initializes, so no kernel calls (including
> > + * printk) can't be made yet.
> > + */
>
> not kernel-doc
>
> try to compile with W=1 :)
>
> johannes
>
