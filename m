Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D661E9AFC
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jun 2020 02:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgFAAbz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 31 May 2020 20:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgFAAby (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 May 2020 20:31:54 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CFBC061A0E;
        Sun, 31 May 2020 17:31:54 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y18so5213152iow.3;
        Sun, 31 May 2020 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7AXatgBh4ba87xwJC4wVEzk6QYWsxKFEXtTPjtQGU+s=;
        b=qz05cLfu7GsYfTlxFgBWYOpqMiGfnLZ9tGEpuNmhxDBXislfKbSQnK+h9QyZlCKuxa
         hYLRmaV4EBbFsoVUicXQf0nl+AnAb8kP5qjcX6GC6PNk7uvmLS5Xpm4bp15MLttwAye/
         N101aN/ffXSM77rITJwXGM9rfPNxV5Yv/jkl6psXA2AzFyKdk/LY/GpGNyk4YQbOWwED
         NUgvsy0uJnhBETsMXEm09vo92JwpvWGTlbqH+AAiwyNKyNwsduaTrOSjCiG+w8PdFSo0
         kYo6NC7Gmuniy5zJt7d3pNjcGp2/BY6Nwp1/ouiiL5NBie4drbeXxWURzA1/i87aCVzC
         9S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7AXatgBh4ba87xwJC4wVEzk6QYWsxKFEXtTPjtQGU+s=;
        b=soTyzCmas54opSCT7MR1eIihivqHLqCjOkSNIlUipkKSsdXaOvFXqR5eZG6jUsQj4I
         zWbLq/1zxtHIxoqE12C8AqK/NCh1yPMihPqcOfdFBgs8CncUWxEKB9UEn4NPxl4yHJgB
         Cz5q2H5oee5e9xLr3GmTv2bCVxvOXi46620SIR89fjaCqtB3aaGyAQExkv0qFS9ayV4c
         J4zT84RxRckom5ZSbEabhqJMEZl904szwEBXRrQZLOX5hDJxeAyWBz1fvVLvffJpM1ib
         jm/bV+Nb+t2Odp/CYq5FcrtgfLbxaZ7H/lA27tCoXndJsVIkfr7634O7HZHw8elTQEt/
         EJ9w==
X-Gm-Message-State: AOAM530oC6ddNXUozD6HJsM38l490aPhoydoG9CNJKC7Zeh1o1sTVtOk
        s6CEjoMjICegDhHU/A2TILSI2+aUw8ZdV0HFGcI=
X-Google-Smtp-Source: ABdhPJxt/89izX6sIy/6Q17rXtafjCyWk6p+1XtcD/Sci26BcMVbxcTcrs4IPmjq6MDD3Z7dOlJt2gbsjtf9xSxfLXc=
X-Received: by 2002:a02:cc49:: with SMTP id i9mr10996113jaq.52.1590971513885;
 Sun, 31 May 2020 17:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com> <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
 <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
 <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
 <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
 <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com>
 <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
 <CAHp75Vdxa1_ANBLEOB6g25x3O0V5h3yjZve8qpz-xkisD3KTLg@mail.gmail.com> <20200531223716.GA20752@rikard>
In-Reply-To: <20200531223716.GA20752@rikard>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Mon, 1 Jun 2020 06:01:41 +0530
Message-ID: <CACG_h5ryGAdaQ3YWf=0JYH1LJc1q1s1wiXJYLiJ5mNbyCKLrZg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Mon, Jun 1, 2020 at 4:07 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> + Emil who was working on a patch for this
>
> On Sun, May 31, 2020 at 02:00:45PM +0300, Andy Shevchenko wrote:
> > On Sun, May 31, 2020 at 4:11 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > On Sat, May 30, 2020 at 2:50 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Sat, May 30, 2020 at 11:45 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > > > On Sat, May 30, 2020 at 3:49 AM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> >
> > ...
> >
> Sorry about that, it seems it's only triggered by gcc-9, that's why I
> missed it.
>
> > > #if (l) == 0
> > > #define GENMASK_INPUT_CHECK(h, l)  0
> > > #elif
> > > #define GENMASK_INPUT_CHECK(h, l) \
> > >         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > >                 __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > > #endif
> > >
> > > I have verified that this works. Basically this just avoids the sanity
> > > check when the 'lower' bound 'l' is zero. Let me know if it looks
> > > fine.
>
> I don't understand how you mean this? You can't use l before you have
> defined GENMASK_INPUT_CHECK to take l as input? Am I missing something?

Excuse me for the incorrect code snippet that I shared (above). Kindly
ignore it. I realise the error in it.

>
> How about the following (with an added comment about why the casts are
> necessary):
>
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 4671fbf28842..5fdb9909fbff 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -23,7 +23,7 @@
>  #include <linux/build_bug.h>
>  #define GENMASK_INPUT_CHECK(h, l) \
>         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> +               __builtin_constant_p((int)(l) > (int)(h)), (int)(l) > (int)(h), 0)))
>  #else
>  /*
>   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,

Yes, the above fix is working fine. Now the compilation warning is not
getting reported.

Regards
Syed Nayyar Waris

>
> I can send a proper patch if this is ok.
> >
> > Unfortunately, it's not enough. We need to take care about the following cases
>
> The __GENMASK macro is only valid for values of h and l between 0 and 63
> (or 31, if unsigned long is 32 bits). Negative values or values >=
> sizeof(unsigned long) (or unsigned long long for GENMASK_ULL) result in
> compiler warnings (-Wshift-count-negative or -Wshift-count-overflow). So
> when I wrote the GENMASK_INPUT_CHECK macro, the intention was to catch
> cases where l and h were swapped and let the existing compiler warnings
> catch negative or too large values.
>
> > 1) h or l negative;
>
> Any of these cases will trigger a compiler warning (h negative triggers
> Wshift-count-overflow, l negative triggers Wshift-count-negative).
>
> > 2) h == 0, if l == 0, I dunno what is this. it's basically either 0 or warning;
>
> h == l == 0 is a complicated way of saying 1 (or BIT(0)). l negative
> triggers compiler warning.
>
> > 3) l == 0;
>
> if h is negative, compiler warning (see 1). If h == 0, see 2. If h is
> positive, there is no error in GENMASK_INPUT_CHECK.
>
> > 4) h and l > 0.
>
> The comparisson works as intended.
>
> >
> > Now, on top of that (since it's a macro) we have to keep in mind that
> > h and l can be signed and / or unsigned types.
> > And macro shall work for all 4 cases (by type signedess).
>
> If we cast to int, we don't need to worry about the signedness. If
> someone enters a value that can't be cast to int, there will still
> be a compiler warning about shift out of range.
>
> Rikard
>
> > > Regarding min, max macro that you suggested I am also looking further into it.
> >
> > Since this has been introduced in v5.7 and not only your code is
> > affected by this I think we need to ping original author either to fix
> > or revert.
> >
> > So, I Cc'ed to the author and reviewers, because they probably know
> > better why that had been done in the first place and breaking existing
> > code.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
