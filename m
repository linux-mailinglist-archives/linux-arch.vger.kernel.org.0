Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6872F1F3DAA
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 16:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgFIOLh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jun 2020 10:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbgFIOLh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2020 10:11:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B39AC05BD1E;
        Tue,  9 Jun 2020 07:11:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id m2so1466162pjv.2;
        Tue, 09 Jun 2020 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbjkRUfSxpIRE9L5muPwAXEXsssIxPhz/mzHngdljkU=;
        b=sRpl8CGOWQm3GO7DaHHkPpb/9FpBaD4iVeWbMU4EydSBchwheAOtjl940fZFnh+RYi
         NDzYwvO9oCwAIROiyKkXSzkOCDrWcifDn4ds6T/3T8s355i+4RGCs790Cc6UcBdj+vRS
         AmbzjJ9P9RBfiLv2Omhce9haa2cEOi/zGQ5x69bAf/fef5sxQ2Up3NkTnw8CMA6KhfZX
         wXMCTphw/EwBGAzXHla+rH5idT9EChPwsYNT/LeBp0pCUlxybyc3Nkd/BvUgc37N6OLQ
         2dN8KWWyuaqJTuSG9fte5JdVsiNnu8usZHSG+UzZynbk21GI0xYrpdRVzYsU9vfmN55a
         xDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbjkRUfSxpIRE9L5muPwAXEXsssIxPhz/mzHngdljkU=;
        b=noQ1JBqKLCbSOQxDg4d6uIfjRG4jPhnhpZof4YA8bEfoVj3vtjtkhIwZ0Q0aHK3+Nq
         ikdYmsqUNusWNIXwPl8jGwxOEDFPMIOQ+/2eShYkVjAAchucBrEPfknFcX7iWHbnkiXB
         8c1h1X7eh1tSn3ouWiQBQlkMPbwEkfrAez3KTJbdKrkobPVs9F9ZMXxguqiGzvNf+tFr
         asrlZzvHxtXsX78jG+WVmObrOiaPx40Vqh8L9U3kJsJfq/8PvJSvWESE8CgR29qS9OXt
         80icqrNxa63n86UklOI7WFr1TQvFepZVsoMv4zo8gk78pqfvvdsDRGodAfcJzmTWACvy
         75YA==
X-Gm-Message-State: AOAM5333iiL+wZIOhhQYEjdgxjh8+IBxUDDweOV/OFxyi5FrHNU0eXoS
        zD7lDf6Xc2nhx3zoQ10Jsaq1B2lHR6VHFqEqwNbwHmjX+P0L6A==
X-Google-Smtp-Source: ABdhPJydk5VqnSyXHiOiGowirvy31UTQ1SVtGHfwpdnmnMK0c1HE6VTY0bKT0gf1ey2haF1RJyvCZgfCn7pYMKIXHOA=
X-Received: by 2002:a17:90a:220f:: with SMTP id c15mr5287273pje.129.1591711896706;
 Tue, 09 Jun 2020 07:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200608184222.GA899@rikard> <20200608221823.35799-1-rikard.falkeborn@gmail.com>
 <20200608221823.35799-2-rikard.falkeborn@gmail.com>
In-Reply-To: <20200608221823.35799-2-rikard.falkeborn@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Jun 2020 17:11:24 +0300
Message-ID: <CAHp75VeMDkZjd1d8nTYRk8duJ4mR0NxqYhqOmuqAjcJk8K2hzg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] bits: Add tests of GENMASK
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 9, 2020 at 1:18 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Add tests of GENMASK and GENMASK_ULL.
>
> A few test cases that should fail compilation are provided
> under #ifdef TEST_GENMASK_FAILURES
>

LGTM, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> I did not move it to test_bitops.c, because I think it makes more sense
> that test_bitops.c tests bitops.h and test_bits.c tests bits.h, but if
> you disagree, I can move it.

We could do it later and actually other way around, since you are
using KUnit, while the test_bitops.h doesn't.

>
> v2-v3
> Updated commit message and ifdef after suggestion fron Geert. Also fixed
> a typo in the description of the file.
>
> v1-v2
> New patch.
>
>  lib/Kconfig.debug | 11 +++++++
>  lib/Makefile      |  1 +
>  lib/test_bits.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 lib/test_bits.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 333e878d8af9..9557cb570fb9 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2182,6 +2182,17 @@ config LINEAR_RANGES_TEST
>
>           If unsure, say N.
>
> +config BITS_TEST
> +       tristate "KUnit test for bits.h"
> +       depends on KUNIT
> +       help
> +         This builds the bits unit test.
> +         Tests the logic of macros defined in bits.h.
> +         For more information on KUnit and unit tests in general please refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +         If unsure, say N.
> +
>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/Makefile b/lib/Makefile
> index 315516fa4ef4..2ce9892e3e63 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -314,3 +314,4 @@ obj-$(CONFIG_OBJAGG) += objagg.o
>  # KUnit tests
>  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
> +obj-$(CONFIG_BITS_TEST) += test_bits.o
> diff --git a/lib/test_bits.c b/lib/test_bits.c
> new file mode 100644
> index 000000000000..e2fcf24463bf
> --- /dev/null
> +++ b/lib/test_bits.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Test cases for functions and macros in bits.h
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
> +#ifdef TEST_GENMASK_FAILURES
> +       /* these should fail compilation */
> +       GENMASK(0, 1);
> +       GENMASK(0, 10);
> +       GENMASK(9, 10);
> +#endif
> +
> +
> +}
> +
> +void genmask_ull_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_EQ(test, 1ull, GENMASK_ULL(0, 0));
> +       KUNIT_EXPECT_EQ(test, 3ull, GENMASK_ULL(1, 0));
> +       KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_ULL(39, 21));
> +       KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_ULL(63, 0));
> +
> +#ifdef TEST_GENMASK_FAILURES
> +       /* these should fail compilation */
> +       GENMASK_ULL(0, 1);
> +       GENMASK_ULL(0, 10);
> +       GENMASK_ULL(9, 10);
> +#endif
> +}
> +
> +void genmask_input_check_test(struct kunit *test)
> +{
> +       unsigned int x, y;
> +       int z, w;
> +
> +       /* Unknown input */
> +       KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, 0));
> +       KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, x));
> +       KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(x, y));
> +
> +       KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, 0));
> +       KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(0, z));
> +       KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(z, w));
> +
> +       /* Valid input */
> +       KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(1, 1));
> +       KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(39, 21));
> +}
> +
> +
> +static struct kunit_case bits_test_cases[] = {
> +       KUNIT_CASE(genmask_test),
> +       KUNIT_CASE(genmask_ull_test),
> +       KUNIT_CASE(genmask_input_check_test),
> +       {}
> +};
> +
> +static struct kunit_suite bits_test_suite = {
> +       .name = "bits-test",
> +       .test_cases = bits_test_cases,
> +};
> +kunit_test_suite(bits_test_suite);
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
