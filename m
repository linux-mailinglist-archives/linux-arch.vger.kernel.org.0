Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0522460C
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 23:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgGQV5K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 17:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgGQV5J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jul 2020 17:57:09 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84E452080D
        for <linux-arch@vger.kernel.org>; Fri, 17 Jul 2020 21:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595023028;
        bh=noomKzWcSadkSQIbmgdKgZXgBs+4yuntfKqQZu+KBbI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DqcxtJB45NwjXjt4u6E3Jdw9VG4C7yRnltpCSF/vEI9wl0YVSQ+QqfPNUI4f2Hv9s
         byI4gLnMl/oC+a9WDl8Bwn8YtSeFE7zi5z9qQusFDkfSYrE3FNGIfdI+pthADFGCSe
         nqpEsjUdcEsst98/tPDRX1QINc7yKLFymAtl9YiU=
Received: by mail-wm1-f48.google.com with SMTP id o2so19226600wmh.2
        for <linux-arch@vger.kernel.org>; Fri, 17 Jul 2020 14:57:08 -0700 (PDT)
X-Gm-Message-State: AOAM530MozvUiau6p5HB48uTr+efpmYzhWnxXJ/YmvOi5VtBUJZLKuhq
        mlAGLTVvBR4FuwuUoxHd3zae73h0mvs+szikM2vX9g==
X-Google-Smtp-Source: ABdhPJyQElH677ReHN3Lqg/NKsIPUR0/fapdKBcs9qocP99u5Ep+Sq28gjKSbiNvmyc3GD3z0g123byTdIyASfJ7ffs=
X-Received: by 2002:a1c:e4d4:: with SMTP id b203mr11807750wmh.49.1595023027071;
 Fri, 17 Jul 2020 14:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200716182208.180916541@linutronix.de> <20200716185424.011950288@linutronix.de>
 <202007161336.B993ED938@keescook> <87d04vt98w.fsf@nanos.tec.linutronix.de>
 <202007171045.FB4A586F1D@keescook> <87mu3yq6sf.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87mu3yq6sf.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 17 Jul 2020 14:56:55 -0700
X-Gmail-Original-Message-ID: <CALCETrXz_vEySQJ=f3MTPG9XjZS7U0P-diJE9j_+0KRa_Kie=Q@mail.gmail.com>
Message-ID: <CALCETrXz_vEySQJ=f3MTPG9XjZS7U0P-diJE9j_+0KRa_Kie=Q@mail.gmail.com>
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry functionality
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 17, 2020 at 12:29 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Kees Cook <keescook@chromium.org> writes:
> > On Thu, Jul 16, 2020 at 11:55:59PM +0200, Thomas Gleixner wrote:
> >> Kees Cook <keescook@chromium.org> writes:
> >> >> +/*
> >> >> + * Define dummy _TIF work flags if not defined by the architecture or for
> >> >> + * disabled functionality.
> >> >> + */
> >> >
> >> > When I was thinking about this last week I was pondering having a split
> >> > between the arch-agnositc TIF flags and the arch-specific TIF flags, and
> >> > that each arch could have a single "there is agnostic work to be done"
> >> > TIF in their thread_info, and the agnostic flags could live in
> >> > task_struct or something. Anyway, I'll keep reading...
> >>
> >> That's going to be nasty. We rather go and expand the TIF storage to
> >> 64bit. And then do the following in a generic header:
> >
> > I though the point was to make the TIF_WORK check as fast as possible,
> > even on the 32-bit word systems. I mean it's not a huge performance hit,
> > but *shrug*
>
> For 64bit it's definitely faster to have 64bit flags.
>
> For 32bit it's debatable whether having to fiddle with two words and
> taking care about ordering is faster or not. It's a pain on 32bit in any
> case.
>
> But what we can do is distangle the flags into those which really need
> to be grouped into a single 32bit TIF word and architecture specific
> ones which can live in a different place.
>
> Looking at x86 which has the most pressure on TIF bits:
>
> Real TIF bits
> TIF_SYSCALL_TRACE       Entry/exit
> TIF_SYSCALL_TRACEPOINT  Entry/exit
> TIF_NOTIFY_RESUME       Entry/exit
> TIF_SIGPENDING          Entry/exit
> TIF_NEED_RESCHED        Entry/exit
> TIF_SINGLESTEP          Entry/exit
> TIF_SYSCALL_EMU         Entry/exit
> TIF_SYSCALL_AUDIT       Entry/exit
> TIF_SECCOMP             Entry/exit
> TIF_USER_RETURN_NOTIFY  Entry/exit      (x86 specific)
> TIF_UPROBE              Entry/exit
> TIF_PATCH_PENDING       Entry/exit
> TIF_POLLING_NRFLAG      Scheduler (related to TIF_NEED_RESCHED)
> TIF_MEMDIE              Historical, but not required to be a real one
> TIF_FSCHECK             Historical, but not required to be a real one
>
> Context switch group
> TIF_NOCPUID             X86 Context switch
> TIF_NOTSC               X86 Context switch
> TIF_SLD                 X86 Context switch
> TIF_BLOCKSTEP           X86 Context switch
> TIF_IO_BITMAP           X86 Context switch + Entry/exit (see below)
> TIF_NEED_FPU_LOAD       X86 Context switch + Entry/exit (see below)
> TIF_SSBD                X86 Context switch
> TIF_SPEC_IB             X86 Context switch
> TIF_SPEC_FORCE_UPDATE   X86 Context switch
>
> No group requirements
> TIF_IA32                X86 random
> TIF_FORCED_TF           X86 random
> TIF_LAZY_MMU_UPDATES    X86 random
> TIF_ADDR32              X86 random
> TIF_X32                 X86 random
>
> So the only interesting ones are TIF_IO_BITMAP and TIF_NEED_FPU_LOAD,
> but those are really not required to be in the real TIF group because
> they are independently evaluated _after_ the real TIF flags on exit to
> user space and that requires a reread of the flags anyway. So if we put
> the context switch and the random bits into a seperate word right after
> thread_info->flags then the second word is in the same cacheline and it
> wont matter. That way we gain plenty of free bits on 32 bit and have no
> dependency between the two words at all.
>
> The alternative is to play nasty games with TIF_IA32, TIF_ADDR32 and
> TIF_X32 to free up bits for 32bit and make the flags field 64 bit on 64
> bit kernels, but I prefer to do the above seperation.

I'm all for cleaning it up, but I don't think any nasty games would be
needed regardless.  IMO at least the following flags are nonsense and
don't belong in TIF_anything at all:

TIF_IA32, TIF_X32: can probably be deleted.  Someone would just need
to finish the work.
TIF_ADDR32: also probably removable, but I'm less confident.
TIF_FORCED_TF: This is purely a ptrace artifact and could easily go
somewhere else entirely.

So getting those five bits back would be straightforward.

FWIW, TIF_USER_RETURN_NOTIFY is a bit of an odd duck: it's an
entry/exit word *and* a context switch word.  The latter is because
it's logically a per-cpu flag, not a per-task flag, and the context
switch code moves it around so it's always set on the running task.
TIF_NEED_RESCHED is sort of in this category, too.  We could introduce
a percpu entry_exit_work field to simplify this at some small
performance cost.  TIF_POLLING_NRFLAG would go along with it.  (The
latter does not, strictly speaking, belong as a TIF_ flag at all, but
it does need to be in the same atomic word as TIF_NEED_RESCHED.)
Making this change would arguably be a decent cleanup.

--Andy
