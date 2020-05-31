Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD261E9AB4
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jun 2020 00:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEaWhW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 31 May 2020 18:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgEaWhW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 May 2020 18:37:22 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4CAC061A0E;
        Sun, 31 May 2020 15:37:21 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h188so2833641lfd.7;
        Sun, 31 May 2020 15:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T/8MeyJJH0JsIivt1fh/rskIbIUufxjNMTtDunlyTkw=;
        b=K+DxFS1Qqk0r99eeEUWrUBYjwGif/vUETC4UJB+a6P4Ap9A6GwdbPYY74YEjw80XTQ
         T79LzmKyvfxQuJYuulsY4pzGhTa88J4ATmewsxyuLqYgSKxxAwH9OOx7wKbcJCftbbJJ
         YLlTt/YpZK6A5e/5SUdGpfpJzVGa6sV3QTkSnQMW7XYMVr408lxUtJkVWu1hejSRHmpi
         V8IambVjXEEpwS0ILiwwzHmQPYf8ARzjeGwBpyR4fkxyr5i0aLBggwfVIDqN65FHgMJL
         WbyUsi//iJcA+mP7BCHijO09q5LEcUJ+zErzwD3/RBN++zT/U20EMYmywGnenC7zOpAX
         nnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T/8MeyJJH0JsIivt1fh/rskIbIUufxjNMTtDunlyTkw=;
        b=fH2TcgQ0cPc59drjDe16ib35GKOBAulkaMS1g+ccGYx5ITNls4VZX3cawfWb9V+7Pw
         t1uMuSRMTP0yP80IIy0gnqGd4LvNQnmw2izjxEKU8NB+rku2RfogrSg26+OQSrNc78e/
         MgLJsJ/OG4Zf/55yh7yvlKB1bqGTLe3DDvVGTduHCXWszEiB7icS9U8yLjU6jVBQ2s1g
         DO6aB9iGvsrPDjaNsGBQrg6yTNaSWrHZJfUQH6JQBrTBDYGz1ZGWm7nDwRz2NkqY4isz
         1rzVMVFSux00pCbXavq1PIKpi3Mgbd0SFvQ0RtD6xSzuOB4F59FJBWEamBpRhvwW7JJv
         Qlmw==
X-Gm-Message-State: AOAM530/y1pkNsm9gC8pim0vmb9f0OjOWXtea0oxgAEVV+KTmjmn9B1b
        tWQRIx2r/LEbSJvOSksYNslYOr8xYh4=
X-Google-Smtp-Source: ABdhPJzTt2Gk3ZbogzBbU/EapdAAHQBzgRRi8qt7Ev5jUraoqfbkujOrIi12dXYm1mpV/ZFFq6+J7Q==
X-Received: by 2002:ac2:51a7:: with SMTP id f7mr9461053lfk.13.1590964639952;
        Sun, 31 May 2020 15:37:19 -0700 (PDT)
Received: from rikard (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id a10sm4043235ljd.126.2020.05.31.15.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 15:37:19 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Mon, 1 Jun 2020 00:37:16 +0200
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
Message-ID: <20200531223716.GA20752@rikard>
References: <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com>
 <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
 <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
 <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
 <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
 <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com>
 <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
 <CAHp75Vdxa1_ANBLEOB6g25x3O0V5h3yjZve8qpz-xkisD3KTLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdxa1_ANBLEOB6g25x3O0V5h3yjZve8qpz-xkisD3KTLg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+ Emil who was working on a patch for this

On Sun, May 31, 2020 at 02:00:45PM +0300, Andy Shevchenko wrote:
> On Sun, May 31, 2020 at 4:11 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > On Sat, May 30, 2020 at 2:50 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sat, May 30, 2020 at 11:45 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > > On Sat, May 30, 2020 at 3:49 AM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> 
> ...
> 
Sorry about that, it seems it's only triggered by gcc-9, that's why I
missed it.

> > #if (l) == 0
> > #define GENMASK_INPUT_CHECK(h, l)  0
> > #elif
> > #define GENMASK_INPUT_CHECK(h, l) \
> >         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> >                 __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > #endif
> >
> > I have verified that this works. Basically this just avoids the sanity
> > check when the 'lower' bound 'l' is zero. Let me know if it looks
> > fine.

I don't understand how you mean this? You can't use l before you have
defined GENMASK_INPUT_CHECK to take l as input? Am I missing something?

How about the following (with an added comment about why the casts are
necessary):

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 4671fbf28842..5fdb9909fbff 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -23,7 +23,7 @@
 #include <linux/build_bug.h>
 #define GENMASK_INPUT_CHECK(h, l) \
        (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
+               __builtin_constant_p((int)(l) > (int)(h)), (int)(l) > (int)(h), 0)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,

I can send a proper patch if this is ok.
> 
> Unfortunately, it's not enough. We need to take care about the following cases

The __GENMASK macro is only valid for values of h and l between 0 and 63
(or 31, if unsigned long is 32 bits). Negative values or values >=
sizeof(unsigned long) (or unsigned long long for GENMASK_ULL) result in
compiler warnings (-Wshift-count-negative or -Wshift-count-overflow). So
when I wrote the GENMASK_INPUT_CHECK macro, the intention was to catch
cases where l and h were swapped and let the existing compiler warnings
catch negative or too large values.

> 1) h or l negative;

Any of these cases will trigger a compiler warning (h negative triggers 
Wshift-count-overflow, l negative triggers Wshift-count-negative).

> 2) h == 0, if l == 0, I dunno what is this. it's basically either 0 or warning;

h == l == 0 is a complicated way of saying 1 (or BIT(0)). l negative
triggers compiler warning.

> 3) l == 0;

if h is negative, compiler warning (see 1). If h == 0, see 2. If h is
positive, there is no error in GENMASK_INPUT_CHECK.

> 4) h and l > 0.

The comparisson works as intended.

> 
> Now, on top of that (since it's a macro) we have to keep in mind that
> h and l can be signed and / or unsigned types.
> And macro shall work for all 4 cases (by type signedess).

If we cast to int, we don't need to worry about the signedness. If
someone enters a value that can't be cast to int, there will still
be a compiler warning about shift out of range.

Rikard

> > Regarding min, max macro that you suggested I am also looking further into it.
> 
> Since this has been introduced in v5.7 and not only your code is
> affected by this I think we need to ping original author either to fix
> or revert.
> 
> So, I Cc'ed to the author and reviewers, because they probably know
> better why that had been done in the first place and breaking existing
> code.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
