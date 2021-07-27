Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD223D6BF7
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 04:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhG0Btx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 21:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbhG0Btx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 21:49:53 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3190BC061757
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 19:30:20 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id y4so10868624ilp.0
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 19:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1QMxq6kHwnSIKIRv8El3R+NXS9NjH8nYA/2cpYbey7I=;
        b=hYI9yNsCElIjLUuRcfSTgwhUGLX0gG4IzjDycgvXh2+HHHFzTDC91dUpbsRB3wSMn+
         KYtThlFQ9NAiZ7cSoz8iAvwmPmSaO/U1Fxg3byU1x5nFfGQ7WhS6XlXUNSJoeE+Xl+er
         OmGyyxYLWp9zoTMNqILt7J+28cheUVO+ya5G/Y+qqJvZoGOGF0XGP3tqfxvK0FFFxLDP
         R3cYsyIlMuB2V5bTNaOG7dPnRrzDNecRmMrs973VM/QeqT3VlcHjSxs6LBZhHjRu1d6F
         iYtiMJ+kJ35i5z1NoxjdjdgD9ptcb7rbBu14snGmjpB1qQ8oOQ+OQSk4lc2XrbKp2gfV
         I7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1QMxq6kHwnSIKIRv8El3R+NXS9NjH8nYA/2cpYbey7I=;
        b=j/Mtbj4rTShswDXdChkfCxFZXZq2dnoISMIK0yuIA/fHIEtePpEzzDF9ci4oQpON8P
         13BDldQcw3xQRX+g1R7xvwE4KzO62RECMqodBT1dLc52OKyrHe7r1d1OMVZ948eq3NC9
         rUmGIJqWB/Jm2l9TH/n0FORW/aI3KZx5eVWzy/3nYvGfCYIz8Cuu7VuuW6pIE/6+NWs4
         2awASKsIZcdMPb/IcEgQZ86zuXrxwkip4Y7E5hCzP37di0pi7+76Y8/9c8HhlajcbpdD
         jIZKuy3GXQ/wX1yhh67HAyIZjgO8BiH4hS2+V/Pe3AnsYXcHfyeHGq4WBcsY7wC9cFXB
         sRzQ==
X-Gm-Message-State: AOAM533ctvY8+ag8PgoijgIbC+WplufAcTQFi5xDdsRcum3kGhWPoRoy
        fkyu8cfkVbWDWTMkJRChn1s=
X-Google-Smtp-Source: ABdhPJz5O43XrOh5vFYMygc2RFGICkY2G69GuuorJOO7LjJiiwNLjyp03e89ZOUupmq6eJlyXnvKxw==
X-Received: by 2002:a92:b50d:: with SMTP id f13mr15276852ile.253.1627353019667;
        Mon, 26 Jul 2021 19:30:19 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id l18sm1069538ioc.13.2021.07.26.19.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 19:30:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0A6F027C0054;
        Mon, 26 Jul 2021 22:30:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 26 Jul 2021 22:30:18 -0400
X-ME-Sender: <xms:t2__YJq2nlo4PR72F-oZ4aQG5bPJdmtVXX9pYxKb-GZRvYS-5ejEvg>
    <xme:t2__YLo3kFfoETer4xh9RHvKk-GT1d5PoakwOKjEp6I99steDjLE1ahU4hCO1gRO5
    y__LNbL4inTTBIqag>
X-ME-Received: <xmr:t2__YGMuUX0VzrEYBfNkypIeDYAXwzIxW6u6ofrdZH3oPfw3vpoHllUomOIdQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeeigdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevieejtdfhieejfeduheehvdevgedugeethefggfdtvdeutdevgeetvddvfeeg
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:t2__YE4eZS14ioCXAATm9yytnhhnpYUCQijvZw_r2nOUOr5nS035TQ>
    <xmx:t2__YI6_c_2V_15cnjtmvpWVx2Uthig3CWRErP_zVpSEqkV4ZHzJzQ>
    <xmx:t2__YMi_MCQFLsOjJuoDe_PXoFLbyNALW_fcqAcQ-MIt4geKCPeokg>
    <xmx:um__YIyxnspXmapG7H2T4PR3k1RTVytH2jUtOUKeGAjfXCUl8cgYT0LCT98>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 22:30:15 -0400 (EDT)
Date:   Tue, 27 Jul 2021 10:29:59 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Waiman Long <llong@redhat.com>, Huacai Chen <chenhuacai@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
Message-ID: <YP9vp8/acj9TpwyZ@boqun-archlinux>
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux>
 <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
 <YP7q5GBweaeWgvcs@boqun-archlinux>
 <77e83baf-030c-1332-609c-6d3f01bd422a@redhat.com>
 <CAJF2gTQcmN0TdX2dMT5mqKBp2HJ15_7KzDnaM5VyHaCArrnfGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQcmN0TdX2dMT5mqKBp2HJ15_7KzDnaM5VyHaCArrnfGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 09:27:51AM +0800, Guo Ren wrote:
> On Tue, Jul 27, 2021 at 5:21 AM Waiman Long <llong@redhat.com> wrote:
> >
> > On 7/26/21 1:03 PM, Boqun Feng wrote:
> > > On Tue, Jul 27, 2021 at 12:41:34AM +0800, Guo Ren wrote:
> > >> On Mon, Jul 26, 2021 at 6:39 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > >>> On Mon, Jul 26, 2021 at 04:56:49PM +0800, Huacai Chen wrote:
> > >>>> Hi, Geert,
> > >>>>
> > >>>> On Mon, Jul 26, 2021 at 4:36 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >>>>> Hi Huacai,
> > >>>>>
> > >>>>> On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >>>>>> Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which means arch
> > >>>>>> has hardware sub-word xchg/cmpxchg support. This option will be used as
> > >>>>>> an indicator to select the bit-field definition in the qspinlock data
> > >>>>>> structure.
> > >>>>>>
> > >>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > >>>>> Thanks for your patch!
> > >>>>>
> > >>>>>> --- a/arch/Kconfig
> > >>>>>> +++ b/arch/Kconfig
> > >>>>>> @@ -228,6 +228,10 @@ config ARCH_HAS_FORTIFY_SOURCE
> > >>>>>>            An architecture should select this when it can successfully
> > >>>>>>            build and run with CONFIG_FORTIFY_SOURCE.
> > >>>>>>
> > >>>>>> +# Select if arch has hardware sub-word xchg/cmpxchg support
> > >>>>>> +config ARCH_HAS_HW_XCHG_SMALL
> > >>>>> What do you mean by "hardware"?
> > >>>>> Does a software fallback count?
> > >>>> This new option is supposed as an indicator to select bit-field
> > >>>> definition of qspinlock, software fallback is not helpful in this
> > >>>> case.
> > >>>>
> > >>> I don't think this is true. IIUC, the rationale of the config is that
> > >>> for some architectures, since the architectural cmpxchg doesn't provide
> > >>> forward-progress guarantee then using cmpxchg of machine-word to
> > >>> implement xchg{8,16}() may cause livelock, therefore these architectures
> > >>> don't want to provide xchg{8,16}(), as a result they cannot work with
> > >>> qspinlock when _Q_PENDING_BITS is 8.
> > >>>
> > >>> So as long as an architecture can provide and has already provided an
> > >>> implementation of xchg{8,16}() which guarantee forward-progress (even
> > >>> though the implementation is using a machine-word size cmpxchg), the
> > >>> architecture doesn't need to select ARCH_HAS_HW_XCHG_SMALL.
> > >> Seems only atomic could provide forward progress, isn't it? And lr/sc
> > >> couldn't implement xchg/cmpxchg primitive properly.
> > >>
> > > I'm missing you point here, a) ll/sc can provide forward progress and b)
> > > ll/sc instructions are used to implement xchg/cmpxchg (see ARM64 and
> > > PPC).
> > >
> > >> How to make CPU guarantee  "load + cmpxchg" forward-progress? Fusion
> > >> these instructions and lock the snoop channel?
> > >> Maybe hardware guys would think that it's easier to implement cas +
> > >> dcas + amo(short & byte).
> > >>
> > > Please note that if _Q_PENDING_BITS == 1, then the xchg_tail() is
> > > implemented as a "load + cmpxchg", so if "load + cmpxchg" implementation
> > > of xchg16() doesn't provide forward-progress in an architecture, neither
> > > does xchg_tail().
> >
> > Agreed. The xchg_tail() for the "_Q_PENDING_BITS == 1" case is a
> > software emulation of xchg16(). Pure software emulation like that does
> > not provide forward progress guarantee. This is usually not a big
> > problem for non-RT kernel for which occasional long latency is
> > acceptable, but it is not good for RT kernel.
> "How to implement xchg_tail" shouldn't force with _Q_PENDING_BITS, but
> the arch could choose.

I actually agree with this part, but this patchset failed to provide
enough evidences on why we should choose xchg_tail() implementation
based on whether hardware has xchg16, more precisely, for an archtecture
which doesn't have a hardware xchg16, why cmpxchg emulated xchg16() is
worse than a "load+cmpxchg) implemeneted xchg_tail()? If it's a
performance reason, please show some numbers.

In fact, why don't you introduce a ARCH_QSPINLOCK_USE_GENERIC_XCHG_TAIL,
and only select it for csky and risc-v, and let other archs choose to
select or it themselves? FWIW, qspinlock code looks like something
below with this config:

 #if (CONFIG_NR_CPUS < (1U << 14)) && !defined(CONFIG_ARCH_QSPINLOCK_USE_GENERIC_XCHG_TAIL)
 #define _Q_PENDING_BITS                8
 #else
 #define _Q_PENDING_BITS                1

Just my two cents.

Regards,
Boqun

> But this will raise another topic, is qspinlock suitable for these
> arches? Maybe you've answered here: "for the non-RT kernel, Yes".
> 
> I remember you are the person who doesn't against the patch I've sent [1]:
> [1] https://lore.kernel.org/linux-riscv/b6466a43-6fb3-dc47-e0ef-d493e0930ab2@redhat.com/
> 
> >
> > Cheers,
> > Longman
> >
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
