Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C45956E9
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 11:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiHPJqH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 05:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiHPJp0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 05:45:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD30AF492;
        Tue, 16 Aug 2022 02:06:14 -0700 (PDT)
Received: from mail-ej1-f47.google.com ([209.85.218.47]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mxlio-1nR4NX1Uxa-00zIzg; Tue, 16 Aug 2022 11:06:13 +0200
Received: by mail-ej1-f47.google.com with SMTP id i14so17701433ejg.6;
        Tue, 16 Aug 2022 02:06:13 -0700 (PDT)
X-Gm-Message-State: ACgBeo1XTWY/wuDOZSww0+GqA8jaGgL3TvAb6bP/WgDIcQeyQ7OTbNEe
        L0Dk5h0VaH11KWpkXVgsxVchG+Cn+V9UHn2U9lw=
X-Google-Smtp-Source: AA6agR7/XFetlBcIi1yiDJejGlDn9WbspN+S3R/Ls0zoxtqtIXYbt5mp8yD7AQyB0r181eqAYOXzNBUZ7EBSTS4h/MQ=
X-Received: by 2002:a17:906:8a67:b0:738:7bcd:dca1 with SMTP id
 hy7-20020a1709068a6700b007387bcddca1mr2028088ejc.547.1660640773013; Tue, 16
 Aug 2022 02:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220815124803.3332991-1-chenhuacai@loongson.cn>
 <20220815124803.3332991-2-chenhuacai@loongson.cn> <CAK8P3a2P=XSM1_eD-UkvHaQ8Y4ak4BPAAABg2LxNBhyWhhO4uA@mail.gmail.com>
 <CAAhV-H6ow1WwVdwk4ekQU_aA+dFrUoL3SBrL9Esn9Td-rJKJcg@mail.gmail.com>
In-Reply-To: <CAAhV-H6ow1WwVdwk4ekQU_aA+dFrUoL3SBrL9Esn9Td-rJKJcg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 16 Aug 2022 11:05:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1bmjckVJnnM=h4p8jJ9ZyYZNj2FOusz5N5s3HkWYy2ow@mail.gmail.com>
Message-ID: <CAK8P3a1bmjckVJnnM=h4p8jJ9ZyYZNj2FOusz5N5s3HkWYy2ow@mail.gmail.com>
Subject: Re: [PATCH 2/2] LoongArch: Add ACPI-based generic laptop driver
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hzv6voQGgKi/SVK2pBcBBayKwp1C6ifVAU+uAhMEHO8cGF5KX35
 nBEuSmHnWfeauR4HVaYzm3wdv5x0Mq8xEkMzLF+UJNxhDdVFygZ0Yrlj0vgmY2mBdoUbCTG
 1ta62LN9TGyND16x3ra0wna9+y56HnaIgrRIHraZU5+j9jaeSSoPO521qidivv74XRonSUt
 d1/QiAmv4i26hR7fROXJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5S+2QmBS8e4=:fwwINLLaHakmQjyuZDZCho
 YOQt6u0hYtle1Wg7+eRTDJs7ZIvV4DxYAQrr8cRtXA0SJfzV2CiLgrnczL9l4nb2sAU9NqbP7
 R5dSQV8GHyyT9qXt+s0h5f4gxNzGUxma8BOKn/2R/LB/7TkmHXgJrRfyX2ULdAUXNO6OJShiG
 O2d5DyHq0j3QgGTMaNJInaJVwLmeJY/wZ6bjTHLVpfepFP/eRt+x25xC1bVE9qqqPjtEBhmz2
 bTPNKa+YkbKWEcyqZ546NB+l2hBeBG4qQVIt0nCOg9z8RDiYAEqbbdLk8jjDLMlweIzoA/Rr5
 JI5Nh1Mzv1MwCkPm+MiomLCm2xzjorv2sCu3zYWGR+DOu/IlDRB5o1RhXqY6cSLbLKxN621GG
 zKXCg2KU/4Gnn2+OKONJ7AkGM53jVvumK9GB7/d8SYx2KpSggosO6UsMiVeLmqGUdF1p+S8QM
 Hs5SbDJxSlq8AUKoiRwaAQNo3Rsp6PPmxS0kbAUuBmxAX8UHVfVbH1OPDfaaXiyTIENdUtNpr
 DB57TpD3h5R6178SG2POT8R8o5Fj0vqTfe0QDhytIp4QZY9SVxB0DjCXoWH056o/oiGknBlZW
 7XYv/uHFiHFqvfRP/6c1cEUcJnw2dk1IpjPdN8Ey/mLlEikCRjenpI2Wd2tz++/jURxqfCfZq
 ASLCYgipBOW+n0S+Ki4f8gX3lWrurW5E85NgTShlDWybm5C4ZfzK61xx1B4Tgdi1etLUhe5Tk
 l520mTufgRrHEBqquKNhb2hUBccITxfvhuE7UgRq5eYvxS4ruqTBiXcCbngARAei9V9pNf6a1
 /XcsVHT09YUyDqU2wmjVjVTZslUJeAEP8KSI3n5S/Fsvxm9cQTd+/BN56v5KMqRgPUTikav8P
 ssQgPPnKviaKVPqKo9Yw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 16, 2022 at 10:55 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Tue, Aug 16, 2022 at 3:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Aug 15, 2022 at 2:48 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > +
> > > +static int __init register_generic_subdriver(struct generic_struct *sub_driver)
> > > +{
> > > +       int rc;
> > > +
> > > +       BUG_ON(!sub_driver->acpi);
> > > +
> > > +       sub_driver->acpi->driver = kzalloc(sizeof(struct acpi_driver), GFP_KERNEL);
> > > +       if (!sub_driver->acpi->driver) {
> > > +               pr_err("failed to allocate memory for ibm->acpi->driver\n");
> > > +               return -ENOMEM;
> > > +       }
> >
> > Drivers should be statically allocated. Usually you want one 'struct
> > acpi_driver' or
> > 'struct platform_driver' per file, so you can just use 'module_acpi_driver()'.
> I found that "subdriver" in other laptop drivers also uses dynamical
> allocation, because there may be various numbers of subdrivers. I want
> to keep it, at least in the next version for review.

Fair enough, I'm not that familiar with drivers/platform/ conventions,
so this is
probably fine.  Adding the drivers/platform/x86 maintainers for clarification,
since your driver probably fits best into that general class regardless of the
CPU instruction set.

> > > +static struct generic_acpi_drv_struct ec_event_acpidriver = {
> > > +       .hid = loongson_htk_device_ids,
> > > +       .notify = event_notify,
> > > +       .handle = &hkey_handle,
> > > +       .type = ACPI_DEVICE_NOTIFY,
> > > +};
> >
> > Same here, this can probably just be an input driver in drivers/input.
>
> It seems the existing "laptop drivers" are also complex drivers to
> bind several "subdrivers" together.

Let's see what Hans and Mark think here as well. My feeling is that this
might be a little different. In the other laptop drivers you'd load a
module for a Dell/HP/Lenovo/Asus/Acer/... model and that has all the
bits that this vendor uses across the system, so a single driver makes
sense.

In embedded systems, you'd have SoC specific drivers that we tend
to put into the respective subsystems (backlight, led, input, ...) and
then users pick the drivers they want.

Loongarch is probably somewhere inbetween, since this is a chip
vendor rather than a laptop vendor, but you have all the same bits
here. The question is more about where we put it.

       Arnd
