Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABFF36E1EB
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 01:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhD1XEx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 19:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhD1XEx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 19:04:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAA5E61455
        for <linux-arch@vger.kernel.org>; Wed, 28 Apr 2021 23:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619651047;
        bh=0afqfeFLgdB0fTNzaLFOMLYgWe3yB1y7QqmEFNzjedY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s8CPOaIFrcZ6bgfFP6FstGuiS/Ep8lWIPMWnb/Iw39Kg8z0S6Hu4s34I7h0HF9dsO
         +jFJk3d8n+w7lQ3eNw+yzriu6NxFWTCNH+jtp5oeyK8l/QS+jeRDJ+d1OnU0USEegh
         +uux6L2gxngj6rNRFS8k+uTH3ngbWIj4yS5oYVpyMQM86An6XE9OCy2mYbVY4ECwti
         AsMh5rD4V7hbfjc3SXOiaKr7Q6bDENZ5iN1pV8hPkHPzM/l8lhf29EM91z/4YxbmpZ
         TmBqhOZm3Up25Hcy3mCbTpIA4g3ot3UsnqAZyVor05LSO9XfRFejgMe+QRf7O7MPDh
         OmWSmvkCLu+yA==
Received: by mail-ej1-f49.google.com with SMTP id a4so3641331ejk.1
        for <linux-arch@vger.kernel.org>; Wed, 28 Apr 2021 16:04:07 -0700 (PDT)
X-Gm-Message-State: AOAM5314mkqBzgTFjefcL8ZEEAuVOIO8LH6lGmUNDc0+is7XcJPdryEu
        IRBbFEPYHbG8U4rdZJ1nxONE56hkDYGPtL/xhy3yXQ==
X-Google-Smtp-Source: ABdhPJzcb8Hw7Su0s8Rgxkv7jYWxNcuy2WTKMRFpTCb8fN9sWcUB+ds4ywq5Mo5SLRg2DAoSXXOtfYklNGY1ADo5ZH8=
X-Received: by 2002:a17:906:6896:: with SMTP id n22mr32665459ejr.316.1619651045990;
 Wed, 28 Apr 2021 16:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210427204315.24153-1-yu-cheng.yu@intel.com> <20210427204315.24153-26-yu-cheng.yu@intel.com>
In-Reply-To: <20210427204315.24153-26-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 28 Apr 2021 16:03:55 -0700
X-Gmail-Original-Message-ID: <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com>
Message-ID: <CALCETrVTeYfzO-XWh+VwTuKCyPyp-oOMGH=QR_msG9tPQ4xPmA@mail.gmail.com>
Subject: extending ucontext (Re: [PATCH v26 25/30] x86/cet/shstk: Handle
 signals for shadow stack)
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 27, 2021 at 1:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> When shadow stack is enabled, a task's shadow stack states must be saved
> along with the signal context and later restored in sigreturn.  However,
> currently there is no systematic facility for extending a signal context.
> There is some space left in the ucontext, but changing ucontext is likely
> to create compatibility issues and there is not enough space for further
> extensions.
>
> Introduce a signal context extension struct 'sc_ext', which is used to save
> shadow stack restore token address.  The extension is located above the fpu
> states, plus alignment.  The struct can be extended (such as the ibt's
> wait_endbr status to be introduced later), and sc_ext.total_size field
> keeps track of total size.

I still don't like this.

Here's how the signal layout works, for better or for worse:

The kernel has:

struct rt_sigframe {
    char __user *pretcode;
    struct ucontext uc;
    struct siginfo info;
    /* fp state follows here */
};

This is roughly the actual signal frame.  But userspace does not have
this struct declared, and user code does not know the sizes of the
fields.  So it's accessed in a nonsensical way.  The signal handler
function is passed a pointer to the whole sigframe implicitly in RSP,
a pointer to &frame->info in RSI, anda pointer to &frame->uc in RDX.
User code can *find* the fp state by following a pointer from
mcontext, which is, in turn, found via uc:

struct ucontext {
    unsigned long      uc_flags;
    struct ucontext  *uc_link;
    stack_t          uc_stack;
    struct sigcontext uc_mcontext;  <-- fp pointer is in here
    sigset_t      uc_sigmask;    /* mask last for extensibility */
};

The kernel, in sigreturn, works a bit differently.  The sigreturn
variants know the base address of the frame but don't have the benefit
of receiving pointers to the fields.  So instead the kernel takes
advantage of the fact that it knows the offset to uc and parses uc
accordingly.  And the kernel follows the pointer in mcontext to find
the fp state.  The latter bit is quite important later.  The kernel
does not parse info at all.

The fp state is its own mess.  When XSAVE happened, Intel kindly (?)
gave us a software defined area between the "legacy" x87 region and
the modern supposedly extensible part.  Linux sticks the following
structure in that hole:

struct _fpx_sw_bytes {
    /*
     * If set to FP_XSTATE_MAGIC1 then this is an xstate context.
     * 0 if a legacy frame.
     */
    __u32                magic1;

    /*
     * Total size of the fpstate area:
     *
     *  - if magic1 == 0 then it's sizeof(struct _fpstate)
     *  - if magic1 == FP_XSTATE_MAGIC1 then it's sizeof(struct _xstate)
     *    plus extensions (if any)
     */
    __u32                extended_size;

    /*
     * Feature bit mask (including FP/SSE/extended state) that is present
     * in the memory layout:
     */
    __u64                xfeatures;

    /*
     * Actual XSAVE state size, based on the xfeatures saved in the layout.
     * 'extended_size' is greater than 'xstate_size':
     */
    __u32                xstate_size;

    /* For future use: */
    __u32                padding[7];
};


That's where we are right now upstream.  The kernel has a parser for
the FPU state that is bugs piled upon bugs and is going to have to be
rewritten sometime soon.  On top of all this, we have two upcoming
features, both of which require different kinds of extensions:

1. AVX-512.  (Yeah, you thought this story was over a few years ago,
but no.  And AMX makes it worse.)  To make a long story short, we
promised user code many years ago that a signal frame fit in 2048
bytes with some room to spare.  With AVX-512 this is false.  With AMX
it's so wrong it's not even funny.  The only way out of the mess
anyone has come up with involves making the length of the FPU state
vary depending on which features are INIT, i.e. making it more compact
than "compact" mode is.  This has a side effect: it's no longer
possible to modify the state in place, because enabling a feature with
no space allocated will make the structure bigger, and the stack won't
have room.  Fortunately, one can relocate the entire FPU state, update
the pointer in mcontext, and the kernel will happily follow the
pointer.  So new code on a new kernel using a super-compact state
could expand the state by allocating new memory (on the heap? very
awkwardly on the stack?) and changing the pointer.  For all we know,
some code already fiddles with the pointer.  This is great, except
that your patch sticks more data at the end of the FPU block that no
one is expecting, and your sigreturn code follows that pointer, and
will read off into lala land.

2. CET.  CET wants us to find a few more bytes somewhere, and those
bytes logically belong in ucontext, and here we are.

This is *almost*, but not quite, easy: struct ucontext is already
variable length!  Unfortunately, the whole variable length portion is
used up by uc_sigmask.  So I propose that we introduce a brand new
bona fide extension mechanism.  It works like this:

First, we add a struct ucontext_extension at the end.  It looks like:

struct ucontext_extension {
  u64 length;  /* sizeof(struct ucontext_extension) */
  u64 flags;  /* we will want this some day */
  [CET stuff here]
  [future stuff here]
};

And we locate it by scrounging a word somewhere in ucontext to give
the offset from the beginning of struct ucontext to
ucontext_extension.  We indicate the presence of this feature using a
new uc_flags bit.  I can think of a couple of vaguely reasonable
places:

a) the reserved word in sigcontext.  This is fine for x86 but not so
great if other architectures want to do this.

b) uc_link.  Fine everywhere but powerpc.  Oops.

c) use the high bits of uc_flags.  After all, once we add extensions,
we don't need new flags, so we can steal 16 high bits of uc_flags for
this.

I think I'm in favor of (c).  We do:

(uc_flags & 0xffff0000) == 0: extension not present

Otherwise the extension region is at ucontext + (uc_flags >> 16).

And sigreturn finds the extension the same way, because CRIU can
already migrate a signal frame from one kernel to another, your patch
breaks this, and having sigreturn hardcode the offset would also break
it.

What do you think?
