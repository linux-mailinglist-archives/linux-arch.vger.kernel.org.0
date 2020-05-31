Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C341E94DE
	for <lists+linux-arch@lfdr.de>; Sun, 31 May 2020 03:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbgEaBLz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 May 2020 21:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgEaBLz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 May 2020 21:11:55 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67E5C03E969;
        Sat, 30 May 2020 18:11:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y18so3374030iow.3;
        Sat, 30 May 2020 18:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YrUMJm73ZwzzC/W/oEuS2gLBD11t/qt40SB7aK49T1o=;
        b=IO4bvnPGqPLbcJI6dJRkmQY8L+lFKPKe/NdaEYfuqiiXxtf20if7b9qbw7EnfZzDP1
         ghy6+v4llD2fcVGy3xTQEvRD5/04wEUr0cYnGVFnJ11kOfc+0vkO/nVPucvr50w83Hct
         YBb6UPtLPpid1jfdR0W8XVjal769GuVWDD4OE1t46vxRrH3LQc0M9OGdWVyXBsYzMfk9
         trzqWe/CU2qoLVWGssJ72TvYNjjADLFHcXJIl51pkfuIFxwQjlphcR734x598OlBRz9P
         DM1uuV8HiCuoHSgqHizOwNct99WKAq1h80eFL23gKJeLNd10Nt7syTqXv5IVqklHUl3N
         jT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrUMJm73ZwzzC/W/oEuS2gLBD11t/qt40SB7aK49T1o=;
        b=InwJKz/zd3NqZ5LFLTxUV7D2/d0bRW8mEreQBecBhX2AzPN7+YQ7QRIvJMrCimlM9q
         HCcDXkvYPC4IeriMUHXUZ2jHtspuUBoKeRSg3KV2YJ65yv+q9RwYzAxDncDlCGJNNj0+
         SrQMvBS9yu/qpX6m3bM7nvX7+jU5bDI1apZakzg7Pbcm2GAxQ9gTuGMPA7NPP7ppT6sj
         ACTVj18E6MLoWB52iQcSu4+vy7hgOQS3uUFxPsJ+vAvj+GlUKpw2SGdvlDUYPXBWK2vJ
         +NEZ2V7/BiYkJqqKuChZABX1l2FZGtEUtx0yUkIV3kbW2k9530rRgclbo3LgZzRYXbRX
         SPDA==
X-Gm-Message-State: AOAM531FN9yQ3yXby8LSwkV3QfFnA4MMz3Exf6x05uDUFhBQIIaA2PoX
        h/iHP2/0GnDaTGrQRtTIY2rt2oFPeNmSal/HK0k=
X-Google-Smtp-Source: ABdhPJwgOK0kayqBC3P/C+aX3scAH8mfpMC3PT1bgnuxLFh1WOBjeG17mZ/ecclNE4eVN28/1u0X4TUO9d6uWoIGk38=
X-Received: by 2002:a02:cc49:: with SMTP id i9mr6735852jaq.52.1590887513109;
 Sat, 30 May 2020 18:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com> <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com> <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
 <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
 <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
 <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com> <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com>
In-Reply-To: <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sun, 31 May 2020 06:41:41 +0530
Message-ID: <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 30, 2020 at 2:50 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, May 30, 2020 at 11:45 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > On Sat, May 30, 2020 at 3:49 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
>
> ...
>
> > I am still investigating more on this. Let me know if you have any suggestions.
>
> As far as I understand the start pointers are implementations of abs()
> macro followed by min()/max().
> I think in the latter case it's actually something which might help here.
>
> Sorry, right now I have no time to dive deeper.

No Problem. Thank you for sharing your initial pointers.

By the way, as I was working on it I found a way to avoid comparison
with '0' in '__builtin_constant_p'. And because of this, no
compilation warnings are getting produced.

Change the following:

#define GENMASK_INPUT_CHECK(h, l) \
        (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
                __builtin_constant_p((l) > (h)), (l) > (h), 0)))


To this:

#if (l) == 0
#define GENMASK_INPUT_CHECK(h, l)  0
#elif
#define GENMASK_INPUT_CHECK(h, l) \
        (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
                __builtin_constant_p((l) > (h)), (l) > (h), 0)))
#endif

I have verified that this works. Basically this just avoids the sanity
check when the 'lower' bound 'l' is zero. Let me know if it looks
fine.

Regarding min, max macro that you suggested I am also looking further into it.

Regards
Syed Nayyar Waris
