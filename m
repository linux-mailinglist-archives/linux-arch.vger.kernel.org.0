Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBAB1ED82F
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jun 2020 23:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgFCVxU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jun 2020 17:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCVxU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2020 17:53:20 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33DDC08C5C0;
        Wed,  3 Jun 2020 14:53:19 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n23so4712516ljh.7;
        Wed, 03 Jun 2020 14:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BDJiR6Y3Jnskb29DRc28eXar01RDhTmGwSHZkvP44kA=;
        b=E5ZBZ3n7cEMtIB4IeleRFjVYmNfFTf9rUXsSqGXfeBFiYWDcYBq0a7EeRmerSEGp/1
         GWT2NQj9LRYpLKjKtpFMDgcxrgQlLG7gVvZZgggbxchpKQxy9VICNlB2mNE0SQVvYbjw
         qYUA1UWxONPui2ACGsC42l6TIv69BwcAD1fsHItf0wIEellKB/XGGFy08HiO+nkn/yjW
         jPwMIFU9nykKsdWuLW62q4eNZm1JWGsp1F4XO2LtBF7FGzNoS+0PVNBmIMLptCaxEIos
         bHiPjwg/5j5qe9G8ZeClSyLDQII2JsbK+61A4MdChR3tNDe0/8n/J72UjBSogQCfKddd
         oXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BDJiR6Y3Jnskb29DRc28eXar01RDhTmGwSHZkvP44kA=;
        b=b9nGjxrTevBKSjpDJEl3HrTKpWg77dNhCIvqNviquxxjREcexcGI8QcdBEN1DINLer
         iqNfcKTpiXOM56FeGTONmS8jk+yKHGe4B/s6ttPaFMpVfX3NO3J5+TzViEdc2Hc6wWbk
         W0cn45nHz3rUAahVu9QXdg8GzjPvMnZJlDxmbnYiU5Z1MwxmZG9r/Sg9QjPaK//hwjpg
         G1Ad8PfTL12rqNs6UwcDSGuwUlIH2sieip9JYdXGh81dh9tZCdIA/CdH7aFZcRiXev3s
         f0oPELX7eueR7ObunrI8jZy1zpDqMFpkmSeVqoXlU2N29653vrwk8WoxUHAcwvN85UuC
         cgJQ==
X-Gm-Message-State: AOAM531vG1YBZ8PUFVN4d9Mk5SPTMmeQYsWvO96RUZGr7vCgRSg6Fbpx
        /n1T88GC2/u/jwPsV6zY5TQ=
X-Google-Smtp-Source: ABdhPJyxgvJwJCBXtlYSjQBr3GZnl+jvJ16S6YQWA/bJnsLzbNEztiRk+jQE+xEO5AUC6f3NAa+TCQ==
X-Received: by 2002:a05:651c:38e:: with SMTP id e14mr615711ljp.452.1591221198109;
        Wed, 03 Jun 2020 14:53:18 -0700 (PDT)
Received: from rikard (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id y3sm499413ljk.39.2020.06.03.14.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 14:53:17 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Wed, 3 Jun 2020 23:53:14 +0200
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
Message-ID: <20200603215314.GA916134@rikard>
References: <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
 <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
 <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
 <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com>
 <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
 <CAHp75Vdxa1_ANBLEOB6g25x3O0V5h3yjZve8qpz-xkisD3KTLg@mail.gmail.com>
 <20200531223716.GA20752@rikard>
 <20200601083330.GB1634618@smile.fi.intel.com>
 <20200602190136.GA913@rikard>
 <CAHp75VdUf8=y+y4Q3OtWc7owxg0uX8LhZY4Nrgnezuv+aSyzUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdUf8=y+y4Q3OtWc7owxg0uX8LhZY4Nrgnezuv+aSyzUg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 03, 2020 at 11:49:37AM +0300, Andy Shevchenko wrote:
> On Tue, Jun 2, 2020 at 10:01 PM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
> > On Mon, Jun 01, 2020 at 11:33:30AM +0300, Andy Shevchenko wrote:
> > > On Mon, Jun 01, 2020 at 12:37:16AM +0200, Rikard Falkeborn wrote:
> > > > On Sun, May 31, 2020 at 02:00:45PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > If we cast to int, we don't need to worry about the signedness. If
> > > > someone enters a value that can't be cast to int, there will still
> > > > be a compiler warning about shift out of range.
> > >
> > > If the argument unsigned long long will it be the warning (it should not)?
> >
> > No, there should be no warning there.
> >
> > The inputs to GENMASK() needs to be between 0 and 31 (or 63 depending on the
> > size of unsigned long). For any other values, there will be undefined behaviour,
> > since the operands to the shifts in __GENMASK will be too large (or negative).
> 
> What I'm implying here that argument may be not constant, and compiler
> can't know their values at hand.
> So, in the following snippet
> 
> foo(unsigned long long x)
> {
>   u32 y;
>   y = GENMASK(x, 0);
> }
> 
> when you cast x to int wouldn't be a warning of possible value
> reduction (even if we know that it won't be higher than 63/31)?

Got it, no I was unable to trigger any warnings like that (but I still
can't reproduce to original warning, so take that with a grain of salt).
I'd be very surprised if compilers warned for explicit casts but  I'll
send a proper patch soon to let the build robot try it.

Rikard
> 
> -- 
> With Best Regards,
> Andy Shevchenko
