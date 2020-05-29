Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1DA1E8AFF
	for <lists+linux-arch@lfdr.de>; Sat, 30 May 2020 00:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgE2WII (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 May 2020 18:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgE2WII (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 18:08:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA8EC03E969;
        Fri, 29 May 2020 15:08:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so1762751plv.9;
        Fri, 29 May 2020 15:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bIMpCJ94S64iX9SZqFBI3aKlDTVQaJmor4Ew0nG9Zo=;
        b=T08vu+XtVe9OQSO2ckBP6WY2pRv3eb/PC2L+RP5iv9/lwDNlaN+S0TpbowBQmUiEOI
         RBphKLbkSXp/JxXjWerxz3YvnyGEdJ6aijOnRjBY5aKckjkSzrHtHbWrQf9FXCUsIGEZ
         AsxfkoqOKfo/UyTd7oc0Wwui7IwuWwiktQaRDV2tMFFNppg4kjhQOcU84onyXVWSzsRs
         DTe1oSRh2TczeWxEhBKfB9rzCpKi7plebo6ejSnBI8l5VuowQxhYBkZIovfmxinBqIe4
         2rk9wXs+w2dP5FRYVTLhbjzyqGHn0X+PEECz/5DWl1FhSsmc3aUMs+bUjycDvqKzW+yn
         y6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bIMpCJ94S64iX9SZqFBI3aKlDTVQaJmor4Ew0nG9Zo=;
        b=uB6LLdSf855FML9zAFEaxcBTXIzLsk7dBWg1Qx3t5BLqq6JxfWRX751aYx74im5N76
         GPRUQhzSuQT/vCfgZZVwLz0bGNLWSsyAQC3QACb1JAGOq2Eng53T6lDI/Eb/RwBOZDxr
         42x9CXQED+InZLKofVYBTPhFfyh6mNlnPYJNWSiG3ycGaiNELkNeMJZcNk8YuZd6zjW6
         m9MoUe2I/qNbpDnh4Mrqlw8yTjxcoSjBlxEfbeiVDGySDJL/xLfFytuxe8R7DztC7EVP
         /yH65x60f0fU7p8VgWoczhtUU9/UwxGtuPWPjWL+kQruwY0xsV6scItLpHE8uWOOdnZY
         d3pw==
X-Gm-Message-State: AOAM532/w7NI6BFrlD63vGLzg91PPKEqg6XyrwWkb+Fy2oo6vwK4359S
        tVC88KS7RiLoev9LTeOIAUZZREyoEzB9FK8lY30=
X-Google-Smtp-Source: ABdhPJzlkUzeXZg6I/DQ74WIcmfHmCi22kPTyptX6BPi58fLjDdcV+Yc9S+dHi7SyU8GQjQmHsYabzsBKwNnryGvc9w=
X-Received: by 2002:a17:902:ea8a:: with SMTP id x10mr10688473plb.255.1590790087561;
 Fri, 29 May 2020 15:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com> <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com> <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
In-Reply-To: <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 May 2020 01:07:51 +0300
Message-ID: <CAHp75VfGCLSOwPtygG7Vq8RLhvA3_3EcB-WRCXZzR=jzOP6DsA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
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

On Sat, May 30, 2020 at 12:42 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, May 29, 2020 at 11:07 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > On Sat, May 30, 2020 at 12:08 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

...

> > Explanation:
> > Actually when nbits (clump size) is 64 (BITS_PER_LONG is 64 on my computer),
> > (BIT(nbits) - 1)
> > gives a value of zero and when this zero is ANDed with any value, it
> > makes it full zero. This is unexpected and incorrect calculation happening.
> >
> > What actually happens is in the macro expansion of BIT(64), that is 1
> > << 64, the '1' overflows from leftmost bit position (most significant
> > bit) and re-enters at the rightmost bit position (least significant
> > bit), therefore 1 << 64 becomes '0x1', and when another '1' is
> > subtracted from this, the final result becomes 0.
> >
> > Since this macro is being used in both bitmap_get_value and
> > bitmap_set_value functions, it will give unexpected results when nbits or clump
> > size is BITS_PER_LONG (32 or 64 depending on arch).
>
> I see, something like
> https://elixir.bootlin.com/linux/latest/source/include/linux/dma-mapping.h#L139
> should be done.
> But yes, let's try to fix GENMASK().
>
> So, if we modify the following
>
>   #define GENMASK_INPUT_CHECK(h, l) \
>     (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>     __builtin_constant_p((l) > (h)), (l) > (h), 0)))
>
> to be
>
>   #define GENMASK_INPUT_CHECK(h, l) \
>     (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>     __builtin_constant_p((l) > (h)), (l) ? (l) > (h) : 0, 0)))
>
> would it work?

Actually it needs an amendment for signed types...

(l) ? (l) > (h) : !((h) > 0)

...but today is Friday night, so, mistakes are warranted :-)

-- 
With Best Regards,
Andy Shevchenko
