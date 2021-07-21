Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3730E3D17C8
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jul 2021 22:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhGUTek (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jul 2021 15:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhGUTej (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jul 2021 15:34:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF68C061575;
        Wed, 21 Jul 2021 13:15:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k4-20020a17090a5144b02901731c776526so579977pjm.4;
        Wed, 21 Jul 2021 13:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOGnEDYj6+aPEFG0m6p/HdJZ6lLy+2oB11LH/GMIPe8=;
        b=DQfgQO3uCJmeqfPd4GrrnMGsak6ZUiMipZ5qwGZtq+Y4GnbN+3ZveORbh7uh+P7+E5
         Ku/Q0UMDjt7U15df32VENimOMh3ZwtrJcN0sYnZvDr+UbOp39zxNBXTzGgEeIORNtAXY
         1Ye1OkKig6CHdJD/D5zeG4cOXQodWG4c90noX+n+xKnNY3so0BtSPU6o8pWYlVHiN3B3
         ENX5NV2ASXhgf6aPSywQx8ik2OzP6OW+ni11VnAaLtdMavEltJs0/pz1h1E2SViLf8SV
         uxLJfKNjZM7W0PMTRmpnPtaH3PSFofI4UyzIRQwKlnFTHOvaN/+kU7pndu/ledNmiCC3
         GZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOGnEDYj6+aPEFG0m6p/HdJZ6lLy+2oB11LH/GMIPe8=;
        b=U7MyZGcKOsr/FTrVDzvkIku2RCnfehlz9zRML6VGeJPc0mNolX+dpJCwLtkuEGZRXv
         4FwdjuwVfcVALIgJe+cgDN9l6BtSpx+jk2+E2ma0D6Qq81XqQRemluoK8hSXgdExYc0I
         GUzx63VjeH4wFhg/o7HW79OBV765KLyLKQfKnV540iZoo95loijPP972OYLp1mHdoUGA
         MxT0/Mlhgab/z5xMMpuVPJTwKJjpJVLAbI+gF4x7PyLNej2hJwc2kAmO5Hwxh8Ai4QYy
         pSVl7oMterHS0S59l0AUSvSoSPfBNf1VJ7jwH44MOveA9HsCFBt0MyQhCffQdBPRvxYn
         zJZA==
X-Gm-Message-State: AOAM530gK3pgkSnG9aEu+9JEImScTh1akb8YThC68WoC7+cIJVz/x/Ub
        JsxhnwdCr1Im7r3s5q4tUpywNgQKa8Btu8h29dQ=
X-Google-Smtp-Source: ABdhPJx640ylm2KAYp8SewF8Z1tD2mQcn3QMu2iUcvhaFtOAx0ZMixA4m1wVyyq0Dg6aSdjc6BVMPAJP4hkVR2M1HcU=
X-Received: by 2002:a63:58e:: with SMTP id 136mr6723399pgf.37.1626898513639;
 Wed, 21 Jul 2021 13:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210521221211.29077-1-yu-cheng.yu@intel.com> <20210521221211.29077-25-yu-cheng.yu@intel.com>
 <YPhkIHJ0guc4UNoO@AUS-LX-JohALLEN.amd.com>
In-Reply-To: <YPhkIHJ0guc4UNoO@AUS-LX-JohALLEN.amd.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 21 Jul 2021 13:14:37 -0700
Message-ID: <CAMe9rOqwe8Mr2pkf0yopWj_F7yZLj9_nmz97+AmFkkmd2U=-fg@mail.gmail.com>
Subject: Re: [PATCH v27 24/31] x86/cet/shstk: Handle thread shadow stack
To:     John Allen <john.allen@amd.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 21, 2021 at 11:15 AM John Allen <john.allen@amd.com> wrote:
>
> On Fri, May 21, 2021 at 03:12:04PM -0700, Yu-cheng Yu wrote:
> > diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> > index 5ea2b494e9f9..8e5f772181b9 100644
> > --- a/arch/x86/kernel/shstk.c
> > +++ b/arch/x86/kernel/shstk.c
> > @@ -71,6 +71,53 @@ int shstk_setup(void)
> >       return 0;
> >  }
> >
> > +int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
> > +                          unsigned long stack_size)
> > +{
> > +     struct thread_shstk *shstk = &tsk->thread.shstk;
> > +     struct cet_user_state *state;
> > +     unsigned long addr;
> > +
> > +     if (!stack_size)
> > +             return -EINVAL;
>
> I've been doing some light testing on AMD hardware and I've found that
> this version of the patchset doesn't boot for me. It appears that when
> systemd processes start spawning, they hit the above case, return
> -EINVAL, and the fork fails. In these cases, copy_thread has been passed
> 0 for both sp and stack_size.
>
> For previous versions of the patchset, I can still boot. When the
> stack_size check was last, the function would always return before
> completing the check, hitting one of the two cases below.
>
> At the very least, it would seem that on some systems, it isn't valid to
> rely on the stack_size passed from clone3, though I'm unsure what the
> correct behavior should be here. If the passed stack_size == 0 and sp ==
> 0, is this a case where we want to alloc a shadow stack for this thread
> with some capped size? Alternatively, is this a case that isn't valid to
> alloc a shadow stack and we should simply return 0 instead of -EINVAL?
>
> I'm running Fedora 34 which satisfies the required versions of gcc,
> binutils, and glibc.
>
> Please let me know if there is any additional information I can provide.

FWIW, I have been maintaining stable CET kernels at:

https://github.com/hjl-tools/linux/

The current CET kernel is on hjl/cet/linux-5.13.y branch.

> Thanks,
> John
>
> > +
> > +     if (!shstk->size)
> > +             return 0;
> > +
> > +     /*
> > +      * For CLONE_VM, except vfork, the child needs a separate shadow
> > +      * stack.
> > +      */
> > +     if ((clone_flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM)
> > +             return 0;
> > +
> > +     state = get_xsave_addr(&tsk->thread.fpu.state.xsave, XFEATURE_CET_USER);
> > +     if (!state)
> > +             return -EINVAL;
> > +
> > +     /*
> > +      * Compat-mode pthreads share a limited address space.
> > +      * If each function call takes an average of four slots
> > +      * stack space, allocate 1/4 of stack size for shadow stack.
> > +      */
> > +     if (in_compat_syscall())
> > +             stack_size /= 4;
> > +
> > +     stack_size = round_up(stack_size, PAGE_SIZE);
> > +     addr = alloc_shstk(stack_size);
> > +     if (IS_ERR_VALUE(addr)) {
> > +             shstk->base = 0;
> > +             shstk->size = 0;
> > +             return PTR_ERR((void *)addr);
> > +     }
> > +
> > +     fpu__prepare_write(&tsk->thread.fpu);
> > +     state->user_ssp = (u64)(addr + stack_size);
> > +     shstk->base = addr;
> > +     shstk->size = stack_size;
> > +     return 0;
> > +}
> > +
> >  void shstk_free(struct task_struct *tsk)
> >  {
> >       struct thread_shstk *shstk = &tsk->thread.shstk;
> > @@ -80,7 +127,13 @@ void shstk_free(struct task_struct *tsk)
> >           !shstk->base)
> >               return;
> >
> > -     if (!tsk->mm)
> > +     /*
> > +      * When fork() with CLONE_VM fails, the child (tsk) already has a
> > +      * shadow stack allocated, and exit_thread() calls this function to
> > +      * free it.  In this case the parent (current) and the child share
> > +      * the same mm struct.
> > +      */
> > +     if (!tsk->mm || tsk->mm != current->mm)
> >               return;
> >
> >       while (1) {



-- 
H.J.
