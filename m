Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277023D6BAE
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 04:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhG0BUC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 21:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbhG0BUB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 21:20:01 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91825C061757
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 19:00:28 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id o7so9563804ilh.11
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 19:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9q07pyh0VtXb4+vQ8+uD0lHmvQjseG2xufS10wXbiaM=;
        b=ZKsRnSDjZFdetDW+yEF6CTmm2tJE0iBVbO2Lt7MQ8w/BUKClB31jVPIRm0LoqJa9xh
         TIopHB52dFVOcAkM1l/8Gz4Tbld+1VZElBxhHWBbcQsYcP+zRKXuqqS9ntrY5EqQzfOc
         60RGpoxc4LIH6plQJTRb3SmWD3HLkv1cMSE7BO91WRZs/IbhhsfHbk1itqUa32RCdHYr
         pctUqjuiNm8rK7BNxC8cO6UtxKuFzSmZH+MUePbt4D9OFF4z5UomeZG2BWnGvfw/dmts
         JNd8e5JjW44RJsn5GXSXB730nOeUC42eczzdLXhTeOtdD6lwSG857+yE7S0z0j3ebtIl
         6COQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9q07pyh0VtXb4+vQ8+uD0lHmvQjseG2xufS10wXbiaM=;
        b=Uqk9idoiB8HO7gwtqsSVz2q4CfqWZ1JlfLCXN690UVniCpyyhXbtAJWkzYyOPEO1P+
         th0mF3O6AaDmVKKVKCj6ee0k8qSZktIsfWdzWe0fq8L2KyBcnZ4/gXlow6nytCulYzmW
         xkmMq+jTCQRBuHOgM88BE+ZgRiC/CZtJHVT51LmgRI+jDsJ7oD8gcT5u02B7+kJaJoNv
         WQfm0ktirQa90HL4JFgZ5ApfbsvR0zTth6xHFpbW7m6vAB2L/7lqhq6OCynDeQLafLij
         ilfQtI9ht9Ck8HA9Zkj1YI+FGMIDflvcF/n9p+2x15sb1Pbxvv22yXYfeRjxX3yQ2yez
         fWMA==
X-Gm-Message-State: AOAM532ZRKc6O+KbXziiRYKb9kumHMbaNmN46dLSrAqozMCeHS3tWAJK
        aEGs+Xqhywlbrin9crzyATc=
X-Google-Smtp-Source: ABdhPJy9DIw+gkjU8EIgT1SaajsSSQugJh4uN8gVxLaKQ6AmGpmR/7bLaz95aKYvnmxlEx9JOozW9Q==
X-Received: by 2002:a92:d848:: with SMTP id h8mr15282484ilq.282.1627351227953;
        Mon, 26 Jul 2021 19:00:27 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h24sm1143039ioj.32.2021.07.26.19.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 19:00:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id C0F0D27C005B;
        Mon, 26 Jul 2021 22:00:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 26 Jul 2021 22:00:26 -0400
X-ME-Sender: <xms:uGj_YDzvOGsEPNCIMM-QYRHg514HFoxqMVjXFcXCCKuX5K_GlGGAxw>
    <xme:uGj_YLTgc6ljJi-p5uFFqyBLZuiJD46K0fjngfuVSc6sSl4U2EhpYtuxUjinqqRku
    sKojE7XxVf5jMaz4Q>
X-ME-Received: <xmr:uGj_YNW8iHfgH6jM3m9ZKR6RTbFXSkZQrQyuSgbixV2Q4kBkWR-OrA8CgUozmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfeklefhheegffdutddukeetueegudfhiedvudduheeiueeuheeuueetvedu
    uefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:uGj_YNgwH85G3At45Xh0QvgZHlF3rH7d77ChPdb5GsUBpDyj0wb50w>
    <xmx:uGj_YFCgjVxLc6huolR9jcLoj0tUW4dO1hWlyxEMYEwfTpd7FlP1kg>
    <xmx:uGj_YGK--1BhcfMy25HX38lpOrQ_szqrti1hUZTSJpczD54KgCvS7Q>
    <xmx:umj_YJ59o3DQigwiY7iN-LhthhJn1Mz5t7z-CQt4qemyDfXXFdh02dFkREQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 22:00:23 -0400 (EDT)
Date:   Tue, 27 Jul 2021 10:00:07 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Huacai Chen <chenhuacai@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
Message-ID: <YP9op4o0gpDCMQp0@boqun-archlinux>
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux>
 <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
 <YP7q5GBweaeWgvcs@boqun-archlinux>
 <CAJF2gTSZdi_U6we4K7Y0M9XsL++Dppdc4jh-UZFxHR+dqBq6fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTSZdi_U6we4K7Y0M9XsL++Dppdc4jh-UZFxHR+dqBq6fQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 09:07:44AM +0800, Guo Ren wrote:
> On Tue, Jul 27, 2021 at 1:03 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Tue, Jul 27, 2021 at 12:41:34AM +0800, Guo Ren wrote:
> > > On Mon, Jul 26, 2021 at 6:39 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Mon, Jul 26, 2021 at 04:56:49PM +0800, Huacai Chen wrote:
> > > > > Hi, Geert,
> > > > >
> > > > > On Mon, Jul 26, 2021 at 4:36 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > >
> > > > > > Hi Huacai,
> > > > > >
> > > > > > On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > > > > Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which means arch
> > > > > > > has hardware sub-word xchg/cmpxchg support. This option will be used as
> > > > > > > an indicator to select the bit-field definition in the qspinlock data
> > > > > > > structure.
> > > > > > >
> > > > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > >
> > > > > > Thanks for your patch!
> > > > > >
> > > > > > > --- a/arch/Kconfig
> > > > > > > +++ b/arch/Kconfig
> > > > > > > @@ -228,6 +228,10 @@ config ARCH_HAS_FORTIFY_SOURCE
> > > > > > >           An architecture should select this when it can successfully
> > > > > > >           build and run with CONFIG_FORTIFY_SOURCE.
> > > > > > >
> > > > > > > +# Select if arch has hardware sub-word xchg/cmpxchg support
> > > > > > > +config ARCH_HAS_HW_XCHG_SMALL
> > > > > >
> > > > > > What do you mean by "hardware"?
> > > > > > Does a software fallback count?
> > > > > This new option is supposed as an indicator to select bit-field
> > > > > definition of qspinlock, software fallback is not helpful in this
> > > > > case.
> > > > >
> > > >
> > > > I don't think this is true. IIUC, the rationale of the config is that
> > > > for some architectures, since the architectural cmpxchg doesn't provide
> > > > forward-progress guarantee then using cmpxchg of machine-word to
> > > > implement xchg{8,16}() may cause livelock, therefore these architectures
> > > > don't want to provide xchg{8,16}(), as a result they cannot work with
> > > > qspinlock when _Q_PENDING_BITS is 8.
> > > >
> > > > So as long as an architecture can provide and has already provided an
> > > > implementation of xchg{8,16}() which guarantee forward-progress (even
> > > > though the implementation is using a machine-word size cmpxchg), the
> > > > architecture doesn't need to select ARCH_HAS_HW_XCHG_SMALL.
> > > Seems only atomic could provide forward progress, isn't it? And lr/sc
> > > couldn't implement xchg/cmpxchg primitive properly.
> > >
> >
> > I'm missing you point here, a) ll/sc can provide forward progress and b)
> > ll/sc instructions are used to implement xchg/cmpxchg (see ARM64 and
> > PPC).
> I don't think arm64 could provide fwd guarantee with ll/sc, otherwise,
> they wouldn't add ARM64_HAS_LSE_ATOMICS for large systems.
> 
> >
> > > How to make CPU ç  "load + cmpxchg" forward-progress? Fusion
> > > these instructions and lock the snoop channel?
> > > Maybe hardware guys would think that it's easier to implement cas +
> > > dcas + amo(short & byte).
> > >
> >
> > Please note that if _Q_PENDING_BITS == 1, then the xchg_tail() is
> > implemented as a "load + cmpxchg", so if "load + cmpxchg" implementation
> > of xchg16() doesn't provide forward-progress in an architecture, neither
> > does xchg_tail().
> That's the problem of "_Q_PENDING_BITS == 1", no hardware could
> provide "load + ALU + cas" fwd guarantee!
> 

You lost me again... in this patchset, archs that don't have hardware
xchg16 will use _Q_PENDING_BITS == 1, and now you tell me that
"_Q_PENDING_BITS == 1" has a problem, so what's the point of this
patchset? Does the problem of "_Q_PENDING_BITS == 1" need fixes? If so,
when do you plan to send the fix?

Regards,
Boqun

> A simple example, atomic a++:
> c = READ_ONCE(g_value);
> new = c + 1;
> while ((old = cmpxchg(&g_value, c, new)) != c) {
>     c = old;
>     new = c + 1;
> }
> 
> Q: When it runs on CPU0(500Mhz) & CPU1(2Ghz) in one SMP, how do we
> prevent CPU1 from starving CPU0?
> A: I think the answer is using AMO-add instruction:
> atomic_add(1, &g_value);
> (If the arch hasn't atomic instructions and using cmpxchg or lr/sc
> implement atomic, it's the same problem.)
> 
> >
> > Regards,
> > Boqun
> >
> > > >
> > > > Regards,
> > > > Boqun
> > > >
> > > > > >
> > > > > > > --- a/arch/m68k/Kconfig
> > > > > > > +++ b/arch/m68k/Kconfig
> > > > > > > @@ -5,6 +5,7 @@ config M68K
> > > > > > >         select ARCH_32BIT_OFF_T
> > > > > > >         select ARCH_HAS_BINFMT_FLAT
> > > > > > >         select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
> > > > > > > +       select ARCH_HAS_HW_XCHG_SMALL
> > > > > >
> > > > > > M68k CPUs which support the CAS (Compare And Set) instruction do
> > > > > > support this on 8-bit, 16-bit, and 32-bit quantities.
> > > > > > M68k CPUs which lack CAS use a software implementation, which
> > > > > > supports the same quantities.
> > > > > >
> > > > > > As CAS is used only if CONFIG_RMW_INSNS=y, perhaps this needs
> > > > > > a dependency?
> > > > > OK, I think this dependency is needed.
> > > > >
> > > > > Huacai
> > > > >
> > > > > >
> > > > > >    select ARCH_HAS_HW_XCHG_SMALL if RMW_INSNS
> > > > > >
> > > > > > Gr{oetje,eeting}s,
> > > > > >
> > > > > >                         Geert
> > > > > >
> > > > > > --
> > > > > > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > > > > >
> > > > > > In personal conversations with technical people, I call myself a hacker. But
> > > > > > when I'm talking to journalists I just say "programmer" or something like that.
> > > > > >                                 -- Linus Torvalds
> > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> > > ML: https://lore.kernel.org/linux-csky/
> 
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
