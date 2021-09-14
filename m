Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD0440A282
	for <lists+linux-arch@lfdr.de>; Tue, 14 Sep 2021 03:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhINBcF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 21:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhINBcE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Sep 2021 21:32:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC9BC061574;
        Mon, 13 Sep 2021 18:30:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id k24so11147425pgh.8;
        Mon, 13 Sep 2021 18:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Thaf/ImXtKQqzGermZZDUQcf5wJAJSh5177RgKZjfto=;
        b=Jiii65vXTIz1M1sab0YUlB/1mLUAhA0lUt34zgaxrRPO8YpgRW341zmNub1oevjjv6
         UydyC42tuELbseRzw2TabVuDYed+6lLx8bEj64hgldjuQCvURWq5mFfr0PCcZU1tSq+w
         NIL6ECtu+nfK3gEKsqes5LpupJneRNL7XeObgqdaVCQX/oUc6ZzhNrvwClQwB6LuSAxE
         fnAqzjWav67HM1KM/m1LPKHiOWuMEJYoccvV+kBHWg6fwjIvKOvwMristOWtC2TtwdoO
         CoDfWwE0BB4MTDGIRPXMlDD5jpx3rhNhS7oFwMg/+Ck2XdZYmEWhrsewKrcz1t+cIdL2
         rebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Thaf/ImXtKQqzGermZZDUQcf5wJAJSh5177RgKZjfto=;
        b=q4dIW06DyCIKFc+s7X306PKLfdt3hD1f2aBp1iSMIR1HsGgLOyZ1u1bxJtQrCediOm
         nlqj+CPgzuSe+DEhg71GU6tGb4kkFWUixK0HnDxvvXsDcpBMpFP6LS2kmzC5NfDFgxRq
         pYdTBYBMrELO0kQVOVowsRYydGanYr/0SwWXaZTeWJ8vJS+i5YVsAyI+k+h/xv+Ly+R9
         3V5HFEFWFSmmo6kSiQ7keikhz8lg2rF2O0jlXEDGGxsidcGcVQPj0uOeV9mOgcapZPFO
         bVRd6jiXh/yi2d6C6DoxcRaL7ZMxywZ1Usj7KmOxAVRYi8HgmC7g6RqAE8aBOydnAzIi
         G3/A==
X-Gm-Message-State: AOAM532bjNhRxaKIxdl+/vVHQJExmK0Mz+ASHZbBrQ5EGn7pEFKQx5d4
        rPhM1NA1Z2F+s3c4quUXz10X48Fc/LLHURZ6GZ8=
X-Google-Smtp-Source: ABdhPJwxaC4dCRUvrRS/PfGULpz4gvff7nS4pMJDIuuSfO0YfM7zlHHiN8uLOadbwjWM2GXpf0iabb3nL4x6/E1R0Lg=
X-Received: by 2002:a63:704f:: with SMTP id a15mr13599856pgn.120.1631583047659;
 Mon, 13 Sep 2021 18:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1630929519.git.chenfeiyang@loongson.cn> <ec14e242a73227bf5314bbc1b585919500e6fbc7.1630929519.git.chenfeiyang@loongson.cn>
 <59feb382-a4ab-c94e-8f71-10ad0c0ceceb@flygoat.com> <CACWXhKnA24KuJo33+OitPQVRRd3g_05DWRC2Dsnm7w8hVyKjNQ@mail.gmail.com>
 <20210908085150.GA5622@alpha.franken.de>
In-Reply-To: <20210908085150.GA5622@alpha.franken.de>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Tue, 14 Sep 2021 09:30:53 +0800
Message-ID: <CACWXhK=gud_vk5g7cLA_2P1=57mWfiJxTYpw2EPf=NNgbdR1Tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mips: convert syscall to generic entry
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, arnd@arndb.de,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        chenhuacai@kernel.org, Yanteng Si <siyanteng@loongson.cn>,
        Zhou Yanjie <zhouyu@wanyeetech.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 8 Sept 2021 at 17:28, Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Wed, Sep 08, 2021 at 10:08:47AM +0800, =E9=99=88=E9=A3=9E=E6=89=AC wro=
te:
> > On Tue, 7 Sept 2021 at 21:49, Jiaxun Yang <jiaxun.yang@flygoat.com> wro=
te:
> > >
> > >
> > > =E5=9C=A8 2021/9/7 14:16, FreeFlyingSheep =E5=86=99=E9=81=93:
> > > > From: Feiyang Chen <chenfeiyang@loongson.cn>
> > > >
> > > > Convert mips syscall to use the generic entry infrastructure from
> > > > kernel/entry/*.
> > > >
> > > > There are a few special things on mips:
> > > >
> > > > - There is one type of syscall on mips32 (scall32-o32) and three ty=
pes
> > > > of syscalls on mips64 (scall64-o32, scall64-n32 and scall64-n64). N=
ow
> > > > convert to C code to handle different types of syscalls.
> > > >
> > > > - For some special syscalls (e.g. fork, clone, clone3 and sysmips),
> > > > save_static_function() wrapper is used to save static registers. No=
w
> > > > SAVE_STATIC is used in handle_sys before calling do_syscall(), so t=
he
> > > > save_static_function() wrapper can be removed.
> > > >
> > > > - For sigreturn/rt_sigreturn and sysmips, inline assembly is used t=
o
> > > > jump to syscall_exit directly for skipping setting the error flag a=
nd
> > > > restoring all registers. Now use regs->regs[27] to mark whether to
> > > > handle the error flag and always restore all registers in handle_sy=
s,
> > > > so these functions can return normally as other architecture.
> > >
> > > Hmm, that would give us overhead of register context on these syscall=
s.
> > >
> > > I guess it's worthy?
> > >
> >
> > Hi, Jiaxun,
> >
> > Saving and restoring registers against different system calls can be
> > difficult due to the use of generic entry.
> > To avoid a lot of duplicate code, I think the overhead is worth it.
>
> could you please provide numbers for that ? This code still runs
> on low end MIPS CPUs for which overhead might mean a different
> ballpark than some highend Loongson CPUs.

Hi, Thomas, Jiaxun, Yanjie, Nikolaus,

Thank you for your help. The impact on performance seems somewhat
significant, I will make improvements in the v2 of the patchset.

Thanks,
Feiyang

>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]
