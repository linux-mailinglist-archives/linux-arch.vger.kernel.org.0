Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFD25A28D3
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 15:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbiHZNuF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 09:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343642AbiHZNuD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 09:50:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CFD44574
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 06:50:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb36so3254481ejc.10
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TG9FgVqi16LcRZPucuD11y6AVi0ILI4JGPeRwHluIjU=;
        b=qQFNTe2hotOb/o+XOeHSkNh888Wv+A2OI6RACKCB02wfnqsHW4VhBNwljxGBpS1Gpz
         QzwBobxjyttdHvpFMxSzwTBJc6nskaYQKhjy4qp15F+GO7fOxdPofwo2tjIQ/Bj2zzaG
         4bzrfDgnRkWXqar/grl2RqNi04r//6jMafKhgvFkRcCBPeXGG7Z/MHTYd2Hh9b1keAM8
         BKfTjHKdE1PyvDKSZ2FB3yQybF5oPbm+wPQSHqlwWe2QPLP1V9/fE/6kxZDdJglbNaIW
         v4oYyDH2Y6dmnvQt9URauX0Qoi/3u2ppiL2irvaLRYH8RwSMqq9nWojbqd4l7Fb6wlGs
         XTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TG9FgVqi16LcRZPucuD11y6AVi0ILI4JGPeRwHluIjU=;
        b=EPG1RcWsIHuWda1ORHB5rkC27xndobp5M2RqLfhaNQrLuo5NjhVaPdmwoUdYhmXbP+
         m7ZbR1tq4yWRZKTae5SlB0xIQj6H0u1ejgSGm29mUy3He4X2PTV39NA8/9HaaZ8QesNj
         vTiiI/Mrpll9n8gJgV+Phiw8dhdws0AFV3JmdA+3Gd/fGznR8KMMukcib3PcA6CJDvyP
         /UAbxRTTy+b7Vls76lTM53Z1IobYB4vXQicWWUvJHgFY+bLeIOfAgtxTnly917dgf+fs
         6i+qUEFGxqGYUbplJK8gByXeSwHPicbshAg/vlx8rXSVPFAeQs1UuBHmk3dVgx42Tde2
         cVaw==
X-Gm-Message-State: ACgBeo10nY1EAHZ4PgwvYoa9+SB97WGGbcR77Y4CJXax+2ztSu8BBXiw
        5NvkokfjvTo1ndrXMKcOyVCoxeXf0/VwfIJTTiO2DQ==
X-Google-Smtp-Source: AA6agR5u0kMHIqr2Sykv6xwyKqyIoWq4UaK5pcx+HYQdU9jyokivM4Cu/SHtZ0DUaUkVm8ttZKbzeve9caR+0zBdJbY=
X-Received: by 2002:a17:907:72cf:b0:73d:d007:e249 with SMTP id
 du15-20020a17090772cf00b0073dd007e249mr5333295ejc.500.1661521800345; Fri, 26
 Aug 2022 06:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CACRpkdY53c0qXx24Am1TMivXr-MV+fQ8B0CDjtGi6=+2tn4-7A@mail.gmail.com>
 <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com>
 <CACRpkdbhbwBe=jU5prifXCYUXPqULhst0se3ZRH+sWOh9XeoLQ@mail.gmail.com>
 <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com>
 <CACRpkda0+iy8H0YmyowSDn8RbYgnVbC1k+o5F67inXg4Qb934Q@mail.gmail.com>
 <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
 <CACRpkdb5ow4hD3td6agCuKWvuxptm5AV4rsCrcxNStNdXnBzrA@mail.gmail.com> <87f2ff4c-3426-201c-df86-2d06d3587a20@csgroup.eu>
In-Reply-To: <87f2ff4c-3426-201c-df86-2d06d3587a20@csgroup.eu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 15:49:49 +0200
Message-ID: <CACRpkdYizQhiJXzXNHg7TXUVHzhkwXHFN5+e58kH4udGm1ziEA@mail.gmail.com>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Courbot <gnurou@gmail.com>,
        Alexandre Courbot <acourbot@nvidia.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 25, 2022 at 4:00 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:

> > Christophe? Will you take a stab at it?
>
> Which patch should I write ?

One that removes CONFIG_ARCH_HAS_NR_GPIO entirely, then
allocate bases for new GPIO chips from 0 and upward instead.
And then see what happens.

Yours,
Linus Walleij
