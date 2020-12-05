Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02962CF853
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 01:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbgLEArR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 19:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbgLEArP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2020 19:47:15 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E57DC0613D1;
        Fri,  4 Dec 2020 16:45:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 91so3020000wrj.7;
        Fri, 04 Dec 2020 16:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4y0JkK87pr/s4rpJSER/aDqi0itsiFuRSiZeqWxkr8=;
        b=npqEN6qcdTzKfW+1iFnJ1BBHcACgWp3Y6/ex+xeWO8fQzc8HMqej6i5f41MShCfU0v
         AJymIcAu0zSqSBOgV45QKMTKj9S0fU9Ha+CXmA1PYifokZhiFwyXLtugDWTphZ7ZFt31
         VnymZfSoW8mysN9J+s5ngYO0pAiCJGHUE3SSQLSvig4BaTreFM9hwZGHbFbgkHjAlHwf
         raEiHqczuLB1Rg/hQjRAZcalksJcrW74aCWDgOl6nhX41SU1bXy0ZwigBzI5vZBA7N2I
         RcywB8Ov4Q6qJOuSspNbgQs85TNEx2bOYqHqIl/Ew73bzthrjimP9uVHpuV29oYP6aLI
         VUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4y0JkK87pr/s4rpJSER/aDqi0itsiFuRSiZeqWxkr8=;
        b=JH6ILP+x57ggZ8Dca32g+rEr1HjzsDYMHiGml740G1EQdCO4Ceb9hbU8K5xUbV1cw2
         iwx0qwkK8oLmbBApqjEGG1flOlremawLUvKzpIFy3xc+FmqV0DnLjPSlMkNG7uK+ubdd
         rWn8WDCTkuAofmbG/nLBAojTFvgqkf+7RBzD8fVrPTI7TRU0D3HCFts9XptXUfhhnXO5
         HMOZ1JsTlEVzClxHURIyXvHFkZ1I7YowrcK9dNFARxyw4+C4v3zI3u2m4un7hqGFBgFb
         q7XaHL5KiRzao5+pU4vvMs2jg7sASMKibi/JejnvM5BKtppR/X6/ezBNSgaWAyshQkjg
         y6hQ==
X-Gm-Message-State: AOAM530hS/npubelcXV3VdGz4zEYBZBWr+lk7wNnozErL0Kw4wMi0sF8
        neNye57ZwTa94b4qT4kpo3eoJ9TyOBBKazJq4EI=
X-Google-Smtp-Source: ABdhPJwqb8RlLByNQh6tNTfWLQ89XsV1R4UW1RegIowjvLQlgunW/lPpwWu/sCuS+p7higF45dCSSx3gulic2gX2aQM=
X-Received: by 2002:adf:bd84:: with SMTP id l4mr7865348wrh.41.1607129138643;
 Fri, 04 Dec 2020 16:45:38 -0800 (PST)
MIME-Version: 1.0
References: <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
 <CAM7-yPTsy+wJO8oQ7srjiXk+VjFFSUdJfdnVx9Ma_H8jJJnZKA@mail.gmail.com>
 <CAAH8bW-jUeFVU-0OrJzK-MuGgKJgZv38RZugEQzFRJHSXFRRDA@mail.gmail.com>
 <CAM7-yPRBPP6SFzdmwWF5Y99g+aWcp=OY9Uvp-5h1MSDPmsORNw@mail.gmail.com>
 <CAAH8bW-+XnNsd9p3xZ1utmyY24gaBa0ko4tngBii4T+2cMkcYg@mail.gmail.com>
 <CAM7-yPQCWj6rOyLEgOqF3HGkFV1WKtqyVhEtDbS3HW=2A-HuBA@mail.gmail.com>
 <CAM7-yPTtiVnUztE=xpNYgRcZTGd1aX_V9ZHd=2YZYc1uQNBXtw@mail.gmail.com>
 <a0cc0d2e-9c55-8546-f070-26feed5de37f@rasmusvillemoes.dk> <CAM7-yPQrvYUwX-cbgpzhomCTFEi9sQ9iGuLNcL-Fsj7XZ0knhw@mail.gmail.com>
 <CAAH8bW9=J_now4SU=-WzvBOa=ftStgGVpspyw_g7oafbuNHNHQ@mail.gmail.com>
 <20201203185257.GA29072@1wt.eu> <CAM7-yPQiG-akz6SC3m4oPGDMyOq4p8-yf8Kh+pumCoqvWY4w9w@mail.gmail.com>
 <CAAH8bW_5z8PF4xRtMzG3sNbxAR10rwY=7ftL_E2K-TxzNtnarA@mail.gmail.com>
In-Reply-To: <CAAH8bW_5z8PF4xRtMzG3sNbxAR10rwY=7ftL_E2K-TxzNtnarA@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Sat, 5 Dec 2020 09:45:25 +0900
Message-ID: <CAM7-yPRGBGLRmCg3VZG3uCYLe8CJx+M_pP1yr8JZVhgTfXU=yA@mail.gmail.com>
Subject: Re:
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, dushistov@mail.ru,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> I answer again. It's better not to write find_prev_bit at all and
> learn how to use existing functionality.

Thanks for the answer I'll fix and send the patch again :)

On Sat, Dec 5, 2020 at 3:14 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 5:36 PM Yun Levi <ppbuk5246@gmail.com> wrote:
> >
> > >On Fri, Dec 4, 2020 at 3:53 AM Willy Tarreau <w@1wt.eu> wrote:
> > >
> > > On Thu, Dec 03, 2020 at 10:46:25AM -0800, Yury Norov wrote:
> > > > Yun, could you please stop top-posting and excessive trimming in the thread?
> > >
> > > And re-configure the mail agent to make the "Subject" field appear and
> > > fill it.
> >
> > >On Thu, Dec 03, 2020 at 10:46:25AM -0800, Yury Norov wrote:
> > > Yun, could you please stop top-posting and excessive trimming in the thread?
> > Sorry to make you uncomfortable... Thanks for advice.
> >
> > >On Thu, Dec 03, 2020 at 10:46:25AM -0800, Yury Norov wrote:
> > > As you said, find_last_bit() and proposed find_prev_*_bit() have the
> > > same functionality.
> > > If you really want to have find_prev_*_bit(), could you please at
> > > least write it using find_last_bit(), otherwise it would be just a
> > > blottering.
> >
> > Actually find_prev_*_bit call _find_prev_bit which is a common helper function
> > like _find_next_bit.
> > As you know this function is required to support __BIGEDIAN's little
> > endian search.
> > find_prev_bit actually wrapper of _find_prev_bit which have a feature
> > the find_last_bit.
> >
> > That makes the semantics difference between find_last_bit and find_prev_bit.
> > -- specify where you find from and
> >    In loop, find_last_bit couldn't sustain original size as sentinel
> > return value
> >     (we should change the size argument for next searching
> >      But it means whenever we call, "NOT SET or NOT CLEAR"'s sentinel
> > return value is changed per call).
> >
> > Because we should have _find_prev_bit,
> > I think it's the matter to choose which is better to usein
> > find_prev_bit (find_last_bit? or _find_prev_bit?)
> > sustaining find_prev_bit feature (give size as sentinel return, from
> > where I start).
> > if my understanding is correct.
> >
> > In my view, I prefer to use _find_prev_bit like find_next_bit for
> > integrated format.
> >
> > But In some of the benchmarking, find_last_bit is better than _find_prev_bit,
> > here what I tested (look similar but sometimes have some difference).
> >
> >               Start testing find_bit() with random-filled bitmap
> > [  +0.001850] find_next_bit:                  842792 ns, 163788 iterations
> > [  +0.000873] find_prev_bit:                  870914 ns, 163788 iterations
> > [  +0.000824] find_next_zero_bit:             821959 ns, 163894 iterations
> > [  +0.000677] find_prev_zero_bit:             676240 ns, 163894 iterations
> > [  +0.000777] find_last_bit:                  659103 ns, 163788 iterations
> > [  +0.001822] find_first_bit:                1708041 ns,  16250 iterations
> > [  +0.000539] find_next_and_bit:              492182 ns,  73871 iterations
> > [  +0.000001]
> >               Start testing find_bit() with sparse bitmap
> > [  +0.000222] find_next_bit:                   13227 ns,    654 iterations
> > [  +0.000013] find_prev_bit:                   11652 ns,    654 iterations
> > [  +0.001845] find_next_zero_bit:            1723869 ns, 327028 iterations
> > [  +0.001538] find_prev_zero_bit:            1355808 ns, 327028 iterations
> > [  +0.000010] find_last_bit:                    8114 ns,    654 iterations
> > [  +0.000867] find_first_bit:                 710639 ns,    654 iterations
> > [  +0.000006] find_next_and_bit:                4273 ns,      1 iterations
> > [  +0.000004] find_next_and_bit:                3278 ns,      1 iterations
> >
> >               Start testing find_bit() with random-filled bitmap
> > [  +0.001784] find_next_bit:                  805553 ns, 164240 iterations
> > [  +0.000643] find_prev_bit:                  632474 ns, 164240 iterations
> > [  +0.000950] find_next_zero_bit:             877215 ns, 163442 iterations
> > [  +0.000664] find_prev_zero_bit:             662339 ns, 163442 iterations
> > [  +0.000680] find_last_bit:                  602204 ns, 164240 iterations
> > [  +0.001912] find_first_bit:                1758208 ns,  16408 iterations
> > [  +0.000760] find_next_and_bit:              531033 ns,  73798 iterations
> > [  +0.000002]
> >               Start testing find_bit() with sparse bitmap
> > [  +0.000203] find_next_bit:                   12468 ns,    656 iterations
> > [  +0.000205] find_prev_bit:                   10948 ns,    656 iterations
> > [  +0.001759] find_next_zero_bit:            1579447 ns, 327026 iterations
> > [  +0.001935] find_prev_zero_bit:            1931961 ns, 327026 iterations
> > [  +0.000013] find_last_bit:                    9543 ns,    656 iterations
> > [  +0.000732] find_first_bit:                 562009 ns,    656 iterations
> > [  +0.000217] find_next_and_bit:                6804 ns,      1 iterations
> > [  +0.000007] find_next_and_bit:                4367 ns,      1 iterations
> >
> > Is it better to write find_prev_bit using find_last_bit?
> > I question again.
>
> I answer again. It's better not to write find_prev_bit at all and
> learn how to use existing functionality.
>
> Yury
>
> > Thanks for your great advice, But please forgive my fault and lackness.
> >
> > HTH.
> > Levi.
