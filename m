Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1BE372853
	for <lists+linux-arch@lfdr.de>; Tue,  4 May 2021 11:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhEDJx5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 May 2021 05:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhEDJx4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 May 2021 05:53:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFC0C061574
        for <linux-arch@vger.kernel.org>; Tue,  4 May 2021 02:53:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b11-20020a7bc24b0000b0290148da0694ffso880530wmj.2
        for <linux-arch@vger.kernel.org>; Tue, 04 May 2021 02:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nbYaFoj0a2opBaBQYBBRmlSUUXl+1Qvyp4TrOePSvwA=;
        b=FjfNrm6cBuQLC8ebM/acC4hk9v0oVNU2o6rWkuc+sJZLDLTs7x4PT//VvQtKpn/FOq
         X5Wy2ItNsi0HtqESBcwjhSwcXcYMq+tqc6ZrrfyOWNjDbl96fImjItFgN8SDmhkHIzaB
         xT+Rleheq46YqepDFQf8mcLeRWw1MBFjWoGWbVUv3S1Jp4rF5x5UEpUmyz6ZV9xIkY56
         zWoKDjirBukg5J/pedaovoAypOtNxOaTDEEjvVK7ndLaz34z9kUkUyvoM+dYgvHiX5J9
         7O2E98e2YnI5CoZwj5FAaypcOYtdw4+mXwjHbPCUX1MFM13H+I+0TMKKNhOZIADlE0/s
         eYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nbYaFoj0a2opBaBQYBBRmlSUUXl+1Qvyp4TrOePSvwA=;
        b=tIovhG6Y2auC7rRBz//nk4PSDdGcdmG9YpNJwBX3aKatQvmSDtELbuCbXgjEbDCuPx
         K+As/dWBqvkMwtLtyMRUsDCjI+/U3v+7jABr3wg6sVxKsDMI5P+gIPSQMdqvymYSLEeC
         W9g1H3enHqL3yd67TW6Ng87hbRJ2Q5KrFgBtVw+o2q2bDe76RlvGVHmNy8g/5DNEKPsJ
         9dCmTCJPRGa4Vep+G6XOL3TIOjTcqpJNYL/3c456soSK0F7lujvKtZ7C61xk0LfYOs05
         PUA0lSocq0Th6rgdiALV0PGI7oJ76eUHagskD9PMcWxRCxN8bUJXZSYYRtPCvpl0Y1Fh
         HzYg==
X-Gm-Message-State: AOAM531iByNUQj64lQ0CmsxTBnW5j51wx91IKZuappqVgZnSjS7UMdHc
        qxHD1/lUD88ZNUqFTIG0r19tMw==
X-Google-Smtp-Source: ABdhPJycgtmF3JWdk/ehC+TSGB+dVEK7HZAn53WQ3OLAn4ZVdnwicCKBkdMmP1aFdKThHI/rg8Tc+A==
X-Received: by 2002:a1c:b087:: with SMTP id z129mr2922551wme.67.1620121980472;
        Tue, 04 May 2021 02:53:00 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:fd3e:f300:5aa9:4169])
        by smtp.gmail.com with ESMTPSA id p5sm2107257wma.45.2021.05.04.02.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 02:52:59 -0700 (PDT)
Date:   Tue, 4 May 2021 11:52:54 +0200
From:   Marco Elver <elver@google.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 10/12] signal: Redefine signinfo so 64bit fields are
 possible
Message-ID: <YJEZdhe6JGFNYlum@elver.google.com>
References: <m14kfjh8et.fsf_-_@fess.ebiederm.org>
 <20210503203814.25487-1-ebiederm@xmission.com>
 <20210503203814.25487-10-ebiederm@xmission.com>
 <m1o8drfs1m.fsf@fess.ebiederm.org>
 <CANpmjNNOK6Mkxkjx5nD-t-yPQ-oYtaW5Xui=hi3kpY_-Y0=2JA@mail.gmail.com>
 <m1lf8vb1w8.fsf@fess.ebiederm.org>
 <CAMn1gO7+wMzHoGtp2t3=jJxRmPAGEbhnUDFLQQ0vFXZ2NP8stg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO7+wMzHoGtp2t3=jJxRmPAGEbhnUDFLQQ0vFXZ2NP8stg@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 03, 2021 at 09:03PM -0700, Peter Collingbourne wrote:
> On Mon, May 3, 2021 at 8:42 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > Marco Elver <elver@google.com> writes:
> > > On Mon, 3 May 2021 at 23:04, Eric W. Biederman <ebiederm@xmission.com> wrote:
> > >> "Eric W. Beiderman" <ebiederm@xmission.com> writes:
> > >> > From: "Eric W. Biederman" <ebiederm@xmission.com>
> > >> >
> > >> > The si_perf code really wants to add a u64 field.  This change enables
> > >> > that by reorganizing the definition of siginfo_t, so that a 64bit
> > >> > field can be added without increasing the alignment of other fields.
> > >
> > > If you can, it'd be good to have an explanation for this, because it's
> > > not at all obvious -- some future archeologist will wonder how we ever
> > > came up with this definition of siginfo...
> > >
> > > (I see the trick here is that before the union would have changed
> > > alignment, introducing padding after the 3 ints -- but now because the
> > > 3 ints are inside the union the union's padding no longer adds padding
> > > for these ints.  Perhaps you can explain it better than I can. Also
> > > see below.)
> >
> > Yes.  The big idea is adding a 64bit field into the second union
> > in the _sigfault case will increase the alignment of that second
> > union to 64bit.
> >
> > In the 64bit case the alignment is already 64bit so it is not an
> > issue.
> >
> > In the 32bit case there are 3 ints followed by a pointer.  When the
> > 64bit member is added the alignment of _segfault becomes 64bit.  That
> > 64bit alignment after 3 ints changes the location of the 32bit pointer.
> >
> > By moving the 3 preceding ints into _segfault that does not happen.
> >
> >
> >
> > There remains one very subtle issue that I think isn't a problem
> > but I would appreciate someone else double checking me.
> >
> >
> > The old definition of siginfo_t on 32bit almost certainly had 32bit
> > alignment.  With the addition of a 64bit member siginfo_t gains 64bit
> > alignment.  This difference only matters if the 64bit field is accessed.
> > Accessing a 64bit field with 32bit alignment will cause unaligned access
> > exceptions on some (most?) architectures.
> >
> > For the 64bit field to be accessed the code needs to be recompiled with
> > the new headers.  Which implies that when everything is recompiled
> > siginfo_t will become 64bit aligned.
> >
> >
> > So the change should be safe unless someone is casting something with
> > 32bit alignment into siginfo_t.
> 
> How about if someone has a field of type siginfo_t as an element of a
> struct? For example:
> 
> struct foo {
>   int x;
>   siginfo_t y;
> };
> 
> With this change wouldn't the y field move from offset 4 to offset 8?

This is a problem if such a struct is part of the ABI -- in the kernel I
found these that might be problematic:

| arch/csky/kernel/signal.c:struct rt_sigframe {
| arch/csky/kernel/signal.c-	/*
| arch/csky/kernel/signal.c-	 * pad[3] is compatible with the same struct defined in
| arch/csky/kernel/signal.c-	 * gcc/libgcc/config/csky/linux-unwind.h
| arch/csky/kernel/signal.c-	 */
| arch/csky/kernel/signal.c-	int pad[3];
| arch/csky/kernel/signal.c-	struct siginfo info;
| arch/csky/kernel/signal.c-	struct ucontext uc;
| arch/csky/kernel/signal.c-};
| [...]
| arch/parisc/include/asm/rt_sigframe.h-#define SIGRETURN_TRAMP 4
| arch/parisc/include/asm/rt_sigframe.h-#define SIGRESTARTBLOCK_TRAMP 5 
| arch/parisc/include/asm/rt_sigframe.h-#define TRAMP_SIZE (SIGRETURN_TRAMP + SIGRESTARTBLOCK_TRAMP)
| arch/parisc/include/asm/rt_sigframe.h-
| arch/parisc/include/asm/rt_sigframe.h:struct rt_sigframe {
| arch/parisc/include/asm/rt_sigframe.h-	/* XXX: Must match trampoline size in arch/parisc/kernel/signal.c 
| arch/parisc/include/asm/rt_sigframe.h-	        Secondary to that it must protect the ERESTART_RESTARTBLOCK
| arch/parisc/include/asm/rt_sigframe.h-		trampoline we left on the stack (we were bad and didn't 
| arch/parisc/include/asm/rt_sigframe.h-		change sp so we could run really fast.) */
| arch/parisc/include/asm/rt_sigframe.h-	unsigned int tramp[TRAMP_SIZE];
| arch/parisc/include/asm/rt_sigframe.h-	struct siginfo info;
| [..]
| arch/parisc/kernel/signal32.h-#define COMPAT_SIGRETURN_TRAMP 4
| arch/parisc/kernel/signal32.h-#define COMPAT_SIGRESTARTBLOCK_TRAMP 5
| arch/parisc/kernel/signal32.h-#define COMPAT_TRAMP_SIZE (COMPAT_SIGRETURN_TRAMP + \
| arch/parisc/kernel/signal32.h-				COMPAT_SIGRESTARTBLOCK_TRAMP)
| arch/parisc/kernel/signal32.h-
| arch/parisc/kernel/signal32.h:struct compat_rt_sigframe {
| arch/parisc/kernel/signal32.h-        /* XXX: Must match trampoline size in arch/parisc/kernel/signal.c
| arch/parisc/kernel/signal32.h-                Secondary to that it must protect the ERESTART_RESTARTBLOCK
| arch/parisc/kernel/signal32.h-                trampoline we left on the stack (we were bad and didn't
| arch/parisc/kernel/signal32.h-                change sp so we could run really fast.) */
| arch/parisc/kernel/signal32.h-        compat_uint_t tramp[COMPAT_TRAMP_SIZE];
| arch/parisc/kernel/signal32.h-        compat_siginfo_t info;

Adding these static asserts to parisc shows the problem:

| diff --git a/arch/parisc/kernel/signal.c b/arch/parisc/kernel/signal.c
| index fb1e94a3982b..0be582fb81be 100644
| --- a/arch/parisc/kernel/signal.c
| +++ b/arch/parisc/kernel/signal.c
| @@ -610,3 +610,6 @@ void do_notify_resume(struct pt_regs *regs, long in_syscall)
|  	if (test_thread_flag(TIF_NOTIFY_RESUME))
|  		tracehook_notify_resume(regs);
|  }
| +
| +static_assert(sizeof(unsigned long) == 4); // 32 bit build
| +static_assert(offsetof(struct rt_sigframe, info) == 9 * 4);

This passes without the siginfo rework in this patch. With it:

| ./include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct rt_sigframe, info) == 9 * 4"

As sad as it is, I don't think we can have our cake and eat it, too. :-(

Unless you see why this is fine, I think we need to drop this patch and
go back to the simpler version you had.

Thanks,
-- Marco
