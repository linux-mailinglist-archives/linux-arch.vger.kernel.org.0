Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8132A5F02E8
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 04:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiI3CmQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 22:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiI3CmP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 22:42:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A455139BD9;
        Thu, 29 Sep 2022 19:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3328DB82705;
        Fri, 30 Sep 2022 02:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B85C433C1;
        Fri, 30 Sep 2022 02:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664505731;
        bh=89J+XT342DOuM16MG6vi3VPlCbMluYda7siQ4WgQfOk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TgYwqSxB1RmxJ2hVL/hIVDZ70dbrdDBEIX295dr+XigaohWEvgEFAJl34Fs6fMgsX
         a53mC0sfc/OM1sHbLTmxuj13+8DDHkaCscCYZmCdpByyi8CoEc+9+PTwV5QhHHDXAJ
         hw0mPnkoHvsbQQu4dcqOF2+G3fTXEu+1kQ2SiKXRwQeIcKA8cuxjKp0f2MWQVCxXq3
         b9LMNpyYE5szGt9quP24jHwXtAe4J80ynccOu0CrAkg+33DlB2LncphHfXUGD+j4VQ
         E+lIdFO+EusUHooOgb6OuWydkLd2gGcX5Bf0pIxYXLZ/7qEky/G72yDVvgKprRn0rL
         6OoIasfBsP51w==
Received: by mail-vs1-f54.google.com with SMTP id m65so3500947vsc.1;
        Thu, 29 Sep 2022 19:42:11 -0700 (PDT)
X-Gm-Message-State: ACrzQf00INq3FsugomVH7ot/hd4MQUyZqV72gO7xMAp03qyvS+INCd8h
        NN/H4Wi8gSWQPynJZTFwVgT+FPXryEToKGWMhok=
X-Google-Smtp-Source: AMsMyM6l0s42TpcL/m101J48xwB6udwVmDcTuy8DNrZpc0blyfUFDSuufF3zt59VsyIIr36sML9MzAshM/nVlYaON24=
X-Received: by 2002:a67:d491:0:b0:398:1bbc:bc85 with SMTP id
 g17-20020a67d491000000b003981bbcbc85mr3198312vsj.59.1664505730773; Thu, 29
 Sep 2022 19:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220917064020.1639709-1-chenhuacai@loongson.cn>
 <20220917064020.1639709-2-chenhuacai@loongson.cn> <87a66rhkri.fsf@baylibre.com>
In-Reply-To: <87a66rhkri.fsf@baylibre.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 30 Sep 2022 10:41:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6YLstS+GqaXv2Y9p_QVAU4x=nrunP_Hd2GeznOWG6q4g@mail.gmail.com>
Message-ID: <CAAhV-H6YLstS+GqaXv2Y9p_QVAU4x=nrunP_Hd2GeznOWG6q4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] Input: i8042: Add LoongArch support in i8042-acpipnpio.h
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Mattijs,

On Thu, Sep 22, 2022 at 4:32 PM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> On Sat, Sep 17, 2022 at 14:40, Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> > LoongArch uses ACPI and nearly the same as X86/IA64 for 8042. So modify
> > i8042-acpipnpio.h slightly and enable it for LoongArch in i8042.h. Then
> > i8042 driver can work well under the ACPI firmware with PNP typed key-
> > board and mouse configured in DSDT.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> I would have split the pr_info() move in its own patch since it seems
> like a "valid fix" on its own, but i'm probably too pedantic about this.
>
> So, please take my:
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
I think the pr_info is needed for all architectures, and the moving is
very simple so I haven't split it. But anyway, if Dmitry also thinks
this patch should be split, I will send a new version. :)

Huacai
>
> > ---
> >  drivers/input/serio/i8042-acpipnpio.h | 8 ++++++--
> >  drivers/input/serio/i8042.h           | 2 +-
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
> > index d14b9fb59d6c..c22151f180bb 100644
> > --- a/drivers/input/serio/i8042-acpipnpio.h
> > +++ b/drivers/input/serio/i8042-acpipnpio.h
> > @@ -2,6 +2,7 @@
> >  #ifndef _I8042_ACPIPNPIO_H
> >  #define _I8042_ACPIPNPIO_H
> >
> > +#include <linux/acpi.h>
> >
> >  #ifdef CONFIG_X86
> >  #include <asm/x86_init.h>
> > @@ -1449,16 +1450,19 @@ static int __init i8042_pnp_init(void)
> >
> >       if (!i8042_pnp_kbd_devices && !i8042_pnp_aux_devices) {
> >               i8042_pnp_exit();
> > +             pr_info("PNP: No PS/2 controller found.\n");
> >  #if defined(__ia64__)
> >               return -ENODEV;
> > +#elif defined(__loongarch__)
> > +             if (acpi_disabled == 0)
> > +                     return -ENODEV;
> >  #else
> > -             pr_info("PNP: No PS/2 controller found.\n");
> >               if (x86_platform.legacy.i8042 !=
> >                               X86_LEGACY_I8042_EXPECTED_PRESENT)
> >                       return -ENODEV;
> > +#endif
> >               pr_info("Probing ports directly.\n");
> >               return 0;
> > -#endif
> >       }
> >
> >       if (i8042_pnp_kbd_devices)
> > diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
> > index bf2592fa9a78..adb5173372d3 100644
> > --- a/drivers/input/serio/i8042.h
> > +++ b/drivers/input/serio/i8042.h
> > @@ -19,7 +19,7 @@
> >  #include "i8042-snirm.h"
> >  #elif defined(CONFIG_SPARC)
> >  #include "i8042-sparcio.h"
> > -#elif defined(CONFIG_X86) || defined(CONFIG_IA64)
> > +#elif defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_LOONGARCH)
> >  #include "i8042-acpipnpio.h"
> >  #else
> >  #include "i8042-io.h"
> > --
> > 2.31.1
>
