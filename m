Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131492CA9CA
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 18:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391992AbgLARf2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 12:35:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387494AbgLARf2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 12:35:28 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 386D2221E2
        for <linux-arch@vger.kernel.org>; Tue,  1 Dec 2020 17:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606844087;
        bh=HPHXfa9WzujbQ8iqtPTqDoLuYdFQl9v40MfbtTjD2js=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n1i1E8GJo0iTC189ZlegWaBlJ6H1QCid3nRy3CFE4fQTeCUghXsuaTCrxyHKQAnv+
         BNUT9wbtAIY8TTVRxm0W902uc5RbXbaa08ODt4/z6IZxg3n3JrKN4KPSHq6HqQ4iu+
         rHvPmteA1xsB24l2icXxub8y+VpkvM/uVfReFNcw=
Received: by mail-wr1-f51.google.com with SMTP id s8so3892342wrw.10
        for <linux-arch@vger.kernel.org>; Tue, 01 Dec 2020 09:34:47 -0800 (PST)
X-Gm-Message-State: AOAM531YlYv4BBm8WeLkEWPPm/L+LBTFS8Ot7TH20J7ElcIj0wQdqVvh
        RxJfNPxMQ5Z+o5Lc2qiWu4KpfSwFCsqg7oX+XbE7Xw==
X-Google-Smtp-Source: ABdhPJw8y6w4ou9QZi8IShhdrcmwfd3vGNGR+wV6ts/nuDOKQH75DoRa7o/dcigahIsgfmC4IpigZhKxAGePUDmmAUc=
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr5214512wro.184.1606844085619;
 Tue, 01 Dec 2020 09:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20201130223059.101286-1-brgerst@gmail.com> <CALCETrWZ5eH=0Rjd-vBFRtk-tFQ3tN8_rReaKdVbSm78PFQ7_g@mail.gmail.com>
In-Reply-To: <CALCETrWZ5eH=0Rjd-vBFRtk-tFQ3tN8_rReaKdVbSm78PFQ7_g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 1 Dec 2020 09:34:32 -0800
X-Gmail-Original-Message-ID: <CALCETrWbEvD4SO4GosJyeCmaT2BFwX8Xy+EF_D0x91np3k9OaA@mail.gmail.com>
Message-ID: <CALCETrWbEvD4SO4GosJyeCmaT2BFwX8Xy+EF_D0x91np3k9OaA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Fix sys_fanotify_mark() on native x86-32
To:     Andy Lutomirski <luto@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        =?UTF-8?Q?Pawe=C5=82_Jasiak?= <pawel@jasiak.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 1, 2020 at 9:23 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, Nov 30, 2020 at 2:31 PM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > Commit 121b32a58a3a converted native x86-32 which take 64-bit arguments=
 to
> > use the compat handlers to allow conversion to passing args via pt_regs=
.
> > sys_fanotify_mark() was however missed, as it has a general compat hand=
ler.
> > Add a config option that will use the syscall wrapper that takes the sp=
lit
> > args for native 32-bit.
> >
> > Reported-by: Pawe=C5=82 Jasiak <pawel@jasiak.xyz>
> > Fixes: 121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for sysc=
alls taking 64-bit arguments")
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
> >  arch/Kconfig                       |  6 ++++++
> >  arch/x86/Kconfig                   |  1 +
> >  fs/notify/fanotify/fanotify_user.c | 17 +++++++----------
> >  include/linux/syscalls.h           | 24 ++++++++++++++++++++++++
> >  4 files changed, 38 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 090ef3566c56..452cc127c285 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1045,6 +1045,12 @@ config HAVE_STATIC_CALL_INLINE
> >         bool
> >         depends on HAVE_STATIC_CALL
> >
> > +config ARCH_SPLIT_ARG64
> > +       bool
> > +       help
> > +          If a 32-bit architecture requires 64-bit arguments to be spl=
it into
> > +          pairs of 32-bit arguemtns, select this option.
>
> You misspelled arguments.  You might also want to clarify that, for
> 64-bit arches, this means that compat syscalls split their arguments.

No, that's backwards.  Maybe it should be depends !64BIT instead.

But I'm really quite confused about something: what's special about
x86 here?  Are there really Linux arches (compat or 32-bit native)
that *don't* split arguments like this?  Sure, some arches probably
work the same way that x86 used to in which the compiler did the
splitting by magic for us, but that was always a bit of a kludge.
Could this change maybe be made unconditional?

--Andy

>
> Aside from that:
>
> Acked-by: Andy Lutomirski <luto@kernel.org>
