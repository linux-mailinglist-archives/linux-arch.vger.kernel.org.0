Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B972CAB43
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 20:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgLATBj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 14:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgLATBj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 14:01:39 -0500
Received: from gaia (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD93720643;
        Tue,  1 Dec 2020 19:00:54 +0000 (UTC)
Date:   Tue, 1 Dec 2020 19:00:52 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] fanotify: Fix sys_fanotify_mark() on native x86-32
Message-ID: <20201201190051.GB2502@gaia>
References: <20201130223059.101286-1-brgerst@gmail.com>
 <CALCETrWZ5eH=0Rjd-vBFRtk-tFQ3tN8_rReaKdVbSm78PFQ7_g@mail.gmail.com>
 <CALCETrWbEvD4SO4GosJyeCmaT2BFwX8Xy+EF_D0x91np3k9OaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWbEvD4SO4GosJyeCmaT2BFwX8Xy+EF_D0x91np3k9OaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 01, 2020 at 09:34:32AM -0800, Andy Lutomirski wrote:
> On Tue, Dec 1, 2020 at 9:23 AM Andy Lutomirski <luto@kernel.org> wrote:
> > On Mon, Nov 30, 2020 at 2:31 PM Brian Gerst <brgerst@gmail.com> wrote:
> > > Commit 121b32a58a3a converted native x86-32 which take 64-bit arguments to
> > > use the compat handlers to allow conversion to passing args via pt_regs.
> > > sys_fanotify_mark() was however missed, as it has a general compat handler.
> > > Add a config option that will use the syscall wrapper that takes the split
> > > args for native 32-bit.
> > >
> > > Reported-by: Paweł Jasiak <pawel@jasiak.xyz>
> > > Fixes: 121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for syscalls taking 64-bit arguments")
> > > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > > ---
> > >  arch/Kconfig                       |  6 ++++++
> > >  arch/x86/Kconfig                   |  1 +
> > >  fs/notify/fanotify/fanotify_user.c | 17 +++++++----------
> > >  include/linux/syscalls.h           | 24 ++++++++++++++++++++++++
> > >  4 files changed, 38 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > index 090ef3566c56..452cc127c285 100644
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -1045,6 +1045,12 @@ config HAVE_STATIC_CALL_INLINE
> > >         bool
> > >         depends on HAVE_STATIC_CALL
> > >
> > > +config ARCH_SPLIT_ARG64
> > > +       bool
> > > +       help
> > > +          If a 32-bit architecture requires 64-bit arguments to be split into
> > > +          pairs of 32-bit arguemtns, select this option.
> >
> > You misspelled arguments.  You might also want to clarify that, for
> > 64-bit arches, this means that compat syscalls split their arguments.
> 
> No, that's backwards.  Maybe it should be depends !64BIT instead.
> 
> But I'm really quite confused about something: what's special about
> x86 here?  Are there really Linux arches (compat or 32-bit native)
> that *don't* split arguments like this?  Sure, some arches probably
> work the same way that x86 used to in which the compiler did the
> splitting by magic for us, but that was always a bit of a kludge.

On arm32 we rely on the compiler splitting a 64-bit argument in two
consecutive registers. But I wouldn't say it's a kludge (well, mostly)
as that's part of the arm procedure calling standard. Currently arm32
doesn't pass the syscall arguments through a read from pt_regs, so all
is handled transparently.

On arm64 compat, we need to re-assemble the arguments with some
wrappers explicitly (arch/arm64/kernel/sys32.c) or call the generic
wrapper like in the compat_sys_fanotify_mark() case.

> Could this change maybe be made unconditional?

I think it's fine in this particular case.

I don't think it's valid in general because of the arm (and maybe
others) requirement that the first register of a 64-bit argument is an
even number (IIRC, Russell should know better). If the u64 mask was an
argument before or after the current position, the compiler would have
introduced a pad register but not if the arg is split in two u32.

-- 
Catalin
