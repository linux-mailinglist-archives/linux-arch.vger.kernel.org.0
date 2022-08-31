Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DE75A7855
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 10:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiHaIBE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 31 Aug 2022 04:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHaIBC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 04:01:02 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D2952FD7;
        Wed, 31 Aug 2022 01:01:02 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id g14so10374268qto.11;
        Wed, 31 Aug 2022 01:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=vLTKD5WHFR7nVOsyTpEksJQ0bIQliko66o8HXMmzxSk=;
        b=ssY7zhlm0lKyykGtvyTLdJy7R1BVckPzh6+2wwJD//nI65Vaa7a7Xc/Q2YOxX9HBCh
         T84q2+Ds1g1Arr0YodwC0BVQlh7TGh5U7vgyPpzovmdm5U5asdc0sqE0iAHAAcJZGr6R
         wal6UY+kcYd0BfSYNrP3C9F6EN450xECJZvDHG6VY+mG592q+VE8xoUfpHdnPSBMcg3d
         H/l4yWPYHOk9iJJKDwSB14UNIksmDn7s4SzvNKmC8VaP6HgqwA3T+fntLlwI3VCkPQNh
         TQ4fkJ3dKcYknlXER92TSGDCdbkBcAAMQKTO6pja6qMrGJLb09eWuC2dr9xxHUYNL8IU
         v67Q==
X-Gm-Message-State: ACgBeo0Yifd8i2dQgUnDIzmHb1MtRlea8wMigQVdx/3ke+k25xbxNdYo
        cpGcH3AQwNCCth6Dz//IQRISixj6JPjqnw==
X-Google-Smtp-Source: AA6agR7YydLrRZeutMLi1SFZunfovvSy7X3HIdqgA949ClPJr+5pNo2iBneKLNBjKP66I0i4gcXE2A==
X-Received: by 2002:ac8:5d92:0:b0:344:6f74:4d17 with SMTP id d18-20020ac85d92000000b003446f744d17mr18009285qtx.227.1661932860992;
        Wed, 31 Aug 2022 01:01:00 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id br18-20020a05620a461200b006bb0f9b89cfsm9587669qkb.87.2022.08.31.01.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 01:01:00 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-32a09b909f6so300609907b3.0;
        Wed, 31 Aug 2022 01:00:59 -0700 (PDT)
X-Received: by 2002:a81:83c8:0:b0:341:4b7b:3d9e with SMTP id
 t191-20020a8183c8000000b003414b7b3d9emr8926439ywf.47.1661932859505; Wed, 31
 Aug 2022 01:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
 <92aaf098d7039fd4040015b07ba1f99daf674f50.1661789204.git.christophe.leroy@csgroup.eu>
 <CAHp75VesQgR9arwnvsBZKwm6-skOJQCc9xex5NZsE8cQG_1CwQ@mail.gmail.com> <22c001c0-1109-5579-7420-2e37707688a9@csgroup.eu>
In-Reply-To: <22c001c0-1109-5579-7420-2e37707688a9@csgroup.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 31 Aug 2022 10:00:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0J=iNa8uLEq1KTG6gjr4M+WwwHsLsHQ_fWDDLky7sZg@mail.gmail.com>
Message-ID: <CAMuHMdX0J=iNa8uLEq1KTG6gjr4M+WwwHsLsHQ_fWDDLky7sZg@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] gpiolib: Warn on drivers still using static
 gpiobase allocation
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christophe,

On Wed, Aug 31, 2022 at 7:39 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 30/08/2022 à 22:14, Andy Shevchenko a écrit :
> > On Mon, Aug 29, 2022 at 7:18 PM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >> In the preparation of getting completely rid of static gpiobase
> >> allocation in the future, emit a warning in drivers still doing so.
> >
> > ...
> >
> >> +               dev_warn(&gdev->dev, "Static allocation of GPIO base is "
> >> +                                    "deprecated, use dynamic allocation.");
> >
> > First of all, do not split string literals. Second, you forgot '\n'.
>
> Then I get a line longer than 100 chars, is that acceptable ?

Yes it is.  It is a much worse user experience if

    git grep "Static allocation of GPIO base is deprecated"

does not let you find the line that does fit in 100 chars ;-)

> Since commit 5fd29d6ccbc9 ("printk: clean up handling of log-levels and
> newlines"), "\n" are just visual pollution, aren't they ?

The convention is to always add it.  See also commit a0cba2179ea4c182
("Revert "printk: create pr_<level> functions"").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
