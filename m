Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A008F4BBD83
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 17:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiBRQae (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 11:30:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbiBRQad (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 11:30:33 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBAD166A49
        for <linux-arch@vger.kernel.org>; Fri, 18 Feb 2022 08:30:16 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f37so6435089lfv.8
        for <linux-arch@vger.kernel.org>; Fri, 18 Feb 2022 08:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=312lapKwafxiS2MTjPJeJeudqKLuqKmyJULFLFuRBRY=;
        b=CSnkaVF1tUHg9btEqNzLCWt4jG+0S94ZEQOsehqLGYk57c0fNxkCwHWdO/Xl1gKqem
         Gg/f14dX+7wWYzFYheYfoZyx2BS8B2SQDBdK7bNwuGG8Wv5LBxRoK4Q5NUSDBKT2nvFM
         wKwFZ03p+TxfPINCCCHya0gBtsi157a40o0HTkMT8nu7qTm4aDcDRkheX2TfAQ/1+atK
         wu1Zkvm9JQ3V6JnPaN40HGfEZRnJtlSSpqYwVFP1L5bzKmS2+CwVr5BcY445k9CIESu9
         uJvguLH/z3ujJMwfYHdstVPHP27R/8BUj+sRdHT0ukT0oKwgznkO7rKokZLYn0r5/Yez
         Dylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=312lapKwafxiS2MTjPJeJeudqKLuqKmyJULFLFuRBRY=;
        b=zffAcxhZBOKherXgPNRjnWKv/diHjhDzfnMN+P3MdfGsyHDtevNcWjNAc3FsB2uoJF
         UKyHvqQ5UShC3wR/K+hevChniyAZrQXUDD0otKmIgWlM2GHkZ6hpzqoja54GDZ16VTo3
         dxVyMsVoWrk8/kTeRF3RtwRa59YKkkoOWC4r7rawY0+ASYgOp5SNd7+xxAY+ErkEzxIw
         wbSsxGRD8IeLKfMVI0IxyHL3lDW5sgZlIvkHfglfmEt6n9LTC376ohA5hcW2y2AgVvdM
         d8rIiivDltYOatt2D03aDivj4jot9vgKuL/DgI6+zS8BQGH5QojWtdAwus1o0WdYnoCh
         6tHg==
X-Gm-Message-State: AOAM531u93rs/irzapYdQsVarMCDFu42LS8ZKAHz9b8mPjH47PPFSUMq
        h6pVyFqenwOwf8cNSMtId/GN0Cqpfh9D4kmp1h+EJA==
X-Google-Smtp-Source: ABdhPJz5qGIkghROC2DmhXeLI1kRTQMiyE1CPE9Z6IYObgWq2hfondwj22K8KKj0a4/flTwBJ324HRBwNTjQT1617ZA=
X-Received: by 2002:a05:6512:b83:b0:443:161a:e467 with SMTP id
 b3-20020a0565120b8300b00443161ae467mr5871108lfv.315.1645201814922; Fri, 18
 Feb 2022 08:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com> <20220217184829.1991035-2-jakobkoschel@gmail.com>
In-Reply-To: <20220217184829.1991035-2-jakobkoschel@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Feb 2022 17:29:48 +0100
Message-ID: <CAG48ez0m6V12dPVwZMQ9gi0ig7ELf_+KbLArE02SD5cYrZvH-w@mail.gmail.com>
Subject: Re: [RFC PATCH 01/13] list: introduce speculative safe list_for_each_entry()
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 17, 2022 at 7:48 PM Jakob Koschel <jakobkoschel@gmail.com> wrote:
> list_for_each_entry() selects either the correct value (pos) or a safe
> value for the additional mispredicted iteration (NULL) for the list
> iterator.
> list_for_each_entry() calls select_nospec(), which performs
> a branch-less select.
>
> On x86, this select is performed via a cmov. Otherwise, it's performed
> via various shift/mask/etc. operations.
>
> Kasper Acknowledgements: Jakob Koschel, Brian Johannesmeyer, Kaveh
> Razavi, Herbert Bos, Cristiano Giuffrida from the VUSec group at VU
> Amsterdam.
>
> Co-developed-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Yeah, I think this is the best way to do this without deeply intrusive
changes to how lists are represented in memory.

Some notes on the specific implementation:

>  arch/x86/include/asm/barrier.h | 12 ++++++++++++
>  include/linux/list.h           |  3 ++-
>  include/linux/nospec.h         | 16 ++++++++++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index 35389b2af88e..722797ad74e2 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -48,6 +48,18 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
>  /* Override the default implementation from linux/nospec.h. */
>  #define array_index_mask_nospec array_index_mask_nospec
>
> +/* Override the default implementation from linux/nospec.h. */
> +#define select_nospec(cond, exptrue, expfalse)                         \
> +({                                                                     \
> +       typeof(exptrue) _out = (exptrue);                               \
> +                                                                       \
> +       asm volatile("test %1, %1\n\t"                                  \

This shouldn't need "volatile", because it is only necessary if _out
is actually used. Using "volatile" here could prevent optimizing out
useless code. OPTIMIZER_HIDE_VAR() also doesn't use "volatile".

> +           "cmove %2, %0"                                              \
> +           : "+r" (_out)                                               \
> +           : "r" (cond), "r" (expfalse));                              \
> +       _out;                                                           \
> +})

I guess the idea is probably to also add code like this for other
important architectures, in particular arm64?


It might also be a good idea to rename the arch-overridable macro to
something like "arch_select_nospec" and then have a wrapper macro in
include/linux/nospec.h that takes care of type safety issues.

The current definition of the macro doesn't warn if you pass in
incompatible pointer types, like this:

int *bogus_pointer_mix(int cond, int *a, long *b) {
  return select_nospec(cond, a, b);
}

and if you pass in integers of different sizes, it may silently
truncate to the size of the smaller one - this C code:

long wrong_int_conversion(int cond, int a, long b) {
  return select_nospec(cond, a, b);
}

generates this assembly:

wrong_int_conversion:
  test %edi, %edi
  cmove %rdx, %esi
  movslq %esi, %rax
  ret

It might be a good idea to add something like a
static_assert(__same_type(...), ...) to protect against that.

>  /* Prevent speculative execution past this barrier. */
>  #define barrier_nospec() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
>
> diff --git a/include/linux/list.h b/include/linux/list.h
> index dd6c2041d09c..1a1b39fdd122 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -636,7 +636,8 @@ static inline void list_splice_tail_init(struct list_head *list,
>   */
>  #define list_for_each_entry(pos, head, member)                         \
>         for (pos = list_first_entry(head, typeof(*pos), member);        \
> -            !list_entry_is_head(pos, head, member);                    \
> +           ({ bool _cond = !list_entry_is_head(pos, head, member);     \
> +            pos = select_nospec(_cond, pos, NULL); _cond; }); \
>              pos = list_next_entry(pos, member))

I wonder if it'd look nicer to write it roughly like this:

#define NOSPEC_TYPE_CHECK(_guarded_var, _cond)                  \
({                                                              \
  bool __cond = (_cond);                                        \
  typeof(_guarded_var) *__guarded_var = &(_guarded_var);        \
  *__guarded_var = select_nospec(__cond, *__guarded_var, NULL); \
  __cond;                                                       \
})

#define list_for_each_entry(pos, head, member)                                \
        for (pos = list_first_entry(head, typeof(*pos), member);              \
             NOSPEC_TYPE_CHECK(head, !list_entry_is_head(pos, head, member)); \
             pos = list_next_entry(pos, member))

I think having a NOSPEC_TYPE_CHECK() like this makes it semantically
clearer, and easier to add in other places? But I don't know if the
others agree...

>  /**
> diff --git a/include/linux/nospec.h b/include/linux/nospec.h
> index c1e79f72cd89..ca8ed81e4f9e 100644
> --- a/include/linux/nospec.h
> +++ b/include/linux/nospec.h
> @@ -67,4 +67,20 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
>  /* Speculation control for seccomp enforced mitigation */
>  void arch_seccomp_spec_mitigate(struct task_struct *task);
>
> +/**
> + * select_nospec - select a value without using a branch; equivalent to:
> + * cond ? exptrue : expfalse;
> + */
> +#ifndef select_nospec
> +#define select_nospec(cond, exptrue, expfalse)                         \
> +({                                                                     \
> +       unsigned long _t = (unsigned long) (exptrue);                   \
> +       unsigned long _f = (unsigned long) (expfalse);                  \
> +       unsigned long _c = (unsigned long) (cond);                      \
> +       OPTIMIZER_HIDE_VAR(_c);                                         \
> +       unsigned long _m = -((_c | -_c) >> (BITS_PER_LONG - 1));        \
> +       (typeof(exptrue)) ((_t & _m) | (_f & ~_m));                     \
> +})
> +#endif

(As a sidenote, it might be easier to implement a conditional zeroing
primitive than a generic conditional select primitive if that's all
you need, something like:

#define cond_nullptr_nospec(_cond, _exp)          \
({                                             \
  unsigned long __exp = (unsigned long)(_exp); \
  unsigned long _mask = 0UL - !(_cond);       \
  OPTIMIZER_HIDE_VAR(_mask);                   \
  (typeof(_exp)) (_mask & __exp);              \
})

)
