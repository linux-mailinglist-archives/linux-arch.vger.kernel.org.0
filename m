Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9972598176
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 12:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244078AbiHRK2u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 06:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbiHRK2t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 06:28:49 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A8A62A94;
        Thu, 18 Aug 2022 03:28:47 -0700 (PDT)
Received: from mail-ed1-f46.google.com ([209.85.208.46]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MS3zP-1nvrkM43tj-00TX4d; Thu, 18 Aug 2022 12:28:46 +0200
Received: by mail-ed1-f46.google.com with SMTP id c39so1346524edf.0;
        Thu, 18 Aug 2022 03:28:45 -0700 (PDT)
X-Gm-Message-State: ACgBeo1sh/PWohU52uIFW0Pd1G1k+IslT33auntxPDPmaajn1A6A3Re7
        o9hI3IWh2pv3BtlDA1AUovP2/LRDDJsweAIfEhY=
X-Google-Smtp-Source: AA6agR4nVxi0ePhOH3jGv715TF01WPvmsp/jmRm3vgsUhKI3EMQ2AozSLAvAn7H8pdVEurPhxa9JmAcPXzdugv5Jqa4=
X-Received: by 2002:a05:6402:3495:b0:43d:d76e:e9ff with SMTP id
 v21-20020a056402349500b0043dd76ee9ffmr1774833edc.227.1660818525606; Thu, 18
 Aug 2022 03:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220818092059.103884-1-linus.walleij@linaro.org>
In-Reply-To: <20220818092059.103884-1-linus.walleij@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Aug 2022 12:28:29 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1x52F8Ya3ShQ+v6x_jANfUsEq0E55u+pOBNaYniRO7cA@mail.gmail.com>
Message-ID: <CAK8P3a1x52F8Ya3ShQ+v6x_jANfUsEq0E55u+pOBNaYniRO7cA@mail.gmail.com>
Subject: Re: [PATCH] alpha: Use generic <asm-generic/io.h>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yhH67E8QPs/WOe6ja2hJ5zvCNK0MOh2F+2giu+l1Ybx5asg6JLi
 xYqL0F5663AAHSKpi9VJITKxtZ9Is3/Md+8U8wSkkmVi+VAF4raihb97wS1ukTbjgZQ2yCe
 wzbIfiEQdOKq8TluasKL1cvT/zqJZ6uPJjug/1Ksa1JayAKa0WWsyj/H5Fdr3Gj/GHivdNG
 2BgodmNzOawfaaNv42I/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3qFArbeUwUI=:xmmNCSrwrukE4/3UTHc6bU
 +goF3ngLLVg58yKncLXMgDYcnCbiLggpcAKCESE8Fsp9U7/w9QyNdYJKC83vE37YRT2Esm5f0
 DNZRjevUy8bVa50MvVYWkKph3vXhbeDprQxLhv64ydK5RG5yOyG6mqq36cxyt+fHJ4vgcOrHI
 hJRffFjUyNfOTdeGha9CwgFXDWrzxZmWY/YgVF1SbwBWUE55fb6lXpBgU7M4mwKlt+WYoUTLA
 H9Ts5ky+TC4di/Y4xsi6Ow4lpTyxDFM/7n3nKtw0Zn8NgvFMEfr0227sO/WXsbqCaUT2IULB/
 Oa70Xx9VtEWYRUTa7jKolb+5RvPphfIoxXL4XCN5ONl+N03NdNGA52VFSt6mb1B/mK8yd1kP7
 61XjXqikZDJZVgSJu42HFEXckKMMfAh7LxFTaOkYGCqvszjsO7b6daZzKBH+ELMoYHN/R5QQM
 dZSDekZ6UPTYkOpFrGnRNarJgg4G5kY9txVAuEZFt8v1GA5MCQJ/HFyROyXnlQKnpitErfSoJ
 0BXjaAVL40NtHiHhUTIPYyqdkL04vKFKBkofXO5LOyMa0bJ6tFVeikQfc2Nj4DHLeafST822T
 M4szNeskb3/Y8/pVZcMtUIk1R6Sw60nRMmedgUTZ7drZ7CjwaGyyDJ0d0OZfFuE7X9/3A0w4p
 jIBaJfuiM32rZ4Qgbrgx0J2t9B59Ld5k3YExb53cgrhgLSK3izA2cmafbWienXicd3EK4lRil
 JhY3lqZ1LUcSMT0pd7PY/WVWN9f5d8QeCRs2gmbyxnDj0vDXqJ3CJxX2SW79D8aHOa+eNkak+
 /ZTKUoTgm70sZKgwjNNF/hEAoBdYV1QxCjQLlweT6oxHHz80YOEYcq/wyb49Q2kdS42ERjNuv
 2IU43QHVGxb1X37EBbEQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 18, 2022 at 11:20 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This enables the alpha to use <asm-generic/io.h> to fill in the
> missing (undefined) I/O accessor functions.
>
> This is needed if Alpha ever wants to uses CONFIG_REGMAP_MMIO
> which has been patches to use accelerated _noinc accessors
> such as readsq/writesq that Alpha, while being a 64bit platform,
> as of now not yet provide. readq/writeq is however provided
> so the machine can do 64bit I/O.
>
> This comes with the requirement that everything the architecture
> already provides needs to be defined, rather than just being,
> say, static inline functions.
>
> Bite the bullet and just provide the definitions and make it work.

I see the only other architectures that don't use asm-generic/io.h
yet are hexagon, mips, parisc, sh and sparc64. I wonder if it would
make sense to do this for all of them.

> Alternative approaches:
>
> - Implement proper readsq/writesq inline accessors for alpha

that would be ok with me

> - Rewrite the whole world of io.h to use something like __weak

>   instead of relying on defines
Nak to the use of __weak in anything I maintain, I find this to
be highly confusing whenever I try to find out what code is actually
getting called.

> - Leave regmap MMIO broken on Alpha because none of its drivers
>   use it

no problem for me

> - Make regmap MMIO depend of !ARCH_ALPHA

This doesn't work, because REGMAP_MMIO is selected by 150
drivers: unless you mark each of these individually as 'depends
on !ALPHA', you just get an addition warning from Kconfig
but it still fails to build.

> The latter seems a bit over the top. First option to implement
> readsq/writesq seems possible but I cannot test it (no hardware)
> so using the generic fallbacks seems like a better idea, also in
> general that will provide future defaults for accelerated defines.
>
> Leaving regmap MMIO broken or disabling it for Alpha feels bad
> because it breaks compiler coverage.

I'm not worried about compiler coverage on the less common
architectures, there is little hope of getting random configurations
to build because there are too many other problems.

> I'd like this applied to the alpha tree if there is such a
> thing otherwise maybe Arnd can apply it to the arch generic
> tree?

Sure, I can do that.

> +/*
> + * These defines are necessary to use the generic io.h for filling in
> + * the missing parts of the API contract. This is because the platform
> + * uses (inline) functions rather than defines and the generic helper
> + * fills in the undefined.
> + */
> +#define virt_to_phys virt_to_phys
> +#define phys_to_virt phys_to_virt
> +#define memset_io memset_io
> +#define memcpy_fromio memcpy_fromio

We tend to have these next to the function definition rather than
in a single place. Again, I'm not too worried here, just if you end
up reworking the patch in some form, or doing the same for the
other architectures that would be the way to do it.

      Arnd
