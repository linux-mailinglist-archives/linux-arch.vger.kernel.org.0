Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCBB5A1273
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 15:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbiHYNhP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 09:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbiHYNhN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 09:37:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87094B275E
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 06:37:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v14so3054539ejf.9
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dlm2famS8O5FqtaX9yCeRxscNO/EP4O+QRIK7hJkB2s=;
        b=hTFwrfcekpPlwsKPKUDudDRoTVjcNhRXmh1WtgUK60PKUyBomYKetqdJodmXMyLiB0
         dkyuV7K5eZsOuK963+nUWPUe7KCyXkJZONDwPCrivKsZT9PJDubk1TQqXKdDF6asiLn/
         tKuc0x8bOBlRQRLCT3cu6Yw1wdke2dVeoukHTnpDK1KgGBp18+wj0ZvHkmzlWDm5xfBe
         7fzo7likfMjdV90vpKunxdhJef3uuXRWyf+Ve8lXxcg9SOUlYCESKPN/0H+qXAmkBCTn
         HkRXi4lc+hQbTfmsIQLyBi6byW3t6UFkkCoPxj3LYOq5bF2Nj0Yq+8g0crj8aP/TqJK5
         Uo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dlm2famS8O5FqtaX9yCeRxscNO/EP4O+QRIK7hJkB2s=;
        b=FA+dqnmA/mmLYw+TQh8TWpAxT7YUAzaaAgl9zIOCk+fst7Ysr7DSouFVGTsEXOqF3f
         g2/ZFJSy55M7QSzxwxd/HeW+mXyeOYEgqgx+fOxXTyZ1YYW83g8xkH+5i3BZZNQ2RW5B
         iRJSxN/LRwdw2NEa3mTUZQz7nJrZypWbU4bhoZU85HtJJJNgk+mKAK/12drGCv2Nqi3b
         kPtjDhrhEhTPOfYlMGcjVRnyPbXTzP3C3XjrEo2GAFGW6jdh/LkskIBW6I19WIV1AqAo
         f6jB6zbXyIMbBHDFtSIRokmaGLeK7HPzKQQwf3QwwWYQOlzmwMYPwsJ9q7f9s/rZ+g7U
         iwAw==
X-Gm-Message-State: ACgBeo17aJEtbepAvXlyueUFUCiEBIVftaXLMt08Usq2BlabbirT8kvn
        g+mzmaTSw4kt6ive1gF/gOHt8aT0aBdP1u8YJXttHg==
X-Google-Smtp-Source: AA6agR6Be+IFNm9RQjAf6ZoJJ0Gv1gRLpqln7PaJkfZ2s1Nuu2OIJL74xQl9m77k4Ch3VEJMzJNEIiUBj3SnGR8MwxQ=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr2609925ejc.440.1661434630115; Thu, 25
 Aug 2022 06:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CACRpkdY53c0qXx24Am1TMivXr-MV+fQ8B0CDjtGi6=+2tn4-7A@mail.gmail.com>
 <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com>
 <CACRpkdbhbwBe=jU5prifXCYUXPqULhst0se3ZRH+sWOh9XeoLQ@mail.gmail.com>
 <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com>
 <CACRpkda0+iy8H0YmyowSDn8RbYgnVbC1k+o5F67inXg4Qb934Q@mail.gmail.com> <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
In-Reply-To: <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Aug 2022 15:36:58 +0200
Message-ID: <CACRpkdb5ow4hD3td6agCuKWvuxptm5AV4rsCrcxNStNdXnBzrA@mail.gmail.com>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 18, 2022 at 2:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Aug 18, 2022 at 2:25 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> > git grep 'base = -1' yields these suspects:
> >
> > arch/arm/common/sa1111.c:       sachip->gc.base = -1;
> > arch/arm/common/scoop.c:        devptr->gpio.base = -1;
> > arch/powerpc/platforms/52xx/mpc52xx_gpt.c:      gpt->gc.base = -1;
> > arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c: gc->base = -1;
> >
> > That's all! We could just calculate these to 512-ngpios and
> > hardcode that instead.
>
> How do the consumers find the numbers for these four?

For SA1111 the chip gets named "sa1111" and some consumers actually
use proper machine descriptions, maybe all?

arch/arm/mach-sa1100/jornada720.c:              GPIO_LOOKUP("sa1111",
0, "s0-power", GPIO_ACTIVE_HIGH),
arch/arm/mach-sa1100/jornada720.c:              GPIO_LOOKUP("sa1111",
1, "s1-power", GPIO_ACTIVE_HIGH),
(...)

For Scoop it is conditionally overridden in the code. I guess always
overridden.

For powerpc these seem to be using (old but working) device tree
lookups, so should not be an issue.

Sadly I'm not 100% sure that there are no random hard-coded
GPIO numbers referring to whatever the framework gave them
at the time the code was written :(

Another reason the base is assigned from above (usually
from 512 and downward) is that the primary SoC GPIO usually
want to be at base 0 and there is no guarantee that it will
get probed first. So hard-coded GPIO bases go from 0 -> n
and dynamically allocateed GPIO bases from n <- 512.

Then we hope they don't meet and overlap in the middle...

> > and in that case it is better to delete the use of this function
> > altogether since it can not fail.
>
> S32_MAX might be a better upper bound. That allows to
> just have no number assigned to a gpio chip. Any driver
> code calling desc_to_gpio() could then get back -1
> or a negative error code.
>
> Making the ones that are invalid today valid sounds like
> a step backwards to me if the goal is to stop using
> gpio numbers and most consumers no longer need them.

OK I get it...

Now: who wants to write this patch? :)

Christophe? Will you take a stab at it?

Yours,
Linus Walleij
