Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C93B286622
	for <lists+linux-arch@lfdr.de>; Wed,  7 Oct 2020 19:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgJGRnh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Oct 2020 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgJGRnh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Oct 2020 13:43:37 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EF3C061755;
        Wed,  7 Oct 2020 10:43:37 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id w7so829214oow.7;
        Wed, 07 Oct 2020 10:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rr40AY17+JN/ccHdnYDYpYoE+EL3oWtfHYYLIZ6ISKI=;
        b=jiNGfVsdbIVH7ct6dBucop1ZgWPgO3OoJlnYoceAGa/82d2s+oLMVvFzjiewVnqXXN
         rif5allW3ZQ9I25wdg3wMCWGTT0TbobVGmUdsnimqCi0gMu9JM1j6rclRfEH0WxXVP1m
         tB7ScWP07WLG9QOEnE/EuMkCyS10ciad37jGU3nDxft38JSt/Ulh7Lz7dN9dsUI17gKX
         woggP5QeeqrKePHK4a++LMCVPkMxlQh0QHsrAgsz5lw7fMVuu5n6MP8EG8z6Dp4QLbfv
         8rsBU4cIIU64uRMJ2vGpak49SfHWq4QD/1WcBtwCsSzsJLeskcpV621MVPNVNGv5G7Cf
         2QTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rr40AY17+JN/ccHdnYDYpYoE+EL3oWtfHYYLIZ6ISKI=;
        b=dYC1vOpqkiYAOwP9wMCRtRAle17tiaXzMy3pI97I8CU2jZli36W2E7J7xpgxUkGgZ9
         HWAvq8iVGOJxday38PNtxDcf8iooq94+2Q/EBbOCOTYHP9eoTBs93cPGE9jN3dNenxcP
         7YnBFBFQyTL1usaUeW80P/+xRxlUXtznlKL8RHkypc0b8f6jy/jFJylTLkBLMP3WKI0u
         ncmOUsB1ZZUI3IvVhWrNO14iM/ovb/Dy0Wh9ZkmPEFf078cCF9eKGqaXV7sKrKWAdw3m
         osytaJ9Bn7Uu/cThNpIfh5C0QnLj3o8B1ONpgyi10/7cao9sGGHQCWfTt0RBgGK+KOQw
         MHMQ==
X-Gm-Message-State: AOAM532jrDBFzFZFrNV8n7cgV4BJrIs/Ttm4Fqp/9oOACGpAS0u/ZvEP
        TwuDtgxkndSdFLmREQTe1DCh2OgrUZIyATbXUbA=
X-Google-Smtp-Source: ABdhPJzWMVzGqR5SxyUc86nVDzuxbj/uZppqxB/TRkQD4b0cE2CbMgcvq5u2gDDqnO15qQxtBZjZImNvNE0ffWyvl2Q=
X-Received: by 2002:a4a:d40c:: with SMTP id n12mr2801524oos.35.1602092616732;
 Wed, 07 Oct 2020 10:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201005134534.GT6642@arm.com> <CAMe9rOpZm43aDG3UJeaioU32zSYdTxQ=ZyZuSS4u0zjbs9RoKw@mail.gmail.com>
 <20201006092532.GU6642@arm.com> <CAMe9rOq_nKa6xjHju3kVZephTiO+jEW3PqxgAhU9+RdLTo-jgg@mail.gmail.com>
 <20201006152553.GY6642@arm.com> <CAMe9rOpQiPUZMjysPqtyFfmGDtfRapUvzfMOk7X14xZFSQ66Aw@mail.gmail.com>
 <20201006165520.GA6642@arm.com> <CAMe9rOoY5T61uYCXMcEaKxL7NURDpACJ+0rF47HFmosYOvA2aA@mail.gmail.com>
 <20201007104720.GH6642@arm.com> <CAMe9rOq7yoAwT=+JR4nk4yWMGeXza9490YgJYNp4FKfkJRJxtQ@mail.gmail.com>
 <20201007154559.GI6642@arm.com>
In-Reply-To: <20201007154559.GI6642@arm.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 7 Oct 2020 10:43:00 -0700
Message-ID: <CAMe9rOrkeZ7vPvYG6Uf9VX-_V1yaQWm0N7BV_WzL3Pjg52QEOA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86: Improve Minimum Alternate Stack Size
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 7, 2020 at 8:46 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Wed, Oct 07, 2020 at 06:30:03AM -0700, H.J. Lu wrote:
> > On Wed, Oct 7, 2020 at 3:47 AM Dave Martin <Dave.Martin@arm.com> wrote:
> > >
> > > On Tue, Oct 06, 2020 at 10:44:14AM -0700, H.J. Lu wrote:
>
> [...]
>
> > > > I updated my glibc patch to add both _SC_MINSIGSTKSZ and _SC_SIGSTKSZ.
> > > > _SC_MINSIGSTKSZ is  the minimum signal stack size from AT_MINSIGSTKSZ,
> > > > which is the signal frame size used by kernel, and _SC_SIGSTKSZ is the value
> > > > of sysconf (_SC_MINSIGSTKSZ) + 6KB for user application.
> > >
> > > Can I suggest sysconf (_SC_MINSIGSTKSZ) * 4 instead?
> >
> > Done.
>
> OK.  I was prepared to have to argue my case a bit more, but if you
> think this is OK then I will stop arguing ;)
>
>
> > > If the arch has more or bigger registers to save in the signal frame,
> > > the chances are that they're going to get saved in some userspace stack
> > > frames too.  So I suspect that the user signal handler stack usage may
> > > scale up to some extent rather than being a constant.
> > >
> > >
> > > To help people migrate without unpleasant surprises, I also figured it
> > > would be a good idea to make sure that sysconf (_SC_MINSIGSTKSZ) >=
> > > legacy MINSIGSTKSZ, and sysconf (_SC_SIGSTKSZ) >= legacy SIGSTKSZ.
> > > This should makes it safer to use sysconf (_SC_MINSIGSTKSZ) as a
> > > drop-in replacement for MINSIGSTKSZ, etc.
> > >
> > > (To explain: AT_MINSIGSTKSZ may actually be < MINSIGSTKSZ on AArch64.
> > > My idea was that sysconf () should hide this surprise, but people who
> > > really want to know the kernel value would tolerate some
> > > nonportability and read AT_MINSIGSTKSZ directly.)
> > >
> > >
> > > So then:
> > >
> > >         kernel_minsigstksz = getauxval(AT_MINSIGSTKSZ);
> > >         minsigstksz = LEGACY_MINSIGSTKSZ;
> > >         if (kernel_minsigstksz > minsigstksz)
> > >                 minsistksz = kernel_minsigstksz;
> > >
> > >         sigstksz = LEGACY_SIGSTKSZ;
> > >         if (minsigstksz * 4 > sigstksz)
> > >                 sigstksz = minsigstksz * 4;
> >
> > I updated users/hjl/AT_MINSIGSTKSZ branch with
> >
> > +@item _SC_MINSIGSTKSZ
> > +@standards{GNU, unistd.h}
>
> Can we specify these more agressively now?
>
> > +Inquire about the signal stack size used by the kernel.
>
> I think we've already concluded that this should included all mandatory
> overheads, including those imposed by the compiler and glibc?
>
> e.g.:
>
> --8<--
>
> The returned value is the minimum number of bytes of free stack space
> required in order to gurantee successful, non-nested handling of a
> single signal whose handler is an empty function.
>
> -->8--
>
> > +
> > +@item _SC_SIGSTKSZ
> > +@standards{GNU, unistd.h}
> > +Inquire about the default signal stack size for a signal handler.
>
> Similarly:
>
> --8<--
>
> The returned value is the suggested minimum number of bytes of stack
> space required for a signal stack.
>
> This is not guaranteed to be enough for any specific purpose other than
> the invocation of a single, non-nested, empty handler, but nonetheless
> should be enough for basic scenarios involving simple signal handlers
> and very low levels of signal nesting (say, 2 or 3 levels at the very
> most).
>
> This value is provided for developer convenience and to ease migration
> from the legacy SIGSTKSZ constant.  Programs requiring stronger
> guarantees should avoid using it if at all possible.
>
> -->8--

Done.

>
> If these descriptions are too wordy, we might want to move some of it
> out to signal.texi, though.
>
> >
> >     case _SC_MINSIGSTKSZ:
> >       assert (GLRO(dl_minsigstacksize) != 0);
> >       return GLRO(dl_minsigstacksize);
> >
> >     case _SC_SIGSTKSZ:
> >       {
> >         /* Return MAX (MINSIGSTKSZ, sysconf (_SC_MINSIGSTKSZ)) * 4.  */
> >         long int minsigstacksize = GLRO(dl_minsigstacksize);
> >         _Static_assert (__builtin_constant_p (MINSIGSTKSZ),
> >                         "MINSIGSTKSZ is constant");
> >         if (minsigstacksize < MINSIGSTKSZ)
> >           minsigstacksize = MINSIGSTKSZ;
> >         return minsigstacksize * 4;
> >       }
> >
> > >
> > > (Or something like that, unless the architecture provides its own
> > > definitions.  ia64's MINSIGSTKSZ is enormous, so it probably doesn't
> > > want this.)
> > >
> > >
> > > Also: should all these values be rounded up to a multiple of the
> > > architecture's preferred stack alignment?
> >
> > Kernel should provide a properly aligned AT_MINSIGSTKSZ.
>
> OK.  Can you comment on Chang S. Bae's series?  I wasn't sure that the
> proposal produces an aligned value for AT_MINSIGSTKSZ on x86, but maybe
> I just worked it out wrong.

In Linux kernel, the signal frame data is composed of the following areas
and laid out as:
     ------------------------------
     | alignment padding          |
     ------------------------------
     | xsave buffer               |  <<<<<<< This must be 64 byte aligned
     ------------------------------
     | fsave header (32-bit only) |
     ------------------------------
     | siginfo + ucontext         |
     ------------------------------

In order to get the proper alignment for xsave buffer, the signal stake
size should be rounded up to 64 byte aligned.  In glibc, I have

 /* Size of xsave buffer.  */
  unsigned int sigframe_size = ebx;
if (64 bit)
  /* NB: sizeof(struct rt_sigframe) in Linux kernel.  */
  sigframe_size += 440;
else
  /* NB: sizeof(struct sigframe_ia32) + sizeof(struct fregs_state)) in
     Linux kernel.  */
  sigframe_size += 736 + 112;
endif

  /* Round up to 64-byte aligned.  */
  sigframe_size = ALIGN_UP (sigframe_size, 64);

  GLRO(dl_minsigstacksize) = sigframe_size;

Kernel should do something similar.

>
> > > Should the preferred stack alignment also be exposed through sysconf?
> > > Portable code otherwise has no way to know this, though if the
> > > preferred alignment is <= the minimum malloc()/alloca() alignment then
> > > this is generally not an issue.)
> >
> > Good question.  But it is orthogonal to the signal stack size issue.
>
> Ack.
>
> There are various other brokennesses around this area, such as the fact
> that the register data may now run off the end of the mcontext_t object
> that is supposed to contain it.  Ideally we should fork ucontext_t or
> mcontext_t into two types, one for the ucontext API and one for the
> signal API (which are anyway highly incompatible with each other).
>
> If this stuff is addressed, I guess we could bundle it under a more
> general feature test macro.  But it's probably best to nail down this
> series in something like its current form first.

Agreed.

>
> I'll follow up on libc-alpha with a wishlist, but that will be a
> separate conversation...
>
> [...]
>
> Cheers
> ---Dave



-- 
H.J.
