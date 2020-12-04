Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182D62CF3C1
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 19:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgLDSPL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 13:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbgLDSPK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2020 13:15:10 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637E9C061A51;
        Fri,  4 Dec 2020 10:14:30 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p187so6684498iod.4;
        Fri, 04 Dec 2020 10:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZeqAUwb1qImEM55Z2Q5iwzyPLoi4IGltZ9uy0XSgvoA=;
        b=DlxWxXTxSYoXlBMigwU9B7eSF8h3U64mEFRGgpuxWyB4tnqbnqmiTbOnkvHs0Z6se7
         jLnGGuLmQiJyPJuDlepCLa1x8ZyUoeZSvy/wil1e6LGz0pcIZKuArtn23x24A4Ybtkmy
         RZtFfvCshYH9+wfi8v4a8+FneVH/6GPjLEXjLECuYuThnkA6aopWJJkTGV2p1r3KPfXw
         xe4g4MPZUmPzQMPGs+udzJy2e2fokQoOKoPGry067tuS9untKTQhOCQN0fpB84F3BHp4
         Xpc14uYkowTJcKvULWj/75MEsUguj8mbADMoDfE0BIEq/H7Wg9JIaChP2kj+RM+Budw0
         FvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZeqAUwb1qImEM55Z2Q5iwzyPLoi4IGltZ9uy0XSgvoA=;
        b=Q+/bHKkTRapwIaiiXPnT0MIYxo/Wb0UHBE9hKUzgTqqksa4O8XLPSCIKM9z+acQtGA
         ZYicKSJkUJMbuzEriOx9EAvxfhd4OZjInr9OJTkBQPiBgxvtHqAbzhgDxcr+LJu8BZ2J
         qPQU9BcOR7cm33SpIhorKfougLNcINkuJuQo5dDXaWaDh71CjOJ2NPJCEgc7QVZIbxC9
         uFxCkqTE8+UVumjvRrX1VxZCkUL9BW8PPRay5PYTQ1MBQXVYeiPQ5K+ZeIH6EaBSXAUt
         A7C24GHB+jMZUj5QO4q6P0AHTBF7K5m5jalLwC8qWwGvHBYaIg+wCdrwt5Vs56KCPX+o
         xs+g==
X-Gm-Message-State: AOAM530E79d/rZCte8o/B7wqHsa7MSb41G4YBXHpfmReJrJKw8e509hg
        6K89RR+vZpxP7fS45KyYBWvnfhlUnMtXTO/P5Nw=
X-Google-Smtp-Source: ABdhPJyiLv+RkBFHWodIIQ+ZNqmMQGrQT1sE2/YwhYnMpKB7HGd/1Sg3rmhYEkgkXI0r/RcV6ca2JvZ1MsFOWbfn4g8=
X-Received: by 2002:a5e:aa0d:: with SMTP id s13mr2476177ioe.210.1607105669604;
 Fri, 04 Dec 2020 10:14:29 -0800 (PST)
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
In-Reply-To: <CAM7-yPQiG-akz6SC3m4oPGDMyOq4p8-yf8Kh+pumCoqvWY4w9w@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Fri, 4 Dec 2020 10:14:18 -0800
Message-ID: <CAAH8bW_5z8PF4xRtMzG3sNbxAR10rwY=7ftL_E2K-TxzNtnarA@mail.gmail.com>
Subject: Re:
To:     Yun Levi <ppbuk5246@gmail.com>
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

On Thu, Dec 3, 2020 at 5:36 PM Yun Levi <ppbuk5246@gmail.com> wrote:
>
> >On Fri, Dec 4, 2020 at 3:53 AM Willy Tarreau <w@1wt.eu> wrote:
> >
> > On Thu, Dec 03, 2020 at 10:46:25AM -0800, Yury Norov wrote:
> > > Yun, could you please stop top-posting and excessive trimming in the thread?
> >
> > And re-configure the mail agent to make the "Subject" field appear and
> > fill it.
>
> >On Thu, Dec 03, 2020 at 10:46:25AM -0800, Yury Norov wrote:
> > Yun, could you please stop top-posting and excessive trimming in the thread?
> Sorry to make you uncomfortable... Thanks for advice.
>
> >On Thu, Dec 03, 2020 at 10:46:25AM -0800, Yury Norov wrote:
> > As you said, find_last_bit() and proposed find_prev_*_bit() have the
> > same functionality.
> > If you really want to have find_prev_*_bit(), could you please at
> > least write it using find_last_bit(), otherwise it would be just a
> > blottering.
>
> Actually find_prev_*_bit call _find_prev_bit which is a common helper function
> like _find_next_bit.
> As you know this function is required to support __BIGEDIAN's little
> endian search.
> find_prev_bit actually wrapper of _find_prev_bit which have a feature
> the find_last_bit.
>
> That makes the semantics difference between find_last_bit and find_prev_bit.
> -- specify where you find from and
>    In loop, find_last_bit couldn't sustain original size as sentinel
> return value
>     (we should change the size argument for next searching
>      But it means whenever we call, "NOT SET or NOT CLEAR"'s sentinel
> return value is changed per call).
>
> Because we should have _find_prev_bit,
> I think it's the matter to choose which is better to usein
> find_prev_bit (find_last_bit? or _find_prev_bit?)
> sustaining find_prev_bit feature (give size as sentinel return, from
> where I start).
> if my understanding is correct.
>
> In my view, I prefer to use _find_prev_bit like find_next_bit for
> integrated format.
>
> But In some of the benchmarking, find_last_bit is better than _find_prev_bit,
> here what I tested (look similar but sometimes have some difference).
>
>               Start testing find_bit() with random-filled bitmap
> [  +0.001850] find_next_bit:                  842792 ns, 163788 iterations
> [  +0.000873] find_prev_bit:                  870914 ns, 163788 iterations
> [  +0.000824] find_next_zero_bit:             821959 ns, 163894 iterations
> [  +0.000677] find_prev_zero_bit:             676240 ns, 163894 iterations
> [  +0.000777] find_last_bit:                  659103 ns, 163788 iterations
> [  +0.001822] find_first_bit:                1708041 ns,  16250 iterations
> [  +0.000539] find_next_and_bit:              492182 ns,  73871 iterations
> [  +0.000001]
>               Start testing find_bit() with sparse bitmap
> [  +0.000222] find_next_bit:                   13227 ns,    654 iterations
> [  +0.000013] find_prev_bit:                   11652 ns,    654 iterations
> [  +0.001845] find_next_zero_bit:            1723869 ns, 327028 iterations
> [  +0.001538] find_prev_zero_bit:            1355808 ns, 327028 iterations
> [  +0.000010] find_last_bit:                    8114 ns,    654 iterations
> [  +0.000867] find_first_bit:                 710639 ns,    654 iterations
> [  +0.000006] find_next_and_bit:                4273 ns,      1 iterations
> [  +0.000004] find_next_and_bit:                3278 ns,      1 iterations
>
>               Start testing find_bit() with random-filled bitmap
> [  +0.001784] find_next_bit:                  805553 ns, 164240 iterations
> [  +0.000643] find_prev_bit:                  632474 ns, 164240 iterations
> [  +0.000950] find_next_zero_bit:             877215 ns, 163442 iterations
> [  +0.000664] find_prev_zero_bit:             662339 ns, 163442 iterations
> [  +0.000680] find_last_bit:                  602204 ns, 164240 iterations
> [  +0.001912] find_first_bit:                1758208 ns,  16408 iterations
> [  +0.000760] find_next_and_bit:              531033 ns,  73798 iterations
> [  +0.000002]
>               Start testing find_bit() with sparse bitmap
> [  +0.000203] find_next_bit:                   12468 ns,    656 iterations
> [  +0.000205] find_prev_bit:                   10948 ns,    656 iterations
> [  +0.001759] find_next_zero_bit:            1579447 ns, 327026 iterations
> [  +0.001935] find_prev_zero_bit:            1931961 ns, 327026 iterations
> [  +0.000013] find_last_bit:                    9543 ns,    656 iterations
> [  +0.000732] find_first_bit:                 562009 ns,    656 iterations
> [  +0.000217] find_next_and_bit:                6804 ns,      1 iterations
> [  +0.000007] find_next_and_bit:                4367 ns,      1 iterations
>
> Is it better to write find_prev_bit using find_last_bit?
> I question again.

I answer again. It's better not to write find_prev_bit at all and
learn how to use existing functionality.

Yury

> Thanks for your great advice, But please forgive my fault and lackness.
>
> HTH.
> Levi.
