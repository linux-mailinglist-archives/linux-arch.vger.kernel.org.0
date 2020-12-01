Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9987B2CABA7
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 20:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgLATUf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 14:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLATUe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Dec 2020 14:20:34 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D36C0613D4;
        Tue,  1 Dec 2020 11:19:54 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id t13so2810838ilp.2;
        Tue, 01 Dec 2020 11:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sr08HjmDbgx5MNr2x8MaTWBjl+K7jFaDDL1XeuJD/Zw=;
        b=QqzlkzabXHudadx7BxMEpiicwlwqBNFvF0SjIQBXIB/WaD+9sZ62650yyJeR8dmNQF
         SQ4ia7+zDGY/cNEgRRnsz3AD8dQp9HzxLscPOAxZfEqu0sAk+vD5yGA+fWkqco3RVFal
         6u+19dgJic2c+t6NMoucqruTlny3TSZG5Ls42Fp0zH4GoHFnVfdOZV3M/U222fvtCDSP
         vhG14yBBZDg/TSPSE2XCY25KG7fxeDY0M8Tv4RkzUI8ze4A5h8A6pyiuGFqc18Q9pmZ8
         FWTcWz6ZAgFOQP6F9TukvvjI9irIU4iteDA3S8A0ZHM5kbcOODwTkWbb1j/DFrtn/0Y0
         Zo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sr08HjmDbgx5MNr2x8MaTWBjl+K7jFaDDL1XeuJD/Zw=;
        b=E7gBIxRIdQioVHQ+HbqbKThrN3y6AM/UPYq44KXuSX6/h/yjxvQsyPRfiO6FA5i+DY
         Z/uf4bzxtcZJLrcRtUmpKRpx70MZRzbHDqlFRCYN4tphIsf7sxoY9Ac3qU6cbse+o63x
         nzen4R/im6AHRYmlOHp8dxFg51TpHzKy/O6b5wNFDFU3lqBUtv4I56kNl93nIilxDavq
         jm1gjABG1/0g9RiqHPCPVtVm3XyhzOm5dF9tRmQEkFEMCSpYoyti68RgNGu1sbtdbmGY
         PuNHmGzFFYIxCIxy1EVcr/naorA32xvVDps1hm5nb5hgakNpBHCqoE/qJphyF1UzYaMm
         FHDA==
X-Gm-Message-State: AOAM532lXmv8aFm73/iAoMaCHjSz5Xjh+/2mYX9CmUojZgOBFFqvu5v/
        ki/4mAjUoy3pkhghfbXKc8u7rni0eN0oEEnQkw==
X-Google-Smtp-Source: ABdhPJyrYBBBi63cAKcNX+DJ5Q6/bcrpP5lpHNXwEG/xbY4sHCGjvdO3jAER/0grorkaPMnRIwTk3MPftalHG8X88o0=
X-Received: by 2002:a92:84c1:: with SMTP id y62mr3990531ilk.191.1606850393795;
 Tue, 01 Dec 2020 11:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20201130223059.101286-1-brgerst@gmail.com> <CALCETrWZ5eH=0Rjd-vBFRtk-tFQ3tN8_rReaKdVbSm78PFQ7_g@mail.gmail.com>
 <CALCETrWbEvD4SO4GosJyeCmaT2BFwX8Xy+EF_D0x91np3k9OaA@mail.gmail.com>
In-Reply-To: <CALCETrWbEvD4SO4GosJyeCmaT2BFwX8Xy+EF_D0x91np3k9OaA@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 1 Dec 2020 14:19:41 -0500
Message-ID: <CAMzpN2jLQ2PAjjhZ7U-HGyH7RYaY_8G-HAv68-fMBosHBixDXw@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Fix sys_fanotify_mark() on native x86-32
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        =?UTF-8?Q?Pawe=C5=82_Jasiak?= <pawel@jasiak.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 1, 2020 at 12:34 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Tue, Dec 1, 2020 at 9:23 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Mon, Nov 30, 2020 at 2:31 PM Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > > Commit 121b32a58a3a converted native x86-32 which take 64-bit argumen=
ts to
> > > use the compat handlers to allow conversion to passing args via pt_re=
gs.
> > > sys_fanotify_mark() was however missed, as it has a general compat ha=
ndler.
> > > Add a config option that will use the syscall wrapper that takes the =
split
> > > args for native 32-bit.
> > >
> > > Reported-by: Pawe=C5=82 Jasiak <pawel@jasiak.xyz>
> > > Fixes: 121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for sy=
scalls taking 64-bit arguments")
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
> > > +          If a 32-bit architecture requires 64-bit arguments to be s=
plit into
> > > +          pairs of 32-bit arguemtns, select this option.
> >
> > You misspelled arguments.  You might also want to clarify that, for
> > 64-bit arches, this means that compat syscalls split their arguments.
>
> No, that's backwards.  Maybe it should be depends !64BIT instead.
>
> But I'm really quite confused about something: what's special about
> x86 here?

x86 is special because of the pt_regs-based syscall interface.  It
would be nice to get all arches to that point eventually.

> Are there really Linux arches (compat or 32-bit native)
> that *don't* split arguments like this?  Sure, some arches probably
> work the same way that x86 used to in which the compiler did the
> splitting by magic for us, but that was always a bit of a kludge.
> Could this change maybe be made unconditional?

It probably can be made unconditional.  That will take some research
on which arches have the implicit alignment requirement.  From looking
at the existing compat handlers, ARM, MIPS, and PowerPC 32-bit ABIs
need alignment.

--
Brian Gerst
