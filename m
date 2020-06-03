Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64CA1ECBDB
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jun 2020 10:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFCItz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jun 2020 04:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgFCIty (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2020 04:49:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947DEC05BD43;
        Wed,  3 Jun 2020 01:49:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u5so1310649pgn.5;
        Wed, 03 Jun 2020 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8aGny4PzdL22O010eFSHqSioLRZBiFGjcHa443y84BE=;
        b=Zj7L/J7k6EChQiFbOMJ1ElY9JLYSP0fP+tI/xor871+oem5sGl8vz28txEyB+KDijt
         YolYvP+ODw6t/Lzz7PoEV2H6iAcwskLJ1wqFW71qSZjzcsJzyRJHCo1Bojk7cTiqg0Vw
         9LuWn9ZnAs4NTCcIoQNxy86dvYLscLVeMGfHYdCbIklfcXurzVvS0ftoooZhOXGSE4F7
         66vfNIZFIwRKgLXg9vTyEcTNXWENxz+EBn7SM4oNsG87cwbhILrv8yDd2G1UbPzy8xKc
         e1PHrX9jzVZQ4IvBMKgOXVCHbZ62xQsIq/Wmo230XDgE32H+vkR2cT/sJGeqJUJe5Xo0
         +woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aGny4PzdL22O010eFSHqSioLRZBiFGjcHa443y84BE=;
        b=NdZEQQy9Ed5o7gdPfzR5vpEXJ2rLhPSfpel6acGuU+iW33sGBtRZj4QMeXdvch4f+B
         gVg2iq8kp98hlForWjBmQQ1K6WVyj/cmFZej7JwDS47tSD9n1CPBfhbsNPs18GSDkWiF
         Y/5vNnk0Aiz2oIpqrca5joY3mJ9O0nf2Q9CRR8Q9U/y0O8dsxTZgs0NcC+Eeit7egQao
         HdgeXt09FHopeqzb35+fPnWY/5DFTJudVLVHu/c1ZFTDWdnrGmwnipNL78iLe+0s514r
         bNg8kf0yQEWOjzNOXiu/eMugysJhZgwmvk6pHOV/pCFgZsxyiuW7LDHR8V3HsFZI1fZe
         GVlg==
X-Gm-Message-State: AOAM531dUQt5NkHBOHPxaXB0cD/9ixuet32qeUQm0Tz24QzA+580rFiW
        LekU761JhTJ2uZzB6SOGf11LmHkc6ZuybgArtTY=
X-Google-Smtp-Source: ABdhPJwvNyFIo0t/VhWcsc0o1/LoemYj2k0DzEg0wjD8PHO6rTmna+Wm/hIhelrgDJxSyZIMB10AiZp6CBa0Nw5DHtY=
X-Received: by 2002:a62:148f:: with SMTP id 137mr28392591pfu.130.1591174194053;
 Wed, 03 Jun 2020 01:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
 <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
 <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
 <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
 <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com>
 <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
 <CAHp75Vdxa1_ANBLEOB6g25x3O0V5h3yjZve8qpz-xkisD3KTLg@mail.gmail.com>
 <20200531223716.GA20752@rikard> <20200601083330.GB1634618@smile.fi.intel.com> <20200602190136.GA913@rikard>
In-Reply-To: <20200602190136.GA913@rikard>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Jun 2020 11:49:37 +0300
Message-ID: <CAHp75VdUf8=y+y4Q3OtWc7owxg0uX8LhZY4Nrgnezuv+aSyzUg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
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

On Tue, Jun 2, 2020 at 10:01 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
> On Mon, Jun 01, 2020 at 11:33:30AM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 01, 2020 at 12:37:16AM +0200, Rikard Falkeborn wrote:
> > > On Sun, May 31, 2020 at 02:00:45PM +0300, Andy Shevchenko wrote:

...

> > > If we cast to int, we don't need to worry about the signedness. If
> > > someone enters a value that can't be cast to int, there will still
> > > be a compiler warning about shift out of range.
> >
> > If the argument unsigned long long will it be the warning (it should not)?
>
> No, there should be no warning there.
>
> The inputs to GENMASK() needs to be between 0 and 31 (or 63 depending on the
> size of unsigned long). For any other values, there will be undefined behaviour,
> since the operands to the shifts in __GENMASK will be too large (or negative).

What I'm implying here that argument may be not constant, and compiler
can't know their values at hand.
So, in the following snippet

foo(unsigned long long x)
{
  u32 y;
  y = GENMASK(x, 0);
}

when you cast x to int wouldn't be a warning of possible value
reduction (even if we know that it won't be higher than 63/31)?

-- 
With Best Regards,
Andy Shevchenko
