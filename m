Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28431E9725
	for <lists+linux-arch@lfdr.de>; Sun, 31 May 2020 13:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgEaLBE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 31 May 2020 07:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgEaLBE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 May 2020 07:01:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A6C061A0E;
        Sun, 31 May 2020 04:01:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n15so2121402pfd.0;
        Sun, 31 May 2020 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pv6M/ubzOrR2GpHct2V9mx36XIAqlU5lXxjX4nPRe8g=;
        b=YG4n2UPCARQM4F8D3Yzto1lnn1CByWD9LQYK9620mtA0+Nci7rBwlMTuDrz9f7ddtX
         ZEzZ339tXSj5NzcIfczwsen2Ed9vy5sUz4sEgt8IDelttbchalVGWEvnPiOwAUF7cwAS
         sUn0S1IvYmJlDuu475OK6gY7zuJQj9SmBpbAIaszTypMIv+q2bYfWYbOYdvMtSvrDfdv
         iM+nMCU5oJVCSsmYfMUSO4On84V7AiX4aghx2L7S8D/dvXC7/BkbI+QtyAs3BxP8mvXM
         pLRrhQ0xUapiRdIkwxyXz/3fZyckNSLNhRv22VE2j/k8Bfy/HMEhb5HNxqFvLBbtka73
         iSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pv6M/ubzOrR2GpHct2V9mx36XIAqlU5lXxjX4nPRe8g=;
        b=JkNenq3ggO0FhfxfnVZLmmFA+Prt7mFyRPKx8ORBLlQWtsic/n2l7vm5yqSACtsjaM
         3Bf0MTKQhXGbcjZhhGyNAguUlj4RMBUr3Bie8rVgxXfmSVkMHUHM3lPA86so6sDMtJW0
         cnRL3ds2yozKq2irwv40NjpcREqM1McjKbwLXj0fK90hCospm2Yrk3ctEDhlt+19e/oK
         wdlHjSq0fFuPydtvumAypy+fD22npEY27c6QQxt8oTLAROVrGvO4boTPfrJwXB4bRCIy
         hghqCIugP3wd5zSHq5fMbWq20jLEt+AR+O3RBgG+SVruDvH3P48FaP7gFAv3506acPsu
         pO3Q==
X-Gm-Message-State: AOAM531Q8fg8nkc9+ul5qHE/nYbvxU2Z+dN/sBND4T530DakqdVTjL7b
        ARw/TG0bL92pDkUMa1HtydyrFYbGTqgbGrZmu7k=
X-Google-Smtp-Source: ABdhPJx0TrnbFI3b834Ncn0t7vRgYuKR/nqkJEpsHfz1JlHeGNMDgFt3qEwkR7uRnVKoKzhm6Oiu7jZpxX42nMnkY80=
X-Received: by 2002:a63:545a:: with SMTP id e26mr14919928pgm.4.1590922862169;
 Sun, 31 May 2020 04:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com> <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com> <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
 <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
 <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
 <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
 <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com> <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
In-Reply-To: <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 May 2020 14:00:45 +0300
Message-ID: <CAHp75Vdxa1_ANBLEOB6g25x3O0V5h3yjZve8qpz-xkisD3KTLg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>
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

On Sun, May 31, 2020 at 4:11 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> On Sat, May 30, 2020 at 2:50 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, May 30, 2020 at 11:45 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > On Sat, May 30, 2020 at 3:49 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:

...

> #if (l) == 0
> #define GENMASK_INPUT_CHECK(h, l)  0
> #elif
> #define GENMASK_INPUT_CHECK(h, l) \
>         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>                 __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> #endif
>
> I have verified that this works. Basically this just avoids the sanity
> check when the 'lower' bound 'l' is zero. Let me know if it looks
> fine.

Unfortunately, it's not enough. We need to take care about the following cases
1) h or l negative;
2) h == 0, if l == 0, I dunno what is this. it's basically either 0 or warning;
3) l == 0;
4) h and l > 0.

Now, on top of that (since it's a macro) we have to keep in mind that
h and l can be signed and / or unsigned types.
And macro shall work for all 4 cases (by type signedess).

> Regarding min, max macro that you suggested I am also looking further into it.

Since this has been introduced in v5.7 and not only your code is
affected by this I think we need to ping original author either to fix
or revert.

So, I Cc'ed to the author and reviewers, because they probably know
better why that had been done in the first place and breaking existing
code.

-- 
With Best Regards,
Andy Shevchenko
