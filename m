Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1364598361
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 14:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbiHRMqp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 08:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiHRMqn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 08:46:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B86863F1C;
        Thu, 18 Aug 2022 05:46:41 -0700 (PDT)
Received: from mail-ej1-f43.google.com ([209.85.218.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MjSHa-1ne1cT2zaE-00ktfs; Thu, 18 Aug 2022 14:46:39 +0200
Received: by mail-ej1-f43.google.com with SMTP id k26so3032059ejx.5;
        Thu, 18 Aug 2022 05:46:39 -0700 (PDT)
X-Gm-Message-State: ACgBeo1ybL2Q4+wz0EbQeEvpfRQdylmlOBKKOPovtWxDQ6FbRkmT/eyn
        OT6ydmJ1Za/ntTFwOxBk4MkixivpAm0S4NabdOg=
X-Google-Smtp-Source: AA6agR6PkmsCJ5vzvYIeRqIgKMw6eSccUvsMJF6eW4A8Mr3m7IxCTlGcbI11CG0PH303W40jhAwDaD+Vu8kOl1vXJ9k=
X-Received: by 2002:a17:906:9b08:b0:730:5d3c:4b1b with SMTP id
 eo8-20020a1709069b0800b007305d3c4b1bmr1815183ejc.606.1660826799268; Thu, 18
 Aug 2022 05:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CACRpkdY53c0qXx24Am1TMivXr-MV+fQ8B0CDjtGi6=+2tn4-7A@mail.gmail.com>
 <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com>
 <CACRpkdbhbwBe=jU5prifXCYUXPqULhst0se3ZRH+sWOh9XeoLQ@mail.gmail.com>
 <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com> <CACRpkda0+iy8H0YmyowSDn8RbYgnVbC1k+o5F67inXg4Qb934Q@mail.gmail.com>
In-Reply-To: <CACRpkda0+iy8H0YmyowSDn8RbYgnVbC1k+o5F67inXg4Qb934Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Aug 2022 14:46:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
Message-ID: <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Courbot <gnurou@gmail.com>,
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
X-Provags-ID: V03:K1:OvzLXBF3uV/pdjl/yQRKrMC60QpaRL30ffyZ7v9t+Egjlgirm6n
 t2fRgwr6EWZR33HevfB9Opi3AmARtAgu2YIZ+G3RmLZcPwEPMQmuWpt+byxUkn3Y9QwhCgF
 UYg6GLcuUEneD9jtQ09bHlGlpnSKbvxUAGT1+en8znfkNYUoUxSPa2+Sm2TnJ5/CNEz/54Z
 QK2I8HKoEZX6vkXJ7jeTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U5E2Uc/ZWZQ=:3vRPqZW5tIpN4aAjeBi9Y3
 9q8cK7HQktqAtjGrxOdrTJpWjLU4WZf/naR/M3NlFZ2H69cc2ihTem45VFN1Nl+AYf0soHKwR
 zu/H179lXz+SqNolxViGPemc/YG36PamQ/qV+iqXrJImJb5DogPAg6g0e5qe9EJc6M3Rr6iCC
 gNE8lfOs4S9qmuaFUxwVzVMEYwjPp1CZru5wwkEUI6avWM6QHZCdpIGQ/IIW3Lcm7L1KOM5fE
 s1ovxp8917i91advl1fYt1vH632tnNEBESofhPuQOZQRsY4N12PGuJZ8nQ/2FA42PCSRhp9ia
 iOFQP2h4kYzPSqCulP8bzlRaCAjSraG/86KENAVO+K5bH1naRrSOidKg4eLboXlDae5g0qBSN
 1pbin1or/k87a4bZ6fIc4BAARapIWLNQMakAmPpW3jq1FkMqIbLngHxiS7lc9PJZweg884pJj
 +fi8WsxwBvazRX6wYpamq9PrvNGaxJxAvjw9B3wfIATgjfsZHRkbfBluQmbnQEsVjIT3B2Oil
 yeicBP8DqNPB/4QtKu2qChpQLth3m6w6MrL1+xylkVDRXVVsarwjqRcqr5Zr03T3qnU8ZM5V6
 EYvDWZDA4nDoF/zyuLiGMAX/Jo/JZ615ufvcCMqJS3nX0G+hzHGKxDmDRvppQ3LBWEiEGswXk
 4rmJk8lNAiS25ORd4wRrs5Oza0DJzmpfWYlqB3H7xTd6CxvYDydhD6jZXTlwQOkldbu37Ku6U
 5ijnDjFNfFxXTz/QlhSs6UZ6Oig4IX7nRqGtONrE2ppBIsTQjKaXnNOd1i+dWjGwa0hS2OJmb
 tTcUheDooJDjiXAhQRSUt+1oAsq5AOKjnZYp9GGOSl+HOHFwkk79C3asPdCAnM8QJEsHLtJ61
 wrRlWR+g+2Uwi0xmcfYdxwbjSbjS1HsKwU++xfz6OT06XmvdvjUJIKZAjBm0xA8NMmre8OtTR
 MFn4z/vVdng8lkp40jW9ay8cu6WegD7l+D9KsJ6c877PNm+7T1YGv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 18, 2022 at 2:25 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Aug 18, 2022 at 1:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Aug 18, 2022 at 1:13 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > I think there may be systems and users that still depend on GPIO base
> > > numbers being assigned from ARCH_NR_GPIOS and
> > > downwards (userspace GPIO numbers in sysfs will also change...)
> > > otherwise we could assign from 0 and up.
> >
> > Is it possible to find in-kernel users that depend on well-known
> > numbers for dynamically assigned gpios? I would argue
> > that those are always broken.
>
> Most in-kernel users hard-code the base to something like
> 0 etc it's only the ones that code -1 into .base that are in
> trouble because that will activate dynamic assignment for the
> base.
>
> git grep 'base = -1' yields these suspects:
>
> arch/arm/common/sa1111.c:       sachip->gc.base = -1;
> arch/arm/common/scoop.c:        devptr->gpio.base = -1;
> arch/powerpc/platforms/52xx/mpc52xx_gpt.c:      gpt->gc.base = -1;
> arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c: gc->base = -1;
>
> That's all! We could just calculate these to 512-ngpios and
> hardcode that instead.

How do the consumers find the numbers for these four?

> > > Right now the safest would be:
> > > Assign from 512 and downwards until we hit 0 then assign
> > > from something high, like U32_MAX and downward.
> > >
> > > That requires dropping gpio_is_valid() everywhere.
> > >
> > > If we wanna be bold, just delete gpio_is_valid() and assign
> > > bases from 0 and see what happens. But I think that will
> > > lead to regressions.
> >
> > I'm still unsure how removing gpio_is_valid() would help.
>
> If we allow GPIO base all the way to U32_MAX
> this function becomes:
>
> static inline bool gpio_is_valid(int number)
> {
>         return number >= 0 && number < U32_MAX;
> }
>
> and we can then just
>
> #define gpio_is_valid true
>
> and in that case it is better to delete the use of this function
> altogether since it can not fail.

S32_MAX might be a better upper bound. That allows to
just have no number assigned to a gpio chip. Any driver
code calling desc_to_gpio() could then get back -1
or a negative error code.

Making the ones that are invalid today valid sounds like
a step backwards to me if the goal is to stop using
gpio numbers and most consumers no longer need them.

          Arnd
