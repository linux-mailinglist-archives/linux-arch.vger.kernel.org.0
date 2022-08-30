Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7315A6E54
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 22:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiH3UTG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiH3UTE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 16:19:04 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7643286C3;
        Tue, 30 Aug 2022 13:19:03 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x5so9484719qtv.9;
        Tue, 30 Aug 2022 13:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LVn6qx7D95RyzzEUvV9vWSYtbWzc15zDFAjhUMtiT8U=;
        b=n4D10XaDUSei5RLSsY+I//s3biEMQ4gimTe364fs28GKuTXZ6h39Dr8c968TsbE1FK
         YhJV38UY5llldYqcHq5Ao7rIATy9Lr4OSXns7i89iAxB+ieW4hFd1pEXACPZ9q5euCk3
         uZc3gAfHf7wzcgI5O8L+COYoibPJj67mpjjtAdjJUabbtHBfkFas3CNPKglSUgXgyXA/
         sqWLAxxoRelv4TB2yit1JpPsHXWvprRQa944PUCVRTVLlyJ6ILrAnBrPmVGhJT6ydErn
         6fAlYcj7Ox1YKnu8+TuptVg2bctQogTTHmOniVxbsNJjvou4q1RApNT/dxJnOR3n/kSg
         a20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LVn6qx7D95RyzzEUvV9vWSYtbWzc15zDFAjhUMtiT8U=;
        b=qp2Bt4ZKkf7+4lnYhRt30fftP7NWlNx0scx9PBg1WBO7R8qhh/sRQB4AhXWedm3eqi
         FdGhDn6Wke+7mOJbzE3KQmVizrzxgbzZ9n94GTYioOAHMotZXK5AbR4nGlw+KAcLow2Y
         RS+KElkLIoVQOa2G3IzJa9LQNjaYWPhIA1asfkW6B++/0wnJD7fjotp6nc5FdQTDIJ3+
         b+LhrMeTl5LR+HIINpSUjtxLW6EOtvFWX1TTth109pEiiA8jkvZZbVXOCcFfNXWoOo/p
         cPaSWG8/fXTvIc1FrLCOAQujmbQSPrMHchGJ7LwQgGQ29gQKelq1l7Meer1kkHa1fkRj
         CBsw==
X-Gm-Message-State: ACgBeo2VDunQgZ6l9N2uV7IGFEahTr2hJe63VgvKeTINW0ZOyl8Zn/9i
        fpJb7OhSR7ClhprO3uwQAFUWC2IUvl2gRMtkBXY=
X-Google-Smtp-Source: AA6agR79d85vpjTBtBYLCb2xQNPhnUnTI9Q+QLTg6ng9KLWLGM8ALchh4LqN/i4W7M4C88klpkE3OtAGkQj6rdwwXMk=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr16165431qta.429.1661890742791; Tue, 30
 Aug 2022 13:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661789204.git.christophe.leroy@csgroup.eu> <abb46a587b76d379ad32d53817d837d8a5fea8bd.1661789204.git.christophe.leroy@csgroup.eu>
In-Reply-To: <abb46a587b76d379ad32d53817d837d8a5fea8bd.1661789204.git.christophe.leroy@csgroup.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Aug 2022 23:18:26 +0300
Message-ID: <CAHp75VcngRihpfUkeKs-g+TbPnpOsZ+-Q37zDVoWp8p_2GbSvQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] gpiolib: Get rid of ARCH_NR_GPIOS
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

On Mon, Aug 29, 2022 at 7:19 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Since commit 14e85c0e69d5 ("gpio: remove gpio_descs global array")
> there is no limitation on the number of GPIOs that can be allocated
> in the system since the allocation is fully dynamic.
>
> ARCH_NR_GPIOS is today only used in order to provide downwards
> gpiobase allocation from that value, while static allocation is
> performed upwards from 0. However that has the disadvantage of
> limiting the number of GPIOs that can be registered in the system.
>
> To overcome this limitation without requiring each and every
> platform to provide its 'best-guess' maximum number, rework the
> allocation to allocate upwards, allowing approx 2 millions of
> GPIOs.
>
> In order to still allow static allocation for legacy drivers, define
> GPIO_DYNAMIC_BASE with the value 256 as the start for dynamic
> allocation.

Not sure about 256, but I understand that this can only be the best guess.

-- 
With Best Regards,
Andy Shevchenko
