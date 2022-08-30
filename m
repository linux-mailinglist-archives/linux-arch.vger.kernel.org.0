Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0085A6E62
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 22:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiH3UV5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 16:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiH3UV4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 16:21:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB8B52E46;
        Tue, 30 Aug 2022 13:21:55 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w28so9492908qtc.7;
        Tue, 30 Aug 2022 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GSwCSxkfswCTAr2W0z1p9wm8OPsGIVQ+vLw8r+QCbaI=;
        b=n319MBFg0fYTSh7VP5cO10oaO8edZv/xWNrw7cy5VJI/79qfQEp9RdCxrEqW8qkiJG
         brcnn03BWSCN55OFZOF+VAKsC8lbqcwMRTls8GozUjUDdipjjdahcGrj4OdUCrGV2xTv
         m5Oflc3GWdKmZN21oyHOcEYrcGsrBrl0xxbYGtuNovusufG6XDfMA79gPLa2/IZTrJxq
         qnUwiYFY3aHjJLkKTib/aIEby8FwdMMD8VcohEJ1j6Ndlj6AayluaWjbN1pH6s744ou8
         /g+yXMBj7Nema420sJSOmode1xbhgIQehSWOY+U0GOXYTuT947QPPZXt2dsxPJSQO6fz
         aSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GSwCSxkfswCTAr2W0z1p9wm8OPsGIVQ+vLw8r+QCbaI=;
        b=HA3iBrGcY8tjAUkF9VkIQpLKZ/0z4kwVCz+YmJishqnys4KPI5fuklg7GYx3W45A+a
         Pi9JthR/mKDrNspu9chjaJJ02YutWCWgC9Qg/cZLCqf/NIMpAyXgi69kk4SVlr37WCDk
         zxd3Xh0q/uc9NdeWQzLRHhI45YqH+2pnmnzKN7iqZrbgrb9LObbeEMrOGHpPYnTAQJ2T
         YBEwybkUHcZ4iOMMG0YZ3pkOAE44y5luQ8R35ECa9dYDtFooHg64hblB9AA9JyGoRoiW
         jGioYIu0AlIH4w6N3uOAOEzibgoNqWVAg7XnnavuQuDYvStnXJ0LOBXh1ATaCkJl8nK0
         0VYA==
X-Gm-Message-State: ACgBeo211UXA9/kzijkZVspx5gXM/ZQP/aGyTyMOaErmscXBqhGvxEk0
        sODUKOes4HUQrSTngkPJplWqGeC4bIy73Y8LL5A=
X-Google-Smtp-Source: AA6agR5wtSa4e+dAhZJ/VjR9XzVzQcGJMQA0E4YnrC0fabueldGOqrkcSXmg1o/nKGytxwSARQloEsUQGHgtbRFOFXA=
X-Received: by 2002:ac8:7f92:0:b0:344:8cd8:59a1 with SMTP id
 z18-20020ac87f92000000b003448cd859a1mr16713627qtj.384.1661890914718; Tue, 30
 Aug 2022 13:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661789204.git.christophe.leroy@csgroup.eu> <CAHp75Vc5um3=gwnjoJNPxp+kbhFHT0Kp4gi1Qd+q5TL-y6-+oQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc5um3=gwnjoJNPxp+kbhFHT0Kp4gi1Qd+q5TL-y6-+oQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Aug 2022 23:21:18 +0300
Message-ID: <CAHp75VeFbjRN7OE5MH0_bbx5aSerj+2F_vpBjRZhT3QQ+3wmng@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] gpio: Get rid of ARCH_NR_GPIOS (v1)
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 30, 2022 at 11:20 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Aug 29, 2022 at 7:17 PM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> > Since commit 14e85c0e69d5 ("gpio: remove gpio_descs global array")
> > there is no limitation on the number of GPIOs that can be allocated
> > in the system since the allocation is fully dynamic.
> >
> > ARCH_NR_GPIOS is today only used in order to provide downwards
> > gpiobase allocation from that value, while static allocation is
> > performed upwards from 0. However that has the disadvantage of
> > limiting the number of GPIOs that can be registered in the system.
> >
> > To overcome this limitation without requiring each and every
> > platform to provide its 'best-guess' maximum number, rework the
> > allocation to allocate from 256 upwards, allowing approx 2 millions
> > of GPIOs.
> >
> > In the meantime, add a warning for drivers how are still doing
> > static allocation, so that in the future the static allocation gets
> > removed completely and dynamic allocation can start at base 0.
>
> For non-commented (by me or others) patches
> Reviewed-by: Andy Shevchenko <andy.shevchenko!gmail.com>

Should be
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> For the patch 1 if you are going to address as suggested by the author
> of the driver, you may also add my tag.



-- 
With Best Regards,
Andy Shevchenko
