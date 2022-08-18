Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766FE598252
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 13:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbiHRLdu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 07:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbiHRLdt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 07:33:49 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DABE3056E;
        Thu, 18 Aug 2022 04:33:45 -0700 (PDT)
Received: from mail-ed1-f45.google.com ([209.85.208.45]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MQ5jC-1o2jCy0J04-00M0Nd; Thu, 18 Aug 2022 13:33:44 +0200
Received: by mail-ed1-f45.google.com with SMTP id o22so1481947edc.10;
        Thu, 18 Aug 2022 04:33:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo0LA6OTlTOzwYBCT0zRZNxmc1I89GNc3t8Cn8bU+Aj2/PszAkRd
        BtojenxZIV9sHG2iyfnBiTQ6Rsn4RMhAYyPSD3I=
X-Google-Smtp-Source: AA6agR4vC8vpqzx65BwITXpkRMAU+pmsv3R6/05EtIg3UeeD1/ICNR1uvmFWUR28C3eYTvGsB36ROwQqGdOqJVyIYig=
X-Received: by 2002:a05:6402:100c:b0:43d:9009:c705 with SMTP id
 c12-20020a056402100c00b0043d9009c705mr1899100edu.49.1660822423668; Thu, 18
 Aug 2022 04:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CACRpkdY53c0qXx24Am1TMivXr-MV+fQ8B0CDjtGi6=+2tn4-7A@mail.gmail.com>
 <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com> <CACRpkdbhbwBe=jU5prifXCYUXPqULhst0se3ZRH+sWOh9XeoLQ@mail.gmail.com>
In-Reply-To: <CACRpkdbhbwBe=jU5prifXCYUXPqULhst0se3ZRH+sWOh9XeoLQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Aug 2022 13:33:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com>
Message-ID: <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
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
X-Provags-ID: V03:K1:95I9ezHVKVDbn3HOR+SFddx176GWYmwMKPyfPS8w7IJt0Ovjonj
 vN9OR3ThzzhefCH/osd+Ew0A+/Lb3AcdGuNtdDfOTb0PhuPlRP5f1HBXRMMD+bvXppOal/e
 sLc87/riigluhRf/XH1VOe3duyHHdefjOhZ33kewQBQQ83/7cgk5ccIsI7e4BCp+u7NL+SK
 qDBDTgJnmQ129Ow/SzvOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LXImiQGnzd8=:z7yJnYGfeVJtVi47ei09eQ
 0QfSniCCi3j/0Mf0DuhQxiSBctkH6LCPBmFsNCiNaTV9xRVkg/FOLVLdva6lIPtmIC+P5ZoYq
 RKAT9A0qek25xh287aTcyQG1pR3pOEC0WzyEyQhvAGbpDcBueNq4NiHBKOWtv9YNv/LMNrjrV
 yKrAfDwBoIcwGQwR4mzzQ4qQzUPuNM00Pm8O+8qi8OP1Z29ILoJkzpcV4du/wkQa30aAah8Y6
 /imo9vY44OwhbDP6DcdiRZ1Jd41u9GH0reqy5aesbEaul0ndmlU0nJbDmAi+TXY1uZhfrSHUr
 4r6ejOx0yhUF7KZ93GBoIKQRR5Q0bzPAFP46YBTy0kgw/XgZoTBBj3sc3RZC0CL0fHVaZiTUn
 n0thJ1uyS21e3Ds+HbDzJkdolHK7LJXCqfMQNjLTXCbXp/cakojR3oIXM2SPDdJUROsuudErk
 3AxNqqZ2kbMy3XMCbh/C6QqNhZUQXUULr1INnCOI5I1XT4lkCU3iOzgrZhh+oaImNG4pTMkb9
 dHIhTTZJBCNjpSzACWBx7xIPBUVbx97HQdQgS0camT4sgF/SY0g2xNlErz7PahW3dmNKVR90S
 9WWU5P9rhBnD3NfzgixXCh+WhwsO39y2MH/SWkGjjmay6pcR1g2MCK2NyJ0mbUr1gifftnQOh
 F0LUCrUyPALHQkkRyOwvX8Yo6Ce3Ypu3LkakWNgshJJcrv919g3wevT2enpSQnG5Nh+cF4XJM
 tUKtW5HcwwSoax653kgzs2Bu5I/XVZiG2RRPBQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 18, 2022 at 1:13 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Aug 18, 2022 at 11:48 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > As I understood, the problem that Christophe ran into is that the
> > dynamic registration of additional gpio chips is broken because
> > it unregisters the chip if the number space is exhausted:
> >
> >                 base = gpiochip_find_base(gc->ngpio);
> >                 if (base < 0) {
> >                         ret = base;
> >                         spin_unlock_irqrestore(&gpio_lock, flags);
> >                         goto err_free_label;
> >                 }
> >
> > From the git history, it looks like this error was never handled gracefully
> > even if the intention was to keep going without a number assignment,
> > so there are probably other bugs one runs into after changing this.
>
> Hm that should be possible to get rid of altogether? I suppose it is only
> there to satisfy
>
> static inline bool gpio_is_valid(int number)
> {
>         return number >= 0 && number < ARCH_NR_GPIOS;
> }
>
> ?
>
> If using GPIO descriptors, any descriptor != NULL is valid,
> this one is just used with legacy GPIOs. Maybe we should just
> delete gpio_is_valid() everywhere and then drop the cap?

I think it makes sense to keep gpio_is_valid() for as long as we
support the numbers.

> I think there may be systems and users that still depend on GPIO base
> numbers being assigned from ARCH_NR_GPIOS and
> downwards (userspace GPIO numbers in sysfs will also change...)
> otherwise we could assign from 0 and up.

Is it possible to find in-kernel users that depend on well-known
numbers for dynamically assigned gpios? I would argue
that those are always broken.

Even for the sysfs interface, it is questionable to rely on
specific numbers because at least in an arm multiplatform
kernel the top number changes based on kernel configuration.

> Right now the safest would be:
> Assign from 512 and downwards until we hit 0 then assign
> from something high, like U32_MAX and downward.
>
> That requires dropping gpio_is_valid() everywhere.
>
> If we wanna be bold, just delete gpio_is_valid() and assign
> bases from 0 and see what happens. But I think that will
> lead to regressions.

I'm still unsure how removing gpio_is_valid() would help.

What I could imagine as a next step would be to mark all
consumer drivers and the sysfs interface that use gpio
numbers as 'depends on GPIO_LEGACY' and then only
provide the corresponding drivers if that option is set.

After that, we could try to make sure we can run the
defconfigs for modern architectures (arm64, riscv,
x86-64, ...) without the option by converting the drivers
that are most commonly used.

       Arnd
