Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FE13D57AA
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 12:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhGZJ7a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhGZJ7U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 05:59:20 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C63C061757
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 03:39:45 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h18so8406929ilc.5
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 03:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VOoxXCqfUyznRkY+72gqOgugxiiLx634k930L8EhwmA=;
        b=CwKKFkHK2O38HRDH1yusLH2iaLwExicfEd5xs538TjObcGE5vs9PbNpv9A3pNGGv39
         JMcULpArhhkfhP3H+xpBu0Hvudy17TonPUrHcYSc5Kh0TVeXEhHpgWWZE1xemJy293K7
         x46h4kUhJeZs8ErAZ39LSCSTbik0R+eiK8ZicXPK+HRl8BZnEGFze2yr4ZCWLvpl0UBH
         mtFsOT/xA+sIH70rUJVpGrRPIaMGbV+udrYCxvVJ9wohpu9HnMMjvxVmsw8WdEJPl+aA
         JSK7P8O2C3UvBQWCwclI6MUbZ1SFgXZaLL741MzMBkIjnqzI8YW986zeC0by5exYp9Wx
         uAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VOoxXCqfUyznRkY+72gqOgugxiiLx634k930L8EhwmA=;
        b=kI25fot2FslN6txmE3HjJDwifVq1VP+mBi3rnuhLWZGPwKe8V4ylADK8a+sAE0kmGb
         sH7VM7i1s1nIyy1HN9Bqd7nRrGnWg3uKtqDQ0e1FZN1r32BzBnhIsN7aUgtTNO3jZBM7
         cr2DuPnmqZB8y1jOgIVUxstDxfZV4djpeCdV0QBADyY83EdxofIEhBy8Bfhib6BWgqoE
         1WUrfqz9UVzu44UDpSqKsclHYe1j/DcVmIvgf3InXrqc6i2bYOlEneNdGIF7UMpyuER3
         vy/fPgTB3U1tN1sLaCaFJfdbd5h7L9PvnVuNmBSUMeZNt5JHyrnY+fu+1a4D7lVeV7l/
         EN5A==
X-Gm-Message-State: AOAM531CoTdz+4RcPFfxlCfrEYIlCM7Nq82k4FeNlrFRQzepiS4m1xcl
        1HLS7Elcoj+x2+GgHVT/jsA=
X-Google-Smtp-Source: ABdhPJy/2K4sEaqBoZ89+zFoO8Qr9S+AWN/PGo4RiQdzBRE4AvuByd81UOEVUhqrmAGPE2p0Tq3KWQ==
X-Received: by 2002:a05:6e02:20eb:: with SMTP id q11mr12870878ilv.272.1627295984722;
        Mon, 26 Jul 2021 03:39:44 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id n14sm20243641ili.22.2021.07.26.03.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 03:39:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 75CB127C0054;
        Mon, 26 Jul 2021 06:39:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 26 Jul 2021 06:39:43 -0400
X-ME-Sender: <xms:7JD-YKljOKGgngjmHSXqE4DA_LOCBTrd32SO4ha3A6Rr9b2tSkrR0g>
    <xme:7JD-YB1hTgShC2wGxBPlYFjsoPLRXT378egK-q04t7oHpmH3-4yS6oNiQz8MUA39G
    egtFzq4mvSmxYrjoA>
X-ME-Received: <xmr:7JD-YIq_u-TmKwUbKNiw7bq9IfX5_j4xzCBt5RoHjBfA86lc6zGZbYYpzdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeehgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:7JD-YOn1IZYnc8FsKsY6Flxv_H3Bqu75cBK6MYQhbpQdoR2uw7zlyA>
    <xmx:7JD-YI3OdGwVMHgd_m3FM26BEFRHEL9IuvYaK-KWMZ9NOfv7z8OOiQ>
    <xmx:7JD-YFs8MVADIt6CosHAqRqYPvYWCdnDlOURe293_fsFU629oraPgA>
    <xmx:75D-YOMhMJAnkzQRe5uWXDYkjMxUwkxHRb-9CXhCVR70xMVXo4zAQ60QCMw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 06:39:40 -0400 (EDT)
Date:   Mon, 26 Jul 2021 18:39:26 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>, Guo Ren <guoren@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
Message-ID: <YP6Q3s5Kpg2A1NRZ@boqun-archlinux>
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 26, 2021 at 04:56:49PM +0800, Huacai Chen wrote:
> Hi, Geert,
> 
> On Mon, Jul 26, 2021 at 4:36 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Huacai,
> >
> > On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which means arch
> > > has hardware sub-word xchg/cmpxchg support. This option will be used as
> > > an indicator to select the bit-field definition in the qspinlock data
> > > structure.
> > >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -228,6 +228,10 @@ config ARCH_HAS_FORTIFY_SOURCE
> > >           An architecture should select this when it can successfully
> > >           build and run with CONFIG_FORTIFY_SOURCE.
> > >
> > > +# Select if arch has hardware sub-word xchg/cmpxchg support
> > > +config ARCH_HAS_HW_XCHG_SMALL
> >
> > What do you mean by "hardware"?
> > Does a software fallback count?
> This new option is supposed as an indicator to select bit-field
> definition of qspinlock, software fallback is not helpful in this
> case.
> 

I don't think this is true. IIUC, the rationale of the config is that
for some architectures, since the architectural cmpxchg doesn't provide
forward-progress guarantee then using cmpxchg of machine-word to
implement xchg{8,16}() may cause livelock, therefore these architectures
don't want to provide xchg{8,16}(), as a result they cannot work with
qspinlock when _Q_PENDING_BITS is 8.

So as long as an architecture can provide and has already provided an
implementation of xchg{8,16}() which guarantee forward-progress (even
though the implementation is using a machine-word size cmpxchg), the
architecture doesn't need to select ARCH_HAS_HW_XCHG_SMALL.

Regards,
Boqun

> >
> > > --- a/arch/m68k/Kconfig
> > > +++ b/arch/m68k/Kconfig
> > > @@ -5,6 +5,7 @@ config M68K
> > >         select ARCH_32BIT_OFF_T
> > >         select ARCH_HAS_BINFMT_FLAT
> > >         select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
> > > +       select ARCH_HAS_HW_XCHG_SMALL
> >
> > M68k CPUs which support the CAS (Compare And Set) instruction do
> > support this on 8-bit, 16-bit, and 32-bit quantities.
> > M68k CPUs which lack CAS use a software implementation, which
> > supports the same quantities.
> >
> > As CAS is used only if CONFIG_RMW_INSNS=y, perhaps this needs
> > a dependency?
> OK, I think this dependency is needed.
> 
> Huacai
> 
> >
> >    select ARCH_HAS_HW_XCHG_SMALL if RMW_INSNS
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
