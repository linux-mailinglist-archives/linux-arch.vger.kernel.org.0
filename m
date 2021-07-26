Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2FA3D65A2
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 19:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbhGZQoi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 12:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbhGZQof (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 12:44:35 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22FDC08E9B1
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 10:03:51 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y9so12791631iox.2
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L1Nz51Ph+if8XGbL/AiqsnZAt+88JbtjeaRA/9FBd2M=;
        b=c9CL25m5wvbSYc3399ai9ABMOKJLGVZLdhhIuHWo9eUAJsdmTROfW6uBlqctxEaolN
         RbRCoggVrINfuK5BlBon/qbUzcRiPT3eSO/SRnJcgntngBzx72Sfe+J4xFQphOuimiBC
         O7bKRT65a0Z+50eVn6nHye14wS0G0tamD0cIK6AQzuOeWoIhGo3m1RhPfjGVSTfaookl
         EG05ji/Ct/kmjm9h4CalMf4TjjGqzf2+nF2z9mEBl9NUQiJkMoHBKnn7SkcGoS5Ifflo
         zObiju6wDSWh8SagEFl3s0LftYdDwLkPD9cS0LVGEOFcCRug462Epe3s7yjhYJw5CTRn
         Fk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L1Nz51Ph+if8XGbL/AiqsnZAt+88JbtjeaRA/9FBd2M=;
        b=F4ejEFxwTh/Jsb0202c9GUzaFcuFNifFnHunluCtJ2f2+JONQLh0l+KwItDl1EMQxQ
         Ve3vHMquVB+l7obU/sNHOciMFHH68t5Bh73rM4FqIEpaLfHejHqc5KIo++hA6bkfToY7
         S7TPrdFm0PnGZXz3KzroeV62g1xUlyQZGGyTXkI1x32g218CTVALndVNuUGDZXZBTESo
         Bb3AOo1QyPVu/mjEalaP79foILKM+EPUkPNpRVYr5XomK43blT0PzbQsfhR4F8BVcfWd
         LRM0O6huMNNp/7gqQMjG7RlFcMBMqy81za3uM0QhNXfRJwppHyfJ9TepiIqxlNT/MkFZ
         iKvA==
X-Gm-Message-State: AOAM532JJ3sfDkU/rOid4wnteW3Y2q3vWRBZtsobW4PJF1ae2xiCRdwN
        dTmuNUxWIOFHn7vZFwRDeyA=
X-Google-Smtp-Source: ABdhPJygvwItLpxUqEaSijFYgAzoqhAARTp61REsP89bH+Pr5y36Mt77waddHoui75ZBOoSxGaPUTg==
X-Received: by 2002:a05:6638:304a:: with SMTP id u10mr7032301jak.62.1627319031353;
        Mon, 26 Jul 2021 10:03:51 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w14sm151646ilj.76.2021.07.26.10.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 10:03:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 59B7F27C0054;
        Mon, 26 Jul 2021 13:03:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 26 Jul 2021 13:03:49 -0400
X-ME-Sender: <xms:8-r-YN111S69C1d337hTBztPdR-KCbabPOuxx6zKOWTJRTj881kQ6A>
    <xme:8-r-YEHZeU6pKGmDmcR7BOEmBHKXIcshnpF0xMTQJlgzXpCZetgAmivXFG70pjyrf
    7bQs0IseVsf5iyXBg>
X-ME-Received: <xmr:8-r-YN4-XoAc2-jfhY_KyaDGK01-1eVm_uelA2JUhRLmToFYyWvm-QqBcG753w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeehgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:8-r-YK2kJxIucJ8ACKT8KWXFB7Pv2otfZ502J9M4hq7CPy5ok-TN2Q>
    <xmx:8-r-YAFQlGqfMAN1vdn5ef6MeBuvDDJ5vtNubx5Ri4GSzTlxTdpwOw>
    <xmx:8-r-YL-S2cCM7aeUaEj1Rtb4J1WpQLANDvVjNNY4OkBDYCJ9UAQZ2w>
    <xmx:9Or-YHcPpLiqH4C0UJCPx3IzJgK0t1Wo7AaJcqWNzd6mw0YhNHZLdU1G5wc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 13:03:47 -0400 (EDT)
Date:   Tue, 27 Jul 2021 01:03:32 +0800
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
Message-ID: <YP7q5GBweaeWgvcs@boqun-archlinux>
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux>
 <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 12:41:34AM +0800, Guo Ren wrote:
> On Mon, Jul 26, 2021 at 6:39 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Jul 26, 2021 at 04:56:49PM +0800, Huacai Chen wrote:
> > > Hi, Geert,
> > >
> > > On Mon, Jul 26, 2021 at 4:36 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > >
> > > > Hi Huacai,
> > > >
> > > > On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > > Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which means arch
> > > > > has hardware sub-word xchg/cmpxchg support. This option will be used as
> > > > > an indicator to select the bit-field definition in the qspinlock data
> > > > > structure.
> > > > >
> > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- a/arch/Kconfig
> > > > > +++ b/arch/Kconfig
> > > > > @@ -228,6 +228,10 @@ config ARCH_HAS_FORTIFY_SOURCE
> > > > >           An architecture should select this when it can successfully
> > > > >           build and run with CONFIG_FORTIFY_SOURCE.
> > > > >
> > > > > +# Select if arch has hardware sub-word xchg/cmpxchg support
> > > > > +config ARCH_HAS_HW_XCHG_SMALL
> > > >
> > > > What do you mean by "hardware"?
> > > > Does a software fallback count?
> > > This new option is supposed as an indicator to select bit-field
> > > definition of qspinlock, software fallback is not helpful in this
> > > case.
> > >
> >
> > I don't think this is true. IIUC, the rationale of the config is that
> > for some architectures, since the architectural cmpxchg doesn't provide
> > forward-progress guarantee then using cmpxchg of machine-word to
> > implement xchg{8,16}() may cause livelock, therefore these architectures
> > don't want to provide xchg{8,16}(), as a result they cannot work with
> > qspinlock when _Q_PENDING_BITS is 8.
> >
> > So as long as an architecture can provide and has already provided an
> > implementation of xchg{8,16}() which guarantee forward-progress (even
> > though the implementation is using a machine-word size cmpxchg), the
> > architecture doesn't need to select ARCH_HAS_HW_XCHG_SMALL.
> Seems only atomic could provide forward progress, isn't it? And lr/sc
> couldn't implement xchg/cmpxchg primitive properly.
> 

I'm missing you point here, a) ll/sc can provide forward progress and b)
ll/sc instructions are used to implement xchg/cmpxchg (see ARM64 and
PPC).

> How to make CPU guarantee  "load + cmpxchg" forward-progress? Fusion
> these instructions and lock the snoop channel?
> Maybe hardware guys would think that it's easier to implement cas +
> dcas + amo(short & byte).
> 

Please note that if _Q_PENDING_BITS == 1, then the xchg_tail() is
implemented as a "load + cmpxchg", so if "load + cmpxchg" implementation
of xchg16() doesn't provide forward-progress in an architecture, neither
does xchg_tail().

Regards,
Boqun

> >
> > Regards,
> > Boqun
> >
> > > >
> > > > > --- a/arch/m68k/Kconfig
> > > > > +++ b/arch/m68k/Kconfig
> > > > > @@ -5,6 +5,7 @@ config M68K
> > > > >         select ARCH_32BIT_OFF_T
> > > > >         select ARCH_HAS_BINFMT_FLAT
> > > > >         select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
> > > > > +       select ARCH_HAS_HW_XCHG_SMALL
> > > >
> > > > M68k CPUs which support the CAS (Compare And Set) instruction do
> > > > support this on 8-bit, 16-bit, and 32-bit quantities.
> > > > M68k CPUs which lack CAS use a software implementation, which
> > > > supports the same quantities.
> > > >
> > > > As CAS is used only if CONFIG_RMW_INSNS=y, perhaps this needs
> > > > a dependency?
> > > OK, I think this dependency is needed.
> > >
> > > Huacai
> > >
> > > >
> > > >    select ARCH_HAS_HW_XCHG_SMALL if RMW_INSNS
> > > >
> > > > Gr{oetje,eeting}s,
> > > >
> > > >                         Geert
> > > >
> > > > --
> > > > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > > >
> > > > In personal conversations with technical people, I call myself a hacker. But
> > > > when I'm talking to journalists I just say "programmer" or something like that.
> > > >                                 -- Linus Torvalds
> 
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
