Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9366A3DC288
	for <lists+linux-arch@lfdr.de>; Sat, 31 Jul 2021 03:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhGaBvn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 21:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhGaBvm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jul 2021 21:51:42 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5A3C06175F;
        Fri, 30 Jul 2021 18:51:36 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id r5so11188831ilc.13;
        Fri, 30 Jul 2021 18:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m1SHKy5hexFk2I9Nf/8HsQX5Jd6mF6IvHmx4tMHAEV8=;
        b=F0RM9J10Y6gLe53NWCR7Tsd8sTL7s/1xf0EbbPlzB6v3DHqR9+LrRvQ32zN17DTnTn
         x1ftAUAZExm0soRfMEgzXFk06P9cKp+y+fXZ95zjWIW05GtQyF1wGdE6bf2FVGts1gwH
         Lgwc3ejm4WXjdS9laeLFD8E7vCtJhNJn1vk6gAcWQsrrhE7E0jrQ+e39kCBRiXkSb1W/
         MScOCbFfmbGS9UznZvMXZ4/bgc0+Sb6MKK8RTwFNkfgZt/ViUL/h7nYPjJ+6Ed+pB5vV
         u3GaN464x8Ghb5z0pYoWhNIs7GvjFrxPsF7+gdUXmhppFYyBJX+rOHZxehzzwGIfqe6u
         npCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m1SHKy5hexFk2I9Nf/8HsQX5Jd6mF6IvHmx4tMHAEV8=;
        b=ebf1+tPiAcN+6Dd1YooqZwoiBqEMnUhbMCHNglGpbq3Lg9fsPjONX2ANk7lTKobc8v
         Fl86V5gWGFrsIEgPLu2MEFNsn+bR9LQi3de7/vBb+oVzNY86HTqhfdrypMcx99jYtmAf
         llJNhNxJfMFkIa4sypD1XBcAlGpK0iys8YRHSzro0hLAX9lpNjERnpa/EceGJTCvhC/R
         P0GlZ1NJH39TgEoywKNmVIgAYzvM170CdV7Um/tbpVAG1Hk6xiXmQtoyCJd5kt0oUGvJ
         mjCUFdaikkcc9s8pE6omC9b0fB+WuseyWJ0WA8m7ZbRe3Bw87eoROeKKey2jncNpclv+
         JbZQ==
X-Gm-Message-State: AOAM531e1X15hie7GyY0vltO4HQI1JlpA28X92cHg5hRUEX+Zn2jb2s2
        BXKvz/pNHTYUxoK/ZwbNcpA=
X-Google-Smtp-Source: ABdhPJyn/tYN5Z/GRoMRw6hRGtBKNTaELrqCtNh7R56Z3uYF95ZwtIllPdDTvJXhz2mVlxUZ93LWOQ==
X-Received: by 2002:a92:da86:: with SMTP id u6mr2325722iln.265.1627696295747;
        Fri, 30 Jul 2021 18:51:35 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id u16sm2047220iob.41.2021.07.30.18.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 18:51:35 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4EE3527C0054;
        Fri, 30 Jul 2021 21:51:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 30 Jul 2021 21:51:34 -0400
X-ME-Sender: <xms:pKwEYeRGRGDqRamBCEzxaEqzZDHBJXjIJnnKgi8BPamVFeeheScRiQ>
    <xme:pKwEYTwj6a705TqrPFQeYLOj1w9CxSJT3PfUVgyPl0Fl3YC6CtTer2VGkWGz52h7d
    T8mHiTcAXxOCZC9fg>
X-ME-Received: <xmr:pKwEYb1AnGmMfU1AFbokw9vF_PrlskmJGVTx_0-pF7XFQfLXVCVmCWoQ4zc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrheeigdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:pKwEYaDK0DIwv0simMgsjeUmo3dUk0IwvkTRbMqZYxlW73PIzZsdSw>
    <xmx:pKwEYXjKtQBUxJSIaFaNzLj0DjWFAEMygPwUF6VAdSLs2p5g5A8_WA>
    <xmx:pKwEYWqh1djR_7Yh5l5pOU8mPaas-l_BX7Zs2CkBT2ZE-M9YrmoSNA>
    <xmx:pawEYXj0EaWHgFf_p5A2IXrYC641YUSIzbs7C5n5vGsyEAyjCLxBvA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jul 2021 21:51:32 -0400 (EDT)
Date:   Sat, 31 Jul 2021 09:51:05 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Hector Martin <marcan@marcan.st>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [Question] Alignment requirement for readX() and writeX()
Message-ID: <YQSsiacvJHFKk3Cj@boqun-archlinux>
References: <YQQr+twAYHk2jXs6@boqun-archlinux>
 <CAK8P3a0w09Ga_OXAqhA0JcgR-LBc32a296dZhpTyPDwVSgaNkw@mail.gmail.com>
 <YQQ3KAXrPN1CuglL@boqun-archlinux>
 <CAK8P3a3_pgtUWrg-MpaVyVqhffeuvQECHCmSCLyudfSwuEcP_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3_pgtUWrg-MpaVyVqhffeuvQECHCmSCLyudfSwuEcP_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 30, 2021 at 10:24:53PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 30, 2021 at 7:31 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > On Fri, Jul 30, 2021 at 06:58:30PM +0200, Arnd Bergmann wrote:
> >
> > If we want to check, I'd expect we do the checks inside
> > readX()/writeX(), for example, readl() could be implemented as:
> >
> >         #define readl(c)                                        \
> >         ({                                                      \
> >                 u32 __v;                                        \
> >                                                                 \
> >                 /* alignment checking */                        \
> >                 BUG_ON(c & (sizeof(__v) - 1));                  \
> >                 __v = readl_relaxed(c);                         \
> >                 __iormb(__v);                                   \
> >                 __v;                                            \
> >         })
> >
> > It's a runtime check, so if anyone hates it I can understand ;-)
> 
> Right, I really don't think that adds any value, this just replaces one
> oops message with a more different oops message, while adding
> some overhead.
> 

Agreed. I wasn't planning to propose this kind of checks for C code.
Just want to understand better on the alignment requirement of these
APIs. Thanks  ;-)

Regards,
Boqun

>         Arnd
