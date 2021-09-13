Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EEE4082A2
	for <lists+linux-arch@lfdr.de>; Mon, 13 Sep 2021 03:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbhIMBgu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Sep 2021 21:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236880AbhIMBgq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Sep 2021 21:36:46 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCF9C061574;
        Sun, 12 Sep 2021 18:35:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j6so7027272pfa.4;
        Sun, 12 Sep 2021 18:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YimP3uTujLEfLS4V5/gygy/tyLctF4j1RQJTNK7Vl4c=;
        b=e7Nxt9DfcH/FEZ3w+tLCrB9sOkcbqYRfoZoPruB57iB377x2p03rzGEoIoBQx0SSUx
         aqu3iWT4J/DamUpHTTmrxIZIPGGqh/AjxsgeEcR1/oKTzFrGc3fFE7rVWFZKrO2DoFyX
         dNGFYDKzdOEcU9HrVY3kwRe1tULDVRQZ39LJ246bCEx3yEefq5Rag04Vb0CiWFp7hKuL
         KoNb+8+Z30+lcD1W1pZ0RqVv3v/lOrLYfRbgDwNX08KReTvKEAxYlohTH+CFHG+aU+BO
         miUyBMVN3/Hw5l/wc1xR7Z+WE7F2yua3xuO/23/h1Z94/xxm+7twlQStSYvF4Pz5o0UC
         NG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YimP3uTujLEfLS4V5/gygy/tyLctF4j1RQJTNK7Vl4c=;
        b=7ug6OPnb0/3d6WnALPfSa2RnyrfN/OMblEk7L8jBfLNOd2obtWqeW01tzMFVemnPUT
         DWu+8+FVnP8nXU7KndBQ1jtQ4ZIU72GFu+7P0VMinAL2J3udTYDWryLdK7F3xB1/EYhk
         /Q7/VH4RsNsWvkaOTPXbO7hX85V/T7KZEHqAdy+oDCP4Kdj0TBpOiybtJfxsfTr0y1g4
         ZBzmbNOOySwZ/k7/BnDpt16q6HQ3Z0VMtZG6+M53Q/SwX+6/7IeRbb8nGbNkBw4vEs1+
         EpG/FVIY5Vx5nyE5Gkyk53/Q/Itiz+hZTTArMk660DCoa7NQD7Ys0CIk8MlLCqKEhg8T
         EkLw==
X-Gm-Message-State: AOAM532kK9wu2MpBFS4PHZVjLXdJ2N9Lk3cURDGMM+FR0MFAp7S/rdiH
        vSSd4fj6iUB1aO5Rtz06ZoLWsQ8AMPDqe3A5ess=
X-Google-Smtp-Source: ABdhPJwgXF4Aw2StoMw7VtvJ0FSad5KRA653Hx9ViBXBplncYq7kVCgNeG/ewMcxhVlYuGkJMJeQZr1N6i0No5XAHTE=
X-Received: by 2002:a05:6a00:2787:b0:43d:e275:7e1a with SMTP id
 bd7-20020a056a00278700b0043de2757e1amr474104pfb.49.1631496930882; Sun, 12 Sep
 2021 18:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1630929519.git.chenfeiyang@loongson.cn> <ec14e242a73227bf5314bbc1b585919500e6fbc7.1630929519.git.chenfeiyang@loongson.cn>
 <59feb382-a4ab-c94e-8f71-10ad0c0ceceb@flygoat.com> <CACWXhKnA24KuJo33+OitPQVRRd3g_05DWRC2Dsnm7w8hVyKjNQ@mail.gmail.com>
 <20210908085150.GA5622@alpha.franken.de>
In-Reply-To: <20210908085150.GA5622@alpha.franken.de>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Mon, 13 Sep 2021 09:35:19 +0800
Message-ID: <CAMU9jJo66J_53pjdvH-a4KD_ar6L_MPYnPpT8cp0UhOXp-Gpyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mips: convert syscall to generic entry
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     =?UTF-8?B?6ZmI6aOe5oms?= <chris.chenfeiyang@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, arnd@arndb.de,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thomas Bogendoerfer <tsbogend@alpha.franken.de> =E4=BA=8E2021=E5=B9=B49=E6=
=9C=888=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:36=E5=86=99=E9=81=93=
=EF=BC=9A
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
It shows ~2% regression for UnixBench on LOONGSON 3a4000 (a1901).

Thanks,

Yanteng
