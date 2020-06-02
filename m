Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954871EC248
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jun 2020 21:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgFBTBp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Jun 2020 15:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBTBo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2020 15:01:44 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8780C08C5C0;
        Tue,  2 Jun 2020 12:01:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m18so13921523ljo.5;
        Tue, 02 Jun 2020 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YWq/x05MQc6IbPohW5E+6GnnmsE60aX1v6C+jGwg3BE=;
        b=uRIcabU/K5MiAlHjLpzZpWk66ZOe+VvQI4kjUFAHBKOVKIxn9AWH6DSWv1dQaPRi12
         r2jrObnxLi9UskXv3H7hhEjUDc2fYVehhLRBl9i+Y8V1kZkWrG8V9QqHNebkkWGQ9gFM
         0xYS+MqDcTIYxgo5vW96wutF6dWmVzE46pjAJtPxrtgSGXHDHw3WEXQkwnJm8+xxcKyB
         ILPOksYH4K6DaU9/hACvuoPFrTPDvg9hvj/1ovk4sG3h8s60Q/bUX6xhEt+BD5NN0LVm
         SJVLI4bOJHH3//TBpJ3psFUIAx1xDOErx++m8BYZmyzVFSvdT/W/F7vmXKpz1xvvuqSx
         srOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YWq/x05MQc6IbPohW5E+6GnnmsE60aX1v6C+jGwg3BE=;
        b=KLRn6jiAz6b3+RL3EKNFH6rGGLwEnvjvV2mpoeknV+1g5I7PyBs+5bagQ1u7JildCH
         TOdoQwgca8+jcvFRUblbeGN+LAXoKzeViQbIGUMRuvFbfa/h8c1XweJRUOlT1QdehIAb
         xEyzZsxw/Bd2i97wGQ0cbZEsQUXjcJXk+vcdH5Np8FT3q62gQOV/5J7rG8jNlbGh0V9T
         1eS9Oc/zhDHZMhOr6ZLqKjM3emT8TxrfO8EF0QHhEBvOspM0sjXA+c44NHFm2srUFXWG
         zqJXZ+WQd3Bl9qvzQre10hNWYNM8if/c5ADQqgK+erg4mb0Vb8pw7U9vLBIv4NyDSWTv
         zCKg==
X-Gm-Message-State: AOAM530avsVF67yfAggEs2BZWcH7eZbHjCuZFLuRahf8HMJQeajEJ6TK
        mhv82oqOh3flnII5nEl9jFM=
X-Google-Smtp-Source: ABdhPJzfJ/PMHA/Pav2ioZ6zdPvYtWclCrUcnwqgz87dVGTuveVsFoKyAJT42aBqV0dn7S10CBmYHg==
X-Received: by 2002:a2e:9055:: with SMTP id n21mr228737ljg.217.1591124501247;
        Tue, 02 Jun 2020 12:01:41 -0700 (PDT)
Received: from rikard (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id w17sm679159ljj.108.2020.06.02.12.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 12:01:40 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Tue, 2 Jun 2020 21:01:36 +0200
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
Message-ID: <20200602190136.GA913@rikard>
References: <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
 <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
 <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com>
 <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
 <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com>
 <CACG_h5p1UpLRoA+ubE4NTFQEvg-oT6TFmsLXXTAtBvzN9z3iPg@mail.gmail.com>
 <CAHp75Vdxa1_ANBLEOB6g25x3O0V5h3yjZve8qpz-xkisD3KTLg@mail.gmail.com>
 <20200531223716.GA20752@rikard>
 <20200601083330.GB1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601083330.GB1634618@smile.fi.intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 01, 2020 at 11:33:30AM +0300, Andy Shevchenko wrote:
> On Mon, Jun 01, 2020 at 12:37:16AM +0200, Rikard Falkeborn wrote:
> > + Emil who was working on a patch for this
> > 
> > On Sun, May 31, 2020 at 02:00:45PM +0300, Andy Shevchenko wrote:
> > > On Sun, May 31, 2020 at 4:11 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > > On Sat, May 30, 2020 at 2:50 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Sat, May 30, 2020 at 11:45 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> > > > > > On Sat, May 30, 2020 at 3:49 AM Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com> wrote:
> > > 
> > > ...
> > > 
> > Sorry about that, it seems it's only triggered by gcc-9, that's why I
> > missed it.
> 
> I guess every compiler (more or less recent) will warn here.
> (Sorry, there is a cut in the thread, the problem is with comparison unsigned
>  type(s) to 0).
> 
> > > > #if (l) == 0
> > > > #define GENMASK_INPUT_CHECK(h, l)  0
> > > > #elif
> > > > #define GENMASK_INPUT_CHECK(h, l) \
> > > >         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > > >                 __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > > > #endif
> > > >
> > > > I have verified that this works. Basically this just avoids the sanity
> > > > check when the 'lower' bound 'l' is zero. Let me know if it looks
> > > > fine.
> > 
> > I don't understand how you mean this? You can't use l before you have
> > defined GENMASK_INPUT_CHECK to take l as input? Am I missing something?
> > 
> > How about the following (with an added comment about why the casts are
> > necessary):
> > 
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > index 4671fbf28842..5fdb9909fbff 100644
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -23,7 +23,7 @@
> >  #include <linux/build_bug.h>
> >  #define GENMASK_INPUT_CHECK(h, l) \
> >         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > -               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > +               __builtin_constant_p((int)(l) > (int)(h)), (int)(l) > (int)(h), 0)))
> >  #else
> >  /*
> >   * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> > 
> > I can send a proper patch if this is ok.
> > > 
> > > Unfortunately, it's not enough. We need to take care about the following cases
> > 
> > The __GENMASK macro is only valid for values of h and l between 0 and 63
> > (or 31, if unsigned long is 32 bits). Negative values or values >=
> > sizeof(unsigned long) (or unsigned long long for GENMASK_ULL) result in
> > compiler warnings (-Wshift-count-negative or -Wshift-count-overflow). So
> > when I wrote the GENMASK_INPUT_CHECK macro, the intention was to catch
> > cases where l and h were swapped and let the existing compiler warnings
> > catch negative or too large values.
> 
> GENAMSK sometimes is used with non-constant arguments that's why your check
> made a regression.
> 
> What I described below are the cases to consider w/o what should we do. What
> you answered is the same what I implied. So, we are on the same page here.
> 
> > > 1) h or l negative;
> > 
> > Any of these cases will trigger a compiler warning (h negative triggers 
> > Wshift-count-overflow, l negative triggers Wshift-count-negative).
> > 
> > > 2) h == 0, if l == 0, I dunno what is this. it's basically either 0 or warning;
> > 
> > h == l == 0 is a complicated way of saying 1 (or BIT(0)). l negative
> > triggers compiler warning.
> 
> Oh, yes GENMASK(h, l), when h==l==0 should be equivalent to BIT(0) with no
> warning given.
> 
> > > 3) l == 0;
> > 
> > if h is negative, compiler warning (see 1). If h == 0, see 2. If h is
> > positive, there is no error in GENMASK_INPUT_CHECK.
> > 
> > > 4) h and l > 0.
> > 
> > The comparisson works as intended.
> 
> > > Now, on top of that (since it's a macro) we have to keep in mind that
> > > h and l can be signed and / or unsigned types.
> > > And macro shall work for all 4 cases (by type signedess).
> > 
> > If we cast to int, we don't need to worry about the signedness. If
> > someone enters a value that can't be cast to int, there will still
> > be a compiler warning about shift out of range.
> 
> If the argument unsigned long long will it be the warning (it should not)?

No, there should be no warning there.

The inputs to GENMASK() needs to be between 0 and 31 (or 63 depending on the
size of unsigned long). For any other values, there will be undefined behaviour,
since the operands to the shifts in __GENMASK will be too large (or negative).

Rikard

> 
> > > > Regarding min, max macro that you suggested I am also looking further into it.
> > > 
> > > Since this has been introduced in v5.7 and not only your code is
> > > affected by this I think we need to ping original author either to fix
> > > or revert.
> > > 
> > > So, I Cc'ed to the author and reviewers, because they probably know
> > > better why that had been done in the first place and breaking existing
> > > code.
> 
> Please, when you do something there, add a test case to test_bitops.c.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
