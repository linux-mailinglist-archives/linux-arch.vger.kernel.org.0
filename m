Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66371F139C
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jun 2020 09:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgFHHdS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Jun 2020 03:33:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40808 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbgFHHdS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2020 03:33:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id s13so12843918otd.7;
        Mon, 08 Jun 2020 00:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0pDWBHAPx+7BsUGPboybuFRpJCeYypkd7+L0T1+1hA=;
        b=oZJFmRsqkC7WVTHqG37nSrj9cpZvlLLmeRnii8D45+r9WBxgzLzEIKzacBiGOC+xSc
         7QLSX3Aet+6nV/MxcVW0IQc0cc/GuJTaw+XDGJLstyqFIKmqZuxCZaFsFAcg7ZLVb8fO
         HES2ogGz5Bq5SQFVL1ICq+ghpGrVjZvO0Bz1qicIsd7QhXwD/vzPfmbTIyS+W6/nBGQx
         MIIml8uCZ/jFFpLH4COlBShjagMPW1Js/J3rWN89i2weyumVGFL6lvhzXNmr+WaT8KlT
         1utWOQX8NZ6BjEKnfdLEnU0Zkc/BFdmO3wyyP6j7nZXXavnjQhREJK8/6+BEte40a18V
         HQBg==
X-Gm-Message-State: AOAM530gwEGePNLYuJZxwcfPChzmudmm7VD0yI78xPheMv3GAc4ovHbb
        uGEksWUWsvehUNIk/or9zUs0stPklsOOTLODtgo=
X-Google-Smtp-Source: ABdhPJx/fhLXlHeev7ggIXtVp/AlQjYjBTTRXtndVnos9jVKuUhGarboOoPZ+V1D54NOAlAJ4cBMQFBAGRyZ+MtbXFo=
X-Received: by 2002:a9d:c29:: with SMTP id 38mr15586831otr.107.1591601597506;
 Mon, 08 Jun 2020 00:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200604233003.GA102768@rikard> <20200607203411.70913-1-rikard.falkeborn@gmail.com>
 <20200607203411.70913-2-rikard.falkeborn@gmail.com>
In-Reply-To: <20200607203411.70913-2-rikard.falkeborn@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Jun 2020 09:33:05 +0200
Message-ID: <CAMuHMdVm_ptUipb==jt1aL4RLcRU=OHawV1j4xfB1_z7S-FPxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bits: Add tests of GENMASK
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, emil.l.velikov@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>, syednwaris@gmail.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Richard,

Thanks for your patch!

On Sun, Jun 7, 2020 at 10:35 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
> Add tests of GENMASK and GENMASK_ULL.
>
> A few test cases that should fail compilation are provided under ifdef.

It doesn't hurt to mention the name of the #ifdef here.

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

> --- /dev/null
> +++ b/lib/test_bits.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Test cases for functions and macrso in bits.h
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/bits.h>
> +
> +
> +void genmask_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_EQ(test, 1ul, GENMASK(0, 0));
> +       KUNIT_EXPECT_EQ(test, 3ul, GENMASK(1, 0));
> +       KUNIT_EXPECT_EQ(test, 6ul, GENMASK(2, 1));
> +       KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, GENMASK(31, 0));
> +
> +#ifdef TEST_BITS_COMPILE

"#ifdef TEST_GENMASK_FAILURES"?

> +       /* these should fail compilation */
> +       GENMASK(0, 1);
> +       GENMASK(0, 10);
> +       GENMASK(9, 10);
> +#endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
