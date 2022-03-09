Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0264D2665
	for <lists+linux-arch@lfdr.de>; Wed,  9 Mar 2022 05:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiCICY0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 8 Mar 2022 21:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiCICYZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2022 21:24:25 -0500
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170F0E1B65;
        Tue,  8 Mar 2022 18:23:27 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2dbfe58670cso8316707b3.3;
        Tue, 08 Mar 2022 18:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vRqEX4jehGb8mpHAHZanSBhzpnb3IlnL81jQ2qWnd2E=;
        b=AgTQOJMBWm65wrlgk9F3vl0WIIVs6Ww7J4tQcKQpbJ4oO11NlpztuAdwAzxOrVOCET
         DRSCQ7MkASEWAgWWUxEmsxnSOdKwoXkNcs3wg0chqlcXUziMTW1hkvde8vrHuMTraSvm
         x7RNQU5CXUO0EP5OS1yvN6IvSyrH1MXD4thumq9Fb7Jh1IjTwGggquhPkwQ+f/3j2sJP
         aLBVrqah46iUjU36xtRKUgqv83KvoYi9Zcw0DkJMmIHIcwKVPQBMa2RWJRk2nyGZinIq
         Lr9rOA8+sScj6dNZQTkWQFUA1GxsLZPvbNhZNzPN9OwmXp9qbgFiFxBu9+jUtdDInA1l
         /0hA==
X-Gm-Message-State: AOAM531lhpn0enYcXzo5JHBZbw3mXE5X42ceVg2uxpEZibYAB/ORTjwz
        aCHkSP66oPaVBJnR0mJWXoz2lBoL84B0msWFm7c=
X-Google-Smtp-Source: ABdhPJzj7DyFzASBA892hVXyxQooQWrYYu3TtRehPlG6eBRsdpkOFy6LiFy+Mi6aV/QfgWrM4LUXLXbItwdvbKc6+AU=
X-Received: by 2002:a0d:db09:0:b0:2dc:344f:7944 with SMTP id
 d9-20020a0ddb09000000b002dc344f7944mr15041695ywe.45.1646792606156; Tue, 08
 Mar 2022 18:23:26 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
 <20220308141201.2343757-1-mailhol.vincent@wanadoo.fr> <CAHk-=whvGWbpsTa538CvQ9e=VF+m8WPQmES2y6-=0=-64uGkgg@mail.gmail.com>
In-Reply-To: <CAHk-=whvGWbpsTa538CvQ9e=VF+m8WPQmES2y6-=0=-64uGkgg@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 9 Mar 2022 11:23:15 +0900
Message-ID: <CAMZ6RqJ5Pyup4RgjMA5fG5Lt4tpA_tvv61snpKbF4DJAkPzdAg@mail.gmail.com>
Subject: Re: [PATCH v2] linux/bits.h: GENMASK_INPUT_CHECK: reduce W=2 noise by
 31% treewide
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

On Wed. 9 Mar 2022 at 03:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Mar 8, 2022 at 6:12 AM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> > This patch silences a -Wtypes-limits warning in GENMASK_INPUT_CHECK()
> > which is accountable for 31% of all warnings when compiling with W=2.
>
> Please, just make the patch be "remote -Wtypes-limits".

After this patch, the number of remaining -Wtype-limits drops by
99.7% from 164714 to only 431 for an allyesconfig (some of which
could be true positives). So I am inclined to keep
-Wtype-limits at W=2 because it still catches some relevant
issues. Aside from the issue pointed out here, it is not a hindrance.

> Instead of making an already complicated check more complicated, and
> making it more fragile.

ACK, this patch makes it more complicated. About making it more
fragile, lib/test_bits.c is here to catch issues and this patch
passes those tests including the TEST_GENMASK_FAILURES.

> I don't see why that int cast on h would be valid, for example. Why
> just h?

The compiler only complains on ((unsigned int)foo > 0) patterns,
i.e. when h is unsigned and l is zero. The signness of l is not relevant
here.

> And should you not then check that the cast doesn't actually
> change the value?

The loss of precision only occurs on big values
e.g. GENMASK(UINT_MAX + 1, 0).

GENMASK (and GENMASK_ULL) already requires h and l to be between
0 and 31 (or 63). Out of band positive values are caught by
-Wshift-count-overflow (and negative values by
-Wshift-count-negative).

So the use cases in which the int cast would change h value are
already caught elsewhere.

> But the basic issue is that the compiler warns about bad things, and
> the problem isn't the code, but the compiler.

ACK, the code is not broken, the compiler is guilty. I tend to
agree to the rule "if not broken, don’t fix", but I consider this
patch to be *the exception* because of the outstanding level of
noise generated here.

If my message did not convince you, then I am fine to move
-Wtypes-limits from W=2 to W=3 as a compromise. But this is not
my preferred solution because some -Wtypes-limits warnings are
useful.


Yours sincerely,
Vincent Mailhol
